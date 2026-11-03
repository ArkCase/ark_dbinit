#
# Basic Parameters
#
ARG FIPS=""
ARG PUBLIC_REGISTRY="public.ecr.aws"
ARG ARCH="amd64"
ARG OS="linux"
ARG VER="1.2.0"
ARG PKG="dbinit"
ARG APP_UID="0"

ARG BASE_REGISTRY="${PUBLIC_REGISTRY}"
ARG BASE_REPO="arkcase/base"
ARG BASE_VER="24.04"
ARG BASE_VER_PFX=""
ARG BASE_IMG="${BASE_REGISTRY}/${BASE_REPO}${FIPS}:${BASE_VER_PFX}${BASE_VER}"

FROM "${BASE_IMG}"

ARG VER
ARG APP_UID

#
# Some important labels
#
LABEL ORG="Armedia LLC"
LABEL MAINTAINER="Armedia Devops Team <devops@armedia.com>"
LABEL APP="Database Initializer"
LABEL VERSION="${VER}"
LABEL IMAGE_SOURCE="https://github.com/ArkCase/ark_dbinit"

ENV INIT_DB_STORE="/scripts"
ENV INIT_DB_SECRETS="/secrets"

RUN --mount=type=bind,target=/src \
    install -o root -o root -m 0755 /src/entrypoint /usr/local/bin && \
    mkdir -p /sources && \
    ( tar --owner=root --group=root --mode=u=rwX,g=rX -cf - /src/sources ) | tar --strip-components=2 -C /sources -xvf -

#
# Final parameters
#
WORKDIR     /
USER        "${APP_UID}"
