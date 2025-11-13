
# Examples

The general command format for running a benchmark is:
```bash
thunder benchmark <MODEL> <DATASET> <TASK> [OPTIONS]
```

In the following examples, we illustrate how to use THUNDER through both the **command-line interface (CLI)** and the **Python API**.
As example, we will use **Hoptimus1** as the model, **MHIST** as the classification dataset, and **PanNuke** for segmentation.

---

## 1. View Benchmark Help

### **CLI**

```bash
thunder benchmark --help
```

---

## 2. Download Datasets

### **CLI**

```bash
thunder download-datasets mhist pannuke
```

---

## 3. Generate Data Splits

### **CLI**

```bash
thunder generate-data-splits pannuke mhist
```

---

## 4. Download Pretrained Models

### **CLI**

```bash
thunder download-models hoptimus1
```

---

# Benchmarking Examples

Below are examples for multiple tasks using the **Hoptimus1** model.

---

## Pre-computing Embeddings

### **CLI**

```bash
thunder benchmark hoptimus1 mhist pre_computing_embeddings
thunder benchmark hoptimus1 pannuke pre_computing_embeddings

```

### **API**

```python
from thunder import benchmark

benchmark(
    "hoptimus1",
    dataset="mhist",
    task="pre_computing_embeddings",
)

benchmark(
    "hoptimus1",
    dataset="pannuke",
    task="pre_computing_embeddings",
)
```

---

## 6. K-NN Classification

### **CLI**

```bash
thunder benchmark hoptimus1 mhist knn
```

### **API**

```python
from thunder import benchmark

benchmark(
    "hoptimus1",
    dataset="mhist",
    task="knn",
)
```

---

## 7. Linear Probing

Using pre-loaded embeddings.

### **CLI**

```bash
thunder benchmark hoptimus1 mhist linear_probing --loading-mode=embedding_pre_loading
```

### **API**

```python
from thunder import benchmark

benchmark(
    "hoptimus1",
    dataset="mhist",
    task="linear_probing",
    loading_mode="embedding_pre_loading",
)
```

---

## 8. Segmentation (PanNuke)

### **CLI**

```bash
thunder benchmark hoptimus1 pannuke segmentation --loading-mode=embedding_pre_loading
```

### **API**

```python
from thunder import benchmark

benchmark(
    "hoptimus1",
    dataset="pannuke",
    task="segmentation",
    loading_mode="embedding_pre_loading",
)
```

---

## 9. SimpleShot Classification

### **CLI**

```bash
thunder benchmark hoptimus1 mhist simple_shot --loading-mode=embedding_pre_loading
```

### **API**

```python
from thunder import benchmark

benchmark(
    "hoptimus1",
    dataset="mhist",
    task="simple_shot",
    loading_mode="embedding_pre_loading",
)
```

---

## 10. Transformation Invariance

### **CLI**

```bash
thunder benchmark hoptimus1 mhist transformation_invariance
```

### **API**

```python
from thunder import benchmark

benchmark(
    "hoptimus1",
    dataset="mhist",
    task="transformation_invariance",
)
```

---

## 11. Adversarial Attack Robustness

### **CLI**

```bash
thunder benchmark hoptimus1 mhist adversarial_attack
```

### **API**

```python
from thunder import benchmark

benchmark(
    "hoptimus1",
    dataset="mhist",
    task="adversarial_attack",
)
```

---

# 12. Results Summary

### **CLI**

To display all collected benchmark results, simply run the command below after your experiments have finished.

```bash
thunder results-summary
```
