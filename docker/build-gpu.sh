#!/bin/bash

#PLATFORMS="linux/amd64,linux/arm64"
PLATFORMS="linux/amd64"

set -e
set -x

docker buildx build ${PLATFORMS:+--platform ${PLATFORMS}} --build-arg KALDI_MKL=0 --file Dockerfile.kaldi-vosk-server-gpu --tag ghcr.io/double16/kaldi-vosk-server-gpu:latest .
docker buildx build ${PLATFORMS:+--platform ${PLATFORMS}} --file Dockerfile.kaldi-en-gpu --tag ghcr.io/double16/kaldi-en-gpu:latest .

docker push ghcr.io/double16/kaldi-vosk-server-gpu:latest
docker push ghcr.io/double16/kaldi-en-gpu:latest
