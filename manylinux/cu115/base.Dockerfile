FROM quay.io/pypa/manylinux2014_x86_64

ENV NVARCH x86_64
ENV NVIDIA_REQUIRE_CUDA "cuda>=11.5 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441 brand=tesla,driver>=450,driver<451"
ENV NV_CUDA_CUDART_VERSION 11.5.50-1

COPY cuda.repo-x86_64 /etc/yum.repos.d/cuda.repo

LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN NVIDIA_GPGKEY_SUM=d0664fbbdb8c32356d45de36c5984617217b2d0bef41b93ccecd326ba3b80c87 && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel7/${NVARCH}/D42D0685.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA && \
    echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -

ENV CUDA_VERSION 11.5.0

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN yum upgrade -y && yum install -y \
    cuda-cudart-11-5-${NV_CUDA_CUDART_VERSION} \
    cuda-compat-11-5 devtoolset-9 \
    && ln -s cuda-11.5 /usr/local/cuda \
    && yum clean all \
    && rm -rf /var/cache/yum/*
RUN echo "source scl_source enable devtoolset-9" >> /etc/bashrc
RUN source /etc/bashrc

# nvidia-docker 1.0
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

COPY NGC-DL-CONTAINER-LICENSE /

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
