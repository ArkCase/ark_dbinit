#!/bin/bash
#
# usage: ${0} script-to-run admin-username [admin-password]
#

SCRIPT="${1}"
ADMIN="${2}"
[ ${#} -lt 3 ] || PASS="${3}"

# For postgres, we shouldn't need the admin password ... but just in case
if [ -n "${PASS}" ] ; then
	export PGPASSFILE="$(mktemp)"
	base64 -d <<< "${PASS}" > "${PGPASSFILE}"
fi

echo "Running the script [${SCRIPT}] as [${ADMIN}] ..."
(
	psql -U "${ADMIN}" -f "${SCRIPT}"
	RC=${?}
	[ -z "${PGPASSFILE}" ] || rm -rf "${PGPASSFILE}" &>/dev/null
	exit ${?}
)
