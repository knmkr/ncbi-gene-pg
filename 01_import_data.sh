#!/usr/bin/env bash

set -ue
set -o pipefail

PG_URL=$1
BASE_DIR=$2
DATA_DIR=$3

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <PG_URL> <BASE_DIR> <DATA_DIR>" >&2
    exit 1
fi

echo "[INFO] `date +"%Y-%m-%d %H:%M:%S"` Fetching data..."

mkdir -p ${DATA_DIR}/NCBI_GENE
cd ${DATA_DIR}/NCBI_GENE

# gene_info
wget -c ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/gene_info.gz

# seq_gene.md
# - Homo sapiens (Human, Taxonomy ID 9606)
# - GRCh37p13 (Annotation Release 105)
wget -c ftp://ftp.ncbi.nlm.nih.gov/genomes/MapView/Homo_sapiens/sequence/ANNOTATION_RELEASE.105/initial_release/seq_gene.md.gz

echo "[INFO] `date +"%Y-%m-%d %H:%M:%S"` Importing data..."

table=NcbiGeneInfo
filename=gene_info.gz
gzip -dc ${filename}| \
    awk -F$'\t' '{if ($1 == "9606") print }'| \
    psql $PG_URL --no-psqlrc --single-transaction -c "TRUNCATE ${table}; COPY ${table} FROM stdin DELIMITERS '	'"

table=NcbiSeqGene
filename=seq_gene.md.gz
gzip -dc ${filename}| \
    ${BASE_DIR}/script/cleanup_seqgene.py ${filename}| \
    psql $PG_URL --no-psqlrc --single-transaction -c "TRUNCATE ${table}; COPY ${table} FROM stdin DELIMITERS '	'"

echo "[INFO] `date +"%Y-%m-%d %H:%M:%S"` Done"
