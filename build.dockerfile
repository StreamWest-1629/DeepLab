FROM streamwest1629/deeplab:latest-torch

# Install python libraries
RUN git config --global --add safe.directory '*'
ADD requirements.txt requirements.txt
RUN --mount=type=cache,target=/root/.cache/pip \
    python3 -m pip install -r requirements.txt
ADD ./scripts /entrypoint/scripts
RUN chmod +x /entrypoint/scripts/start.sh
