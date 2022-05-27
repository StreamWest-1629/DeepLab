FROM streamwest1629/deeplab:latest-base

RUN \
    # Install ML Library
    --mount=type=cache,target=/root/.cache/pip \
    python3 -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113 && \
    python3 -m pip install torchmetrics tensorboard sklearn
