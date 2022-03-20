# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:percent
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.13.7
#   kernelspec:
#     display_name: Python 3 (ipykernel)
#     language: python
#     name: python3
# ---

# %% [markdown]
# # GPU情報の確認

# %% [markdown]
# パッケージを追加し，CUDAが使えるかどうかを確認する

# %%
import torch

print(f"cuda is available: {torch.cuda.is_available()}")

# %% [markdown]
# GPUデバイスの数と現在のデバイスを確認する

# %%
print(
    f"cuda devices: {torch.cuda.device_count()} (current device index: {torch.cuda.current_device()})"
)

# %% [markdown]
# 現在のGPUについての情報を確認する

# %%
print(f"current device name: {torch.cuda.get_device_name()}")
print(f"current device capability: {torch.cuda.get_device_capability()}")
