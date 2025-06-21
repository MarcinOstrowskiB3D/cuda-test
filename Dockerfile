FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential cmake python3 python3-pip git && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install conan~=2.0 flake8 cpplint pytest

WORKDIR /workspace

CMD ["bash"]
