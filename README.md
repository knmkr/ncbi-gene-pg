# ncbi-gene-pg

PostgreSQL schema for NCBI Gene

- Homo sapiens (Human, Taxonomy ID 9606)
- GRCh37p13 (Annotation Release 105)


## How to use

E.g.

```
=> SELECT gene_id, symbol, chromosome, map_location, description FROM ncbigeneinfo WHERE gene_id = 672;

 gene_id | symbol | chromosome | map_location |         description
---------+--------+------------+--------------+------------------------------
     672 | BRCA1  | 17         | 17q21.31     | BRCA1, DNA repair associated
(1 row)
```

```
=> SELECT gene_id, chromosome, chr_start, chr_stop, chr_orient FROM ncbiseqgene WHERE gene_id = 672;

 gene_id | chromosome | chr_start | chr_stop | chr_orient
---------+------------+-----------+----------+------------
     672 | 17         |  41196312 | 41277500 | -
(1 row)
```
