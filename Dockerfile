FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential cmake python3 python3-pip git wget gnupg && \
    rm -rf /var/lib/apt/lists/*

# Install CUDA Toolkit 12.8
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin && \
    mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub -O /tmp/cuda.pub && \
    gpg --dearmor -o /usr/share/keyrings/cuda-archive-keyring.gpg /tmp/cuda.pub && \
    echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /" > /etc/apt/sources.list.d/cuda.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cuda-toolkit-12-8 && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install conan flake8 cpplint pytest && \
    conan profile detect --force

ENV PATH="/usr/local/cuda/bin:${PATH}"

WORKDIR /workspace

CMD ["bash"]
