#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import csv


def _main():
    cols_map = [
        ('#tax_id',       int),
        ('chromosome',    str),
        ('chr_start',     int),
        ('chr_stop',      int),
        ('chr_orient',    str),
        ('contig',        str),
        ('ctg_start',     int),
        ('ctg_stop',      int),
        ('ctg_orient',    str),
        ('feature_name',  str),
        ('feature_id',    str),
        ('feature_type',  str),
        ('group_label',   str),
        ('transcript',    str),
        ('evidence_code', str),
    ]

    reader = csv.DictReader(sys.stdin, delimiter='\t')
    writer = csv.writer(sys.stdout, delimiter='\t')

    for record in reader:
        if not(record['#tax_id'] == '9606' and \
               record['group_label'] == 'GRCh37.p13-Primary Assembly' and \
               record['feature_type'] == 'GENE'):
            continue

        row = []
        for name, col_type in cols_map:
            value = record[name].strip()
            value = col_type(value)
            row.append(value)

        gene_id = int(record['feature_id'].split('GeneID:')[1])
        row.append(gene_id)

        writer.writerow(row)


if __name__ == '__main__':
    import doctest
    doctest.testmod()
    _main()
