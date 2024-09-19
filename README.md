
Used `download_koterniak_2020.sh` to download the SRR listed in the `metadata` table. Note, also downloaded the Kaletsky (2018) data (the Koterniak data was downloaded with the older `fastq-dump`, the Kaletsky data with `fasterq-dump`, as some of the bigger files failed to download). However, most of the Kaletsky (2018) files are single-end reads, not processing them here (maybe later version).

Used `star_index.sh` to create index (saved along with references), and `dsq_star_align.sh` to align. Note, did not use option to sort BAMs as it kept running out of memory. The dSQ jobs are defined in `joblist_align` and `re_joblist_align` (bigger samples that need more time). Job was then created with:
```
dsq --job-file src/joblist_align.txt --mem 20GB --cpus-per-task 10 -t 5:00:00 --mail-type ALL
dsq --job-file src/re_joblist_align.txt --mem 20GB --cpus-per-task 10 -t 23:50:00 --mail-type ALL
```

After this, bams were sorted and indexed with the dSQ `sort_bams.sh` and `joblist_sortindex.txt`, using:
```
dsq --job-file src/joblist_sortindex.txt --mem 20GB --cpus-per-task 5 -t 23:50:00 --mail-type ALL
```

The SJ files created by STAR and the sorted indexed bams were transferred and renamed manually based on description in [GEO](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE106374):

| Accession | Description | Run | Short Name |
| --- | --- | --- | --- |
| GSM2836730	| muscle_TRAP_rep_1	| SRR6238092	| muscle_6238092
| GSM2836731	| muscle_TRAP_rep_2	| SRR6238093	| muscle_6238093
| GSM2836732	| intestine_TRAP_rep_1	| SRR6238094	| intestine_6238094
| GSM2836733	| intestine_TRAP_rep_2	| SRR6238095	| intestine_6238095
| GSM2836734	| neuronal_TRAP_rep_1	| SRR6238096	| neurons_6238096
| GSM2836735	| neuronal_TRAP_rep_2	| SRR6238097	| neurons_6238097
| GSM2836736	| serotonin_TRAP_rep_1	| SRR6238098	| serotonergic_6238098
| GSM2836737	| serotonin_TRAP_rep_2	| SRR6238099	| serotonergic_6238099
| GSM2836738	| dopamine_TRAP_rep_1	| SRR6238100	| dopaminergic_6238100
| GSM2836739	| dopamine_TRAP_rep_2	| SRR6238101	| dopaminergic_6238101


note we don't continue processing samples SRR6238102-6238111 here as they are the input (whole worm) for each of these samples.


Stringtie quantification with `src/stringtie.sh`, then export the TPMs with `summarize_stringtie_q.R` (ran manually on cluster). That gives us the `intermediates/240827_strq_outs/240828_tx_TPM.tsv` file.

Manually deleted the first header `transcript_id\t` so that the header starts with sample names.

Finally, run `src/suppa_psi.sh` to get PSI per event, analyze in repo `suppa_events`.




