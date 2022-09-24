FROM manylinux2014-cuda:cu117-runtime as base

FROM base as base-amd64

ENV NV_CUDA_LIB_VERSION 11.7.1-1
ENV NV_NVPROF_VERSION 11.7.101-1
ENV NV_NVPROF_DEV_PACKAGE cuda-nvprof-11-7-${NV_NVPROF_VERSION}
ENV NV_CUDA_CUDART_DEV_VERSION 11.7.99-1
ENV NV_NVML_DEV_VERSION 11.7.91-1
ENV NV_LIBCUBLAS_DEV_VERSION 11.10.3.66-1
ENV NV_LIBNPP_DEV_VERSION 11.7.4.75-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-devel-11-7-${NV_LIBNPP_DEV_VERSION}
ENV NV_LIBNCCL_DEV_PACKAGE_NAME libnccl-devel
ENV NV_LIBNCCL_DEV_PACKAGE_VERSION 2.13.4-1
ENV NCCL_VERSION 2.13.4
ENV NV_LIBNCCL_DEV_PACKAGE ${NV_LIBNCCL_DEV_PACKAGE_NAME}-${NV_LIBNCCL_DEV_PACKAGE_VERSION}+cuda11.7



LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN yum install -y \
    make \
    cuda-command-line-tools-11-7-${NV_CUDA_LIB_VERSION} \
    cuda-libraries-devel-11-7-${NV_CUDA_LIB_VERSION} \
    cuda-minimal-build-11-7-${NV_CUDA_LIB_VERSION} \
    cuda-cudart-devel-11-7-${NV_CUDA_CUDART_DEV_VERSION} \
    ${NV_NVPROF_DEV_PACKAGE} \
    cuda-nvml-devel-11-7-${NV_NVML_DEV_VERSION} \
    libcublas-devel-11-7-${NV_LIBCUBLAS_DEV_VERSION} \
    ${NV_LIBNPP_DEV_PACKAGE} \
    ${NV_LIBNCCL_DEV_PACKAGE} \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs
