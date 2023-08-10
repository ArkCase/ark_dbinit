#!/bin/bash
#
# usage: ${0} script-to-run admin-username [admin-password]
#

case "${MYSQL_DATADIR_FIRST_INIT,,}" in
	true | t | yes | y | 1 | en | enable | enabled ) INITIALIZED="true" ;;
	* ) INITIALIZED="false" ;;
esac

if ! "${INITIALIZED}" ; then
	echo "The database is already initialized, will not re-initialize"
	exit 0
fi

SCRIPT="${1}"
ADMIN="${2}"
[ ${#} -lt 3 ] || PASS="${3}"

# For mariadb/mysql, adding the admin password breaks things
# [ -z "${PASS}" ] || export MYSQL_PWD="$(base64 -d <<< "${PASS}")"
echo "Running the script [${SCRIPT}] as [${ADMIN}] ..."
mysql ${mysql_flags} < "${SCRIPT}"
