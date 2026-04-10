#!/usr/bin/env bash
set -euo pipefail

die() {
  echo "Error: $*" >&2
  exit 1
}

canonical_dataset() {
  local dataset="${1,,}"
  dataset="${dataset//[[:space:]]/}"
  dataset="${dataset//-/_}"
  dataset="${dataset//./}"
  case "$dataset" in
    breakhis|break_his)
      echo "break_his"
      ;;
    *)
      echo "$dataset"
      ;;
  esac
}

canonical_task() {
  local task="${1,,}"
  task="${task//[[:space:]]/}"
  task="${task//-/_}"
  task="${task//./}"
  case "$task" in
    linear|linearprobe|linear_probe|linear_probing|calib|calibration)
      echo "linear_probing"
      ;;
    knn)
      echo "knn"
      ;;
    few|fewshot|few_shot|simple|simple_shot)
      echo "simple_shot"
      ;;
    seg|segmentation)
      echo "segmentation"
      ;;
    attack|adv|adversarial|adversarial_attack)
      echo "adversarial_attack"
      ;;
    retrieval|image_retrieval)
      echo "image_retrieval"
      ;;
    alignment|alignment_scoring)
      echo "alignment_scoring"
      ;;
    precompute|precomputing|pre_computing_embeddings|precomp|embeddings)
      echo "pre_computing_embeddings"
      ;;
    transform|transformation_invariance)
      echo "transformation_invariance"
      ;;
    zero_shot|zero_shot_vlm|zeroshot)
      echo "zero_shot_vlm"
      ;;
    *)
      die "Unsupported task '$1'"
      ;;
  esac
}

quoted_command() {
  local line=""
  local arg
  for arg in "$@"; do
    printf -v arg '%q' "$arg"
    line+="$arg "
  done
  printf '%s' "${line% }"
}

usage() {
  cat <<'EOF'
Usage:
  scripts/submit_openmidnight_thunder.sh --ckpt /data/OpenMidnight_ckpts/openmidnight_checkpoint.pth --dataset bach --task linear
  scripts/submit_openmidnight_thunder.sh --ckpt /data/OpenMidnight_ckpts/openmidnight_checkpoint.pth --datasets bach,bracs,breakhis --tasks linear,knn,fewshot --parallel-datasets 3

This script is intentionally opinionated:
- datasets come from /block/eva-data when present
- missing datasets are downloaded to /block/thunder-data/<dataset>
- runs live under tmp/
- final metrics summaries live under thunder_outputs/
- jobs always request 1x H100 80GB on partition main
- linear probing always runs as:
    pre_computing_embeddings
    linear_probing --loading-mode=embedding_pre_loading

Task aliases:
  linear calib -> linear_probing
  knn -> knn
  few fewshot -> simple_shot
  attack adv -> adversarial_attack
  retrieval -> image_retrieval
  alignment -> alignment_scoring
  precompute -> pre_computing_embeddings
  transform -> transformation_invariance
  zero_shot -> zero_shot_vlm
  segmentation -> segmentation

Args:
  --ckpt PATH
  --dataset NAME
  --datasets A,B,C
  --task NAME
  --tasks A,B,C
  --parallel-datasets N
  --time HH:MM:SS
  --recomp-embs
  --retrain-model
  --dry-run
  -h --help
EOF
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
venv_activate="$repo_root/.venv/bin/activate"
dinov2_repo="/admin/home/paul/dinov2_official"
runtime_parent="/tmp/openmidnight"
summary_dir="$repo_root/thunder_outputs"
local_data_root="/block/eva-data"
download_data_root="/block/thunder-data"
download_staging_root="$download_data_root/.thunder-download-tmp"
partition="main"
gres="gpu:nvidia_h100_80gb_hbm3:1"
cpus_per_task="16"
time_limit="08:00:00"
job_name="thunder-openmidnight"

ckpt_path=""
parallel_datasets=1
recomp_embs=0
retrain_model=0
dry_run=0
declare -a datasets=()
declare -a tasks=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ckpt)
      [[ $# -ge 2 ]] || die "--ckpt requires a value"
      ckpt_path="$2"
      shift 2
      ;;
    --dataset)
      [[ $# -ge 2 ]] || die "--dataset requires a value"
      datasets+=("$(canonical_dataset "$2")")
      shift 2
      ;;
    --datasets)
      [[ $# -ge 2 ]] || die "--datasets requires a value"
      IFS=',' read -r -a raw_datasets <<< "$2"
      for item in "${raw_datasets[@]}"; do
        item="$(canonical_dataset "$item")"
        [[ -n "$item" ]] || continue
        datasets+=("$item")
      done
      shift 2
      ;;
    --task|--probe)
      [[ $# -ge 2 ]] || die "$1 requires a value"
      tasks+=("$(canonical_task "$2")")
      shift 2
      ;;
    --tasks|--probes)
      [[ $# -ge 2 ]] || die "$1 requires a value"
      IFS=',' read -r -a raw_tasks <<< "$2"
      for item in "${raw_tasks[@]}"; do
        item="$(canonical_task "$item")"
        [[ -n "$item" ]] || continue
        tasks+=("$item")
      done
      shift 2
      ;;
    --parallel-datasets)
      [[ $# -ge 2 ]] || die "--parallel-datasets requires a value"
      [[ "$2" =~ ^[1-9][0-9]*$ ]] || die "--parallel-datasets expects a positive integer"
      parallel_datasets="$2"
      shift 2
      ;;
    --time)
      [[ $# -ge 2 ]] || die "--time requires a value"
      time_limit="$2"
      shift 2
      ;;
    --recomp-embs)
      recomp_embs=1
      shift
      ;;
    --retrain-model)
      retrain_model=1
      shift
      ;;
    --dry-run)
      dry_run=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument '$1'"
      ;;
  esac
done

[[ -n "$ckpt_path" ]] || die "Missing required --ckpt"
[[ ${#datasets[@]} -gt 0 ]] || die "Provide at least one dataset"
[[ ${#tasks[@]} -gt 0 ]] || die "Provide at least one task"
[[ -f "$ckpt_path" ]] || die "Checkpoint not found: $ckpt_path"
[[ -f "$venv_activate" ]] || die "Missing THUNDER venv: $venv_activate"
[[ -f "$dinov2_repo/dinov2/hub/__init__.py" ]] || die "Missing DINOv2 repo: $dinov2_repo"

declare -A seen=()
deduped=()
for dataset in "${datasets[@]}"; do
  if [[ -z "${seen[$dataset]+x}" ]]; then
    seen["$dataset"]=1
    deduped+=("$dataset")
  fi
done
datasets=("${deduped[@]}")

unset seen
declare -A seen=()
deduped=()
for task in "${tasks[@]}"; do
  if [[ -z "${seen[$task]+x}" ]]; then
    seen["$task"]=1
    deduped+=("$task")
  fi
done
tasks=("${deduped[@]}")
unset seen
unset deduped

ckpt_path="$(realpath "$ckpt_path")"
runtime_parent="$(realpath -m "$runtime_parent")"
summary_dir="$(realpath -m "$summary_dir")"
local_data_root="$(realpath -m "$local_data_root")"
download_data_root="$(realpath -m "$download_data_root")"
download_staging_root="$(realpath -m "$download_staging_root")"

ckpt_slug="$(basename "$ckpt_path")"
ckpt_slug="${ckpt_slug%.*}"
ckpt_slug="${ckpt_slug,,}"
ckpt_slug="$(printf '%s' "$ckpt_slug" | sed -E 's#[^a-z0-9._-]+#-#g; s#-+#-#g; s#(^-|-$)##g')"
ckpt_hash="$(stat -Lc '%n:%s:%Y' "$ckpt_path" | sha1sum | cut -c1-12)"
runtime_prefix="$runtime_parent/${ckpt_slug}-${ckpt_hash}"
summary_prefix="${ckpt_slug}-${ckpt_hash}"
slurm_job_dir="$summary_dir/slurm-jobs"
slurm_log_dir="$summary_dir/slurm-logs"

mkdir -p \
  "$summary_dir" \
  "$slurm_job_dir" \
  "$slurm_log_dir"

declare -A dataset_paths=()

for dataset in "${datasets[@]}"; do
  dataset_cfg="$repo_root/src/thunder/config/dataset/${dataset}.yaml"
  [[ -f "$dataset_cfg" ]] || die "No THUNDER dataset config for '$dataset'"
  for task in "${tasks[@]}"; do
    if ! grep -Fq "\"$task\"" "$dataset_cfg"; then
      die "Dataset '$dataset' does not support task '$task'. See $dataset_cfg"
    fi
  done
done

for dataset in "${datasets[@]}"; do
  dataset_path=""
  candidate_names=("$dataset")
  if [[ "$dataset" == "break_his" ]]; then
    candidate_names+=("breakhis")
  fi

  for name in "${candidate_names[@]}"; do
    for candidate in "$local_data_root/$name" "$local_data_root/datasets/$name"; do
      if [[ -e "$candidate" ]]; then
        dataset_path="$(realpath "$candidate")"
        break 2
      fi
    done
  done

  if [[ -z "$dataset_path" && -e "$download_data_root/datasets/$dataset" && ! -e "$download_data_root/$dataset" ]]; then
    mv "$download_data_root/datasets/$dataset" "$download_data_root/$dataset"
    rmdir "$download_data_root/datasets" 2>/dev/null || true
  fi

  if [[ -z "$dataset_path" ]]; then
    for name in "${candidate_names[@]}"; do
      for candidate in "$download_data_root/$name" "$download_data_root/datasets/$name"; do
        if [[ -e "$candidate" ]]; then
          dataset_path="$(realpath "$candidate")"
          break 2
        fi
      done
    done
  fi

  if [[ -z "$dataset_path" ]]; then
    echo "Dataset '$dataset' not found under '$local_data_root'. Downloading to '$download_data_root/$dataset'."
    mkdir -p "$download_data_root"
    # shellcheck disable=SC1090
    source "$venv_activate"
    export THUNDER_BASE_DATA_FOLDER="$download_staging_root"
    (
      cd "$repo_root"
      thunder download-datasets "$dataset"
    )
    if [[ -e "$download_staging_root/datasets/$dataset" ]]; then
      [[ ! -e "$download_data_root/$dataset" ]] || die "Both '$download_staging_root/datasets/$dataset' and '$download_data_root/$dataset' exist"
      mv "$download_staging_root/datasets/$dataset" "$download_data_root/$dataset"
    elif [[ -e "$download_data_root/datasets/$dataset" ]]; then
      [[ ! -e "$download_data_root/$dataset" ]] || die "Both '$download_data_root/datasets/$dataset' and '$download_data_root/$dataset' exist"
      mv "$download_data_root/datasets/$dataset" "$download_data_root/$dataset"
    fi
    rmdir "$download_staging_root/datasets" 2>/dev/null || true
    rmdir "$download_staging_root" 2>/dev/null || true
    rmdir "$download_data_root/datasets" 2>/dev/null || true
    dataset_path="$(realpath "$download_data_root/$dataset")"
  fi

  [[ -n "$dataset_path" ]] || die "Dataset '$dataset' is unavailable"
  rm -f "$dataset_path/content"
  dataset_paths["$dataset"]="$dataset_path"
done

old_ifs="$IFS"
IFS=,
dataset_csv="${datasets[*]}"
task_csv="${tasks[*]}"
IFS="$old_ifs"

job_stamp="$(date -u +%Y%m%dT%H%M%SZ)"
job_script="$slurm_job_dir/thunder-openmidnight-${job_stamp}.sbatch"
{
  echo "#!/usr/bin/env bash"
  echo "set -euo pipefail"
  echo "set -x"
  printf 'runtime_dir="%s-${SLURM_JOB_ID:-none}"\n' "$runtime_prefix"
  printf 'summary_file="%s/%s-${SLURM_JOB_ID:-none}.json"\n' "$summary_dir" "$summary_prefix"
  printf 'timings_file="%s/%s-${SLURM_JOB_ID:-none}.timings.tsv"\n' "$slurm_log_dir" "$summary_prefix"
  echo 'mkdir -p "$runtime_dir/datasets" "$runtime_dir/slurm-logs" "$runtime_dir/slurm-jobs"'
  echo 'export THUNDER_BASE_DATA_FOLDER="$runtime_dir"'
  echo 'export THUNDER_SUMMARY_FILE="$summary_file"'
  echo 'export THUNDER_TIMINGS_FILE="$timings_file"'
  printf 'export THUNDER_REQUESTED_DATASETS=%q\n' "$dataset_csv"
  printf 'export THUNDER_REQUESTED_TASKS=%q\n' "$task_csv"
  printf 'export THUNDER_CHECKPOINT_PATH=%q\n' "$ckpt_path"
  printf 'export PYTHONPATH=%q:${PYTHONPATH:-}\n' "$dinov2_repo"
  echo 'export PYTHONUNBUFFERED=1'
  printf 'source %q\n' "$venv_activate"
  printf 'cd %q\n' "$repo_root"
  echo 'echo "SLURM_JOB_ID=${SLURM_JOB_ID:-none}"'
  echo 'echo "THUNDER_BASE_DATA_FOLDER=$THUNDER_BASE_DATA_FOLDER"'
  echo 'nvidia-smi'
  echo ': > "$THUNDER_TIMINGS_FILE"'
  cat <<'EOF'
run_timed() {
  local dataset="$1"
  local task="$2"
  local start_ms end_ms status
  shift 2
  start_ms="$(date +%s%3N)"
  if "$@"; then
    status=0
  else
    status=$?
  fi
  end_ms="$(date +%s%3N)"
  printf '%s\t%s\t%s\t%s\t%s\n' "$dataset" "$task" "$start_ms" "$end_ms" "$status" >> "$THUNDER_TIMINGS_FILE"
  return "$status"
}
EOF
} > "$job_script"

for dataset in "${datasets[@]}"; do
  printf 'ln -s %q "$runtime_dir/datasets/%s"\n' "${dataset_paths[$dataset]}" "$dataset" >> "$job_script"
done
printf '%s\n' "$(quoted_command thunder generate-data-splits "${datasets[@]}")" >> "$job_script"

declare -a linear_labels=()
declare -a linear_commands=()

for dataset in "${datasets[@]}"; do
  need_precompute=0
  need_linear=0

  for task in "${tasks[@]}"; do
    case "$task" in
      pre_computing_embeddings)
        need_precompute=1
        ;;
      linear_probing)
        need_precompute=1
        need_linear=1
        ;;
      adversarial_attack)
        need_precompute=1
        need_linear=1
        ;;
    esac
  done

  if [[ "$need_precompute" -eq 1 ]]; then
    cmd=(
      thunder benchmark openmidnight "$dataset" pre_computing_embeddings
      --pretrained_model.ckpt_path "$ckpt_path"
    )
    if [[ "$recomp_embs" -eq 1 ]]; then
      cmd+=(--recomp-embs)
    fi
    printf '%s\n' "$(quoted_command run_timed "$dataset" pre_computing_embeddings "${cmd[@]}")" >> "$job_script"
  fi

  if [[ "$need_linear" -eq 1 ]]; then
    cmd=(
      thunder benchmark openmidnight "$dataset" linear_probing
      --loading-mode=embedding_pre_loading
      --pretrained_model.ckpt_path "$ckpt_path"
    )
    if [[ "$retrain_model" -eq 1 ]]; then
      cmd+=(--retrain-model)
    fi
    linear_labels+=("${dataset}-linear_probing")
    linear_commands+=("$(quoted_command run_timed "$dataset" linear_probing "${cmd[@]}")")
  fi
done

if [[ ${#linear_commands[@]} -gt 0 ]]; then
  if [[ "$parallel_datasets" -gt 1 && ${#linear_commands[@]} -gt 1 ]]; then
    {
      echo 'parallel_log_dir="$THUNDER_BASE_DATA_FOLDER/slurm-logs/parallel-${SLURM_JOB_ID:-none}"'
      echo 'mkdir -p "$parallel_log_dir"'
      echo 'pids=()'
      echo 'labels=()'
      echo 'wait_group() {'
      echo '  local i rc'
      echo '  for i in "${!pids[@]}"; do'
      echo '    if wait "${pids[$i]}"; then'
      echo '      echo "Completed ${labels[$i]}"'
      echo '    else'
      echo '      rc=$?'
      echo '      echo "Failed ${labels[$i]} with exit code $rc" >&2'
      echo '      for pid in "${pids[@]}"; do'
      echo '        kill "$pid" 2>/dev/null || true'
      echo '      done'
      echo '      wait || true'
      echo '      exit "$rc"'
      echo '    fi'
      echo '  done'
      echo '  pids=()'
      echo '  labels=()'
      echo '}'
      echo 'echo "Parallel linear logs: $parallel_log_dir"'
    } >> "$job_script"

    batch_size=0
    for i in "${!linear_commands[@]}"; do
      label="${linear_labels[$i]}"
      line="${linear_commands[$i]}"
      {
        echo '('
        echo '  set -euo pipefail'
        echo '  set -o pipefail'
        printf "  %s 2>&1 | sed -u 's/^/[%s] /' | tee \"\$parallel_log_dir/%s.log\"\n" "$line" "$label" "$label"
        echo ') &'
        echo 'pids+=("$!")'
        printf 'labels+=(%q)\n' "$label"
      } >> "$job_script"
      batch_size=$((batch_size + 1))
      if [[ "$batch_size" -eq "$parallel_datasets" ]]; then
        echo 'wait_group' >> "$job_script"
        batch_size=0
      fi
    done
    if [[ "$batch_size" -gt 0 ]]; then
      echo 'wait_group' >> "$job_script"
    fi
  else
    for line in "${linear_commands[@]}"; do
      printf '%s\n' "$line" >> "$job_script"
    done
  fi
fi

for dataset in "${datasets[@]}"; do
  for task in "${tasks[@]}"; do
    case "$task" in
      pre_computing_embeddings|linear_probing)
        continue
        ;;
    esac

    cmd=(
      thunder benchmark openmidnight "$dataset" "$task"
      --pretrained_model.ckpt_path "$ckpt_path"
    )
    printf '%s\n' "$(quoted_command run_timed "$dataset" "$task" "${cmd[@]}")" >> "$job_script"
  done
done

cat >> "$job_script" <<'EOF'
python - <<'PY'
import json
import os
from datetime import datetime, timezone
from pathlib import Path

import torch
from thunder.models.pretrained_models import _normalize_openmidnight_checkpoint

runtime_dir = Path(os.environ["THUNDER_BASE_DATA_FOLDER"])
summary_file = Path(os.environ["THUNDER_SUMMARY_FILE"])
share_file = summary_file.with_suffix(".txt")
timings_file = Path(os.environ["THUNDER_TIMINGS_FILE"])
datasets = [item for item in os.environ["THUNDER_REQUESTED_DATASETS"].split(",") if item]
tasks = [item for item in os.environ["THUNDER_REQUESTED_TASKS"].split(",") if item]
checkpoint_path = os.environ["THUNDER_CHECKPOINT_PATH"]

def format_duration(seconds):
    total_seconds = max(0, int(round(seconds)))
    hours, rem = divmod(total_seconds, 3600)
    minutes, secs = divmod(rem, 60)
    return f"{hours:02d}:{minutes:02d}:{secs:02d}"

def metric_tree(node):
    if isinstance(node, dict):
        if "metric_score" in node:
            return node["metric_score"]
        out = {}
        for key, value in node.items():
            metric_value = metric_tree(value)
            if metric_value is not None:
                out[key] = metric_value
        if out:
            return out
    return None

checkpoint = _normalize_openmidnight_checkpoint(
    torch.load(checkpoint_path, map_location="cpu")
)
embed_dim = checkpoint["pos_embed"].shape[-1]
model_names = {
    384: ("ViT-small", "vits14"),
    768: ("ViT-base", "vitb14"),
    1024: ("ViT-large", "vitl14"),
    1536: ("ViT-giant", "vitg14"),
}
model_size, model_code = model_names[embed_dim]
if "register_tokens" in checkpoint and checkpoint["register_tokens"].shape[1] > 0:
    model_code = f"{model_code}_reg"
model_label = f"OpenMidnight {model_size} ({model_code.removesuffix('_reg')})"

task_timings = {}
dataset_duration_seconds = {}
if timings_file.exists():
    for line in timings_file.read_text().splitlines():
        if not line:
            continue
        dataset, task, start_ms, end_ms, exit_code = line.split("\t")
        duration_seconds = max(0.0, (int(end_ms) - int(start_ms)) / 1000.0)
        dataset_duration_seconds[dataset] = dataset_duration_seconds.get(dataset, 0.0) + duration_seconds
        task_timings.setdefault(dataset, {})[task] = {
            "duration_hms": format_duration(duration_seconds),
            "exit_code": int(exit_code),
        }

results = {}
f1_scores = {}
for dataset in datasets:
    results[dataset] = {}
    for task in tasks:
        outputs_json = runtime_dir / "outputs" / "res" / dataset / "openmidnight" / task / "frozen" / "outputs.json"
        entry = {}
        timing = task_timings.get(dataset, {}).get(task)
        if timing:
            entry["duration_hms"] = timing["duration_hms"]
        if timing and timing["exit_code"] != 0:
            entry["exit_code"] = timing["exit_code"]
        if outputs_json.exists():
            entry["status"] = "ok"
            metrics = metric_tree(json.loads(outputs_json.read_text()))
            entry["metrics"] = metrics
            if task == "linear_probing" and metrics and "f1" in metrics:
                f1_scores[dataset] = metrics["f1"]
        else:
            entry["status"] = "missing"
        results[dataset][task] = entry

share_lines = [f"__{model_label}__"]
for dataset in datasets:
    if dataset not in f1_scores:
        continue
    score = f"{f1_scores[dataset]:.4f}"
    if score.startswith("0"):
        score = score[1:]
    share_lines.append(f"{dataset} {score}")
share_text = "\n".join(share_lines)

summary = {
    "created_at_utc": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
    "slurm_job_id": os.environ.get("SLURM_JOB_ID"),
    "checkpoint_path": checkpoint_path,
    "model_label": model_label,
    "datasets": datasets,
    "tasks": tasks,
    "dataset_durations_hms": {
        dataset: format_duration(dataset_duration_seconds[dataset])
        for dataset in datasets
        if dataset in dataset_duration_seconds
    },
    "task_durations_hms": {
        dataset: {
            task: task_timings[dataset][task]["duration_hms"]
            for task in tasks
            if dataset in task_timings and task in task_timings[dataset]
        }
        for dataset in datasets
        if dataset in task_timings
    },
    "f1_scores": f1_scores,
    "results": results,
    "share_text": share_text,
    "share_file": str(share_file),
}
summary_file.parent.mkdir(parents=True, exist_ok=True)
summary_file.write_text(json.dumps(summary, indent=2) + "\n")
share_file.write_text(share_text + "\n")
print(f"Wrote THUNDER metrics summary to {summary_file}")
print(f"Wrote THUNDER share summary to {share_file}")
PY
EOF

chmod +x "$job_script"

sbatch_cmd=(
  sbatch
  --parsable
  --partition "$partition"
  --nodes 1
  --ntasks 1
  --cpus-per-task "$cpus_per_task"
  --time "$time_limit"
  --gres "$gres"
  --job-name "$job_name"
  --output "$slurm_log_dir/%x-%j.out"
  --error "$slurm_log_dir/%x-%j.err"
  "$job_script"
)

echo "THUNDER runtime prefix: $runtime_prefix"
echo "Generated job script: $job_script"
echo "Metrics summary template: $summary_dir/${summary_prefix}-"'${SLURM_JOB_ID:-none}.json'

if [[ "$dry_run" -eq 1 ]]; then
  echo
  echo "Dry run. Would submit:"
  printf '  %q' "${sbatch_cmd[@]}"
  echo
  echo
  echo "----- job script -----"
  cat "$job_script"
  exit 0
fi

job_id="$("${sbatch_cmd[@]}")"
runtime_dir="${runtime_prefix}-${job_id}"
summary_file="$summary_dir/${summary_prefix}-${job_id}.json"
timings_file="$slurm_log_dir/${summary_prefix}-${job_id}.timings.tsv"
echo "Submitted Slurm job ${job_id}"
echo "THUNDER runtime dir: $runtime_dir"
echo "Metrics summary file: $summary_file"
echo "Share summary file: ${summary_file%.json}.txt"
echo "Timings file: $timings_file"
echo "Logs: $slurm_log_dir"
