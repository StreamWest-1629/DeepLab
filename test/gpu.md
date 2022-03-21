---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.13.7
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

# GPU情報の確認


パッケージを追加し，CUDAが使えるかどうかを確認する

```python
import torch

print(f"cuda is available: {torch.cuda.is_available()}")
```

GPUデバイスの数と現在のデバイスを確認する

```python
print(
    f"cuda devices: {torch.cuda.device_count()} (current device index: {torch.cuda.current_device()})"
)
```

現在のGPUについての情報を確認する

```python
print(f"current device name: {torch.cuda.get_device_name()}")
print(f"current device capability: {torch.cuda.get_device_capability()}")
```
