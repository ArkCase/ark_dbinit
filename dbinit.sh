#!/bin/bash
SCRIPT="$(readlink -f "${BASH_SOURCE:-$0}")"
BASEDIR="$(dirname "${SCRIPT}")"
cd "${BASEDIR}"
source "./dbinit.runner" "000-postgres-database-init-script.sql" postgres WWllZ2h1ViFhaGgwRW9DMQ==