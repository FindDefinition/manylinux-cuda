FROM manylinux2014-cuda:cu118-runtime as base

FROM base as base-amd64

ENV NV_CUDA_LIB_VERSION 11.8.0-1
ENV NV_NVPROF_VERSION 11.8.87-1
ENV NV_NVPROF_DEV_PACKAGE cuda-nvprof-11-8-${NV_NVPROF_VERSION}
ENV NV_CUDA_CUDART_DEV_VERSION 11.8.89-1
ENV NV_NVML_DEV_VERSION 11.8.86-1
ENV NV_LIBCUBLAS_DEV_VERSION 11.11.3.6-1
ENV NV_LIBNPP_DEV_VERSION 11.8.0.86-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-devel-11-8-${NV_LIBNPP_DEV_VERSION}


LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN yum install -y \
    make \
    cuda-command-line-tools-11-8-${NV_CUDA_LIB_VERSION} \
    cuda-libraries-devel-11-8-${NV_CUDA_LIB_VERSION} \
    cuda-minimal-build-11-8-${NV_CUDA_LIB_VERSION} \
    cuda-cudart-devel-11-8-${NV_CUDA_CUDART_DEV_VERSION} \
    ${NV_NVPROF_DEV_PACKAGE} \
    cuda-nvml-devel-11-8-${NV_NVML_DEV_VERSION} \
    libcublas-devel-11-8-${NV_LIBCUBLAS_DEV_VERSION} \
    ${NV_LIBNPP_DEV_PACKAGE} \
    && yum clean all \
    && rm -rf /var/cache/yum/*


ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs
