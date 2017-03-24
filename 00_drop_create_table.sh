#!/usr/bin/env bash

set -e
set -o pipefail

PG_DB=$1
PG_USER=$2
BASE_DIR=$3

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <PG_DB> <PG_USER> <BASE_DIR>" >&2
    exit 1
fi

echo "[contrib/gwascatalog] [INFO] Drop and Create tables..."

psql $PG_DB $PG_USER --single-transaction -f ${BASE_DIR}/postgresql/schema/create_tables.sql -q

echo "[contrib/gwascatalog] [INFO] Done"
