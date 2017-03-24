#!/usr/bin/env bash

set -e
set -o pipefail

PG_DB=$1
PG_USER=$2
BASE_DIR=$3
DATA_DIR=$4

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <PG_DB> <PG_USER> <BASE_DIR> <DATA_DIR>" >&2
    exit 1
fi

echo "[contrib/gwascatalog] [INFO] `date +"%Y-%m-%d %H:%M:%S"` Fetching data..."

DATA_NAME=NCBI_GENE
mkdir -p ${DATA_DIR}/${DATA_NAME}
cd ${DATA_DIR}/${DATA_NAME}

# gene_info
wget -c ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz

# seq_gene.md
# - Homo sapiens (Human, Taxonomy ID 9606)
# - GRCh37p13 (Annotation Release 105)
wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/MapView/Homo_sapiens/sequence/ANNOTATION_RELEASE.105/initial_release/seq_gene.md.gz

echo "[contrib/gwascatalog] [INFO] `date +"%Y-%m-%d %H:%M:%S"` Importing data..."

table=NcbiGeneInfo
filename=gene_info.gz
gzip -dc ${filename}| \
    awk -F$'\t' '{if ($1 == "9606") print }'| \
    psql $PG_DB $PG_USER --no-psqlrc --single-transaction -c "TRUNCATE ${table}; COPY ${table} FROM stdin DELIMITERS '	'"

table=NcbiSeqGene
filename=seq_gene.md.gz
gzip -dc ${filename}| \
    ${BASE_DIR}/script/cleanup_seqgene.py ${filename}| \
    psql $PG_DB $PG_USER --no-psqlrc --single-transaction -c "TRUNCATE ${table}; COPY ${table} FROM stdin DELIMITERS '	'"

echo "[contrib/gwascatalog] [INFO] `date +"%Y-%m-%d %H:%M:%S"` Done"
