--
-- Table for `gene_info`
--
DROP TABLE IF EXISTS NcbiGeneInfo;
CREATE TABLE NcbiGeneInfo (
                                                               -- E.g.
    tax_id                                 integer  not null,  -- 9606
    gene_id                                integer  not null,  -- 1
    symbol                                 varchar  not null,  -- A1BG
    locus_tag                              varchar  not null,  -- -
    synonyms                               varchar  not null,  -- A1B|ABG|GAB|HYST2477
    db_xrefs                               varchar  not null,  -- MIM:138670|HGNC:HGNC:5|Ensembl:ENSG00000121410|Vega:OTTHUMG00000183507
    chromosome                             varchar  not null,  -- 19
    map_location                           varchar  not null,  -- 19q13.43
    description                            varchar  not null,  -- alpha-1-B glycoprotein
    type_of_gene                           varchar  not null,  -- protein-coding
    symbol_from_nomenclature_authority     varchar  not null,  -- A1BG
    full_name_from_nomenclature_authority  varchar  not null,  -- alpha-1-B glycoprotein
    nomenclature_status                    varchar  not null,  -- O
    other_designations                     varchar  not null,  -- alpha-1B-glycoprotein|HEL-S-163pA|epididymis secretory sperm binding protein Li 163pA
    modification_date                      varchar  not null   -- 20170312
);
CREATE INDEX geneinfo_gene_id ON NcbiGeneInfo (tax_id, gene_id);
CREATE INDEX geneinfo_chromosome ON NcbiGeneInfo (tax_id, chromosome);

--
-- Table for `seq_gene.md`
--
DROP TABLE IF EXISTS NcbiSeqGene;
CREATE TABLE NcbiSeqGene (
);
