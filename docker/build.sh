#!/bin/bash

#PLATFORMS="linux/amd64,linux/arm64"
PLATFORMS="linux/amd64"

set -e
set -x

docker buildx build ${PLATFORMS:+--platform ${PLATFORMS}} --build-arg KALDI_MKL=0 --file Dockerfile.kaldi-vosk-server --tag ghcr.io/double16/kaldi-vosk-server:latest .

# KINDS="ru en de cn fr es en-in grpc-en en-spk ja hi"
KINDS="en en-spk es"
for kind in ${KINDS}; do
    docker buildx build ${PLATFORMS:+--platform ${PLATFORMS}} --file Dockerfile.kaldi-${kind} --tag ghcr.io/double16/kaldi-${kind}:latest .
done

for kind in vosk-server ${KINDS}; do
    docker push ghcr.io/double16/kaldi-${kind}:latest
done
