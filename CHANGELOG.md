## [0.2.2] - 2026-01-27

### Added
- OpenMidnight foundation model
- User-Agent header to download requests

## [0.2.1] - 2025-11-27

### Added
- H0-mini foundation model

### Changed
- Minor change to ranking in leaderboards (same rounded performance = same rank)

### Fixed
- Updated timm version requirements to adjust to keep

## [0.2.0] - 2025-11-16

### Added
- HistAI SPIDER datasets (breast, colorecal, skin, thorax)
- Zero-shot VLM classification task
- DINOv3, GIGAPATH, KAIKO-ViT foundation models
- Option to benchmark a model for a task on a custom dataset
- RandStain transformation for the transformation invariance task
- SPIDER and zero-shot leaderboards + up-to-date rank-sum leaderboard
- Option to divide bracs images into patches when extracting embeddings
- Use-case examples in documentation
- Saving a config file at the end of a benchmark run

### Changed
- Extended support to python versions >=3.10,<3.14
- Updated dependency requirements and replaced setup.py with pyproject.toml
- Loading all embeddings and labels as numpy arrays in dataset init for linear_probing+embedding_pre_loading

### Fixed
- Config setting for probe training with custom model
- Hyper-parameters printing (colors and model name when custom)

## [0.1.1] - 2025-09-01

### Added
- Links to leaderboard, docs, arXiv paper

### Fixed
- Download of *esca*, *tcga_uniform* and *wilds* datasets
- Handling of ignored pixels in dice loss

## [0.1.0] - 2025-07-10

### Added

- First official release
- [Preprint](https://arxiv.org/abs/2507.07860)
