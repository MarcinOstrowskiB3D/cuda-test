FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential cmake python3 python3-pip git && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install conan flake8 cpplint pytest && \
    conan profile detect --force

WORKDIR /workspace

CMD ["bash"]
