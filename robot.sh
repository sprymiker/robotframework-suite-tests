#!/bin/bash

set -e

function printHelp() {

    echo -e -n "\nUsage: robot.sh -s {suite: e.g. suite or b2b} -t {target: glue|bapi}"

    return 0
}

SUITE='suite'
TARGET='glue'

while getopts ":s:t:" opt; do
    case ${opt} in
        s)
            SUITE="$OPTARG"
            ;;
        t)
            TARGET=$OPTARG
            ;;
        # Unknown option specified
        \?)
            printHelp
            echo -e -n "\nUnknown option -${OPTARG} is acquired."
            exit 1
            ;;
        # Specified argument without required value
        :)
            printHelp
            echo -e -n "\nUnknown option -${OPTARG} is acquired."
            exit 1
            ;;
    esac
done
shift $((OPTIND - 1))

DB_ENGINE="$([[ "${SPRYKER_DB_ENGINE}" == 'mysql' ]] && echo "mysql" || echo "postgresql")"

robot \
  -v env:api_${SUITE} \
  -v db_engine:"${DB_ENGINE}" \
  -v db_host:"${SPRYKER_DB_HOST}" \
  -v db_port_env:"${SPRYKER_DB_PORT}" \
  -v db_port_postgres_env:"${SPRYKER_DB_PORT}" \
  -v db_user:"${SPRYKER_DB_USERNAME}" \
  -v db_password:"${SPRYKER_DB_PASSWORD}" \
  -v db_name:"${SPRYKER_DB_DATABASE}" \
  --exclude skip-due-to-issueORskip-due-to-refactoring \
  -d results \
  -s tests.api.${SUITE}.${TARGET} \
  .
