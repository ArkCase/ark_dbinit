FROM rockylinux:8

#
# Basic Parameters
#
ARG ARCH="amd64"
ARG OS="linux"
ARG VER="1.0.0"
ARG PKG="dbinit"
ARG UID="0"

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
    yum -y update && \
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

COPY init-db /
COPY dbscripts /

#
# Final parameters
#
WORKDIR     /
USER        "${UID}"
ENTRYPOINT  [ "/init-db" ]
