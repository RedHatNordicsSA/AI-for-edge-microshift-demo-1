#!/usr/bin/env bash

# Source: https://danmanners.com/posts/2022-01-buildah-multi-arch/

# Set your manifest name
export MANIFEST_NAME="model-container-test"

# Set the required variables
export BUILD_PATH="."
export REGISTRY="quay.io"
export USER="rbohne"
export IMAGE_NAME="content-container"
export IMAGE_TAG="latest"



# Create a multi-architecture manifest
buildah manifest create ${MANIFEST_NAME}

# Build your amd64 architecture container
buildah bud \
    --tag "${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}" \
    --manifest ${MANIFEST_NAME} \
    --arch amd64 \
    ${BUILD_PATH}

# Build your arm64 architecture container
buildah bud \
    --tag "${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}" \
    --manifest ${MANIFEST_NAME} \
    --arch arm64 \
    ${BUILD_PATH}

# Push the full manifest, with both CPU Architectures
buildah manifest push --all \
    ${MANIFEST_NAME} \
    "docker://${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}"
