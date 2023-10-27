#
# Basic Parameters
#
ARG PUBLIC_REGISTRY="public.ecr.aws"
ARG ARCH="amd64"
ARG OS="linux"
ARG VER="1.1.0"
ARG PKG="dbinit"
ARG UID="0"

ARG BASE_REPO="arkcase/base"
ARG BASE_VER="8"
ARG BASE_IMG="${PUBLIC_REGISTRY}/${BASE_REPO}:${BASE_VER}"

FROM "${BASE_IMG}"

#
# Some important labels
#
LABEL ORG="Armedia LLC"
LABEL MAINTAINER="Armedia Devops Team <devops@armedia.com>"
LABEL APP="Database Initializer"
LABEL VERSION="${VER}"
LABEL IMAGE_SOURCE="https://github.com/ArkCase/ark_dbinit"

ENV INIT_DB_STORE "/dbinit"
ENV INIT_DB_SECRETS "/dbsecrets"

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
COPY dbscripts/* /dbscripts/

#
# Final parameters
#
WORKDIR     /
USER        "${UID}"
ENTRYPOINT  [ "/entrypoint" ]
