#!/usr/bin/env bash

PG_URL=$1
BASE_DIR=$2

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <PG_URL> <BASE_DIR>" >&2
    exit 1
fi

set -ue
set -o pipefail

echo "[INFO] Drop and Create tables..."

psql ${PG_URL} --single-transaction -f ${BASE_DIR}/postgresql/schema/create_tables.sql -q

echo "[INFO] Done"
