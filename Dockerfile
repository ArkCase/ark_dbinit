#
# Basic Parameters
#
ARG PUBLIC_REGISTRY="public.ecr.aws"
ARG ARCH="amd64"
ARG OS="linux"
ARG VER="1.2.0"
ARG PKG="dbinit"
ARG UID="0"

ARG BASE_REGISTRY="${PUBLIC_REGISTRY}"
ARG BASE_REPO="arkcase/base"
ARG BASE_VER="8"
ARG BASE_VER_PFX=""
ARG BASE_IMG="${BASE_REGISTRY}/${BASE_REPO}:${BASE_VER_PFX}${BASE_VER}"

FROM "${BASE_IMG}"

ARG VER
ARG UID

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

#
# Full update
#
RUN yum -y install epel-release && \
    yum -y install yum-utils which && \
    yum-config-manager \
        --enable devel \
        --enable powertools && \
    yum -y install \
        jq \
        python39-pyyaml \
        vim \
        wget && \
    update-alternatives --set python /usr/bin/python3.9 && \
    yum -y clean all

COPY entrypoint /
COPY init-db /usr/local/bin/
RUN chmod u=rwx,go=rx /usr/local/bin/init-db /entrypoint
COPY sources/* /sources/

#
# Final parameters
#
WORKDIR     /
USER        "${UID}"
ENTRYPOINT  [ "/entrypoint" ]
