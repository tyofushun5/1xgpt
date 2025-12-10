FROM nvcr.io/nvidia/pytorch:23.09-py3

WORKDIR /workspace/1xgpt

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        build-essential \
        ninja-build \
        ffmpeg && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir -r requirements.txt && \
    FLASH_ATTENTION_SKIP_CUDA_BUILD=TRUE python3 -m pip install --no-cache-dir flash-attn==2.5.8 --no-build-isolation

COPY . .

ENV HF_HOME=/root/.cache/huggingface

CMD ["bash"]
