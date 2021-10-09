docker build -f base.Dockerfile -t manylinux-cuda:11.4.2-runtime . && \
docker build -f devel.Dockerfile -t manylinux-cuda:11.4.2-devel . 
