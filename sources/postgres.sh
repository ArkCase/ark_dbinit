#!/bin/bash
#
# usage: ${0} script-to-run admin-username [admin-password]
#

SCRIPT="${1}"
ADMIN="${2}"
[ ${#} -lt 3 ] || PASS="${3}"

# For postgres, we shouldn't need the admin password ... but just in case
if [ -n "${PASS:-}" ] ; then
	export PGPASSFILE="$(mktemp)"
	printf '*:*:*:*:%s\n' "$(base64 -d <<< "${PASS}" | sed -e 's/[\\:]/\\&/g')" > "${PGPASSFILE}"
fi

echo "Running the script [${SCRIPT}] as [${ADMIN}] ..."
(
	RC="0"
	psql -U "${ADMIN}" -f "${SCRIPT}" || RC="${?}"
	[ -z "${PGPASSFILE:-}" ] || rm -f "${PGPASSFILE}" &>/dev/null
	exit "${RC}"
)
