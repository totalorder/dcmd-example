ARG DCMD_BASE_ARG="totalorder/dcmd-alpine:latest"
FROM ${DCMD_BASE_ARG}

ARG DCMD_BASE_ARG="totalorder/dcmd-alpine:latest"
ARG DCMD_IMAGE_ARG="totalorder/dcmd-example-alpine:latest"

# Support installing dependencies in both alpine and ubuntu
RUN bash -c 'if [[ "${DCMD_BASE_ARG}" == *"-alpine"* ]]; then apk add --no-cache curl openssh-client; else exit 0; fi'
RUN bash -c 'if [[ "${DCMD_BASE_ARG}" == *"-bionic"* ]]; then apt update && apt install -y curl openssh-client; else exit 0; fi'
ARG DOCKER_CLIENT_VERSION="18.09.7"
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_CLIENT_VERSION}.tgz \
  && tar xzvf docker-${DOCKER_CLIENT_VERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKER_CLIENT_VERSION}.tgz

ENV DCMD_NAME="exa"
ENV DCMD_IMAGE="${DCMD_IMAGE_ARG}"
COPY dcmd /dcmd

ARG DCMD_VERSION="unknown"
RUN echo "${DCMD_VERSION}" > /.version
