#
# Basic Parameters
#
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
ARG BASE_IMG="${BASE_REGISTRY}/${BASE_REPO}:${BASE_VER_PFX}${BASE_VER}"

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

COPY --chown=root:root --chmod=0755 entrypoint /
COPY --chown=root:root --chmod=0755 init-db /usr/local/bin/
COPY --chown=root:root --chmod=0755 sources/* /sources/

#
# Final parameters
#
WORKDIR     /
USER        "${APP_UID}"
ENTRYPOINT  [ "/entrypoint" ]
