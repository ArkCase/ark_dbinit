#!/bin/bash
#
# usage: ${0} script-to-run admin-username [admin-password]
#

SCRIPT="${1}"
ADMIN="${2}"
[ ${#} -lt 3 ] || PASS="${3}"

# For mariadb/mysql, adding the admin password breaks things
# [ -z "${PASS}" ] || export MYSQL_PWD="$(base64 -d <<< "${PASS}")"
echo "Running the script [${SCRIPT}] as [${ADMIN}] ..."
mysql --user="${ADMIN}" < "${SCRIPT}"
