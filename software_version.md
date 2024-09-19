
STAR version: 2.7.11a

fastq-dump version: 3.1.1

StringTie version: 2.2.1

SUPPA version 2.3.
Installed via Conda, full environment:
```
# Name                    Version                   Build  Channel
_libgcc_mutex             0.1                 conda_forge    conda-forge
_openmp_mutex             4.5                       2_gnu    conda-forge
brotli                    1.0.9                h166bdaf_8    conda-forge
brotli-bin                1.0.9                h166bdaf_8    conda-forge
bzip2                     1.0.8                h7f98852_4    conda-forge
ca-certificates           2023.5.7             hbcca054_0    conda-forge
certifi                   2023.5.7           pyhd8ed1ab_0    conda-forge
charset-normalizer        3.1.0              pyhd8ed1ab_0    conda-forge
idna                      3.4                pyhd8ed1ab_0    conda-forge
joblib                    1.2.0              pyhd8ed1ab_0    conda-forge
ld_impl_linux-64          2.40                 h41732ed_0    conda-forge
libblas                   3.9.0           16_linux64_openblas    conda-forge
libbrotlicommon           1.0.9                h166bdaf_8    conda-forge
libbrotlidec              1.0.9                h166bdaf_8    conda-forge
libbrotlienc              1.0.9                h166bdaf_8    conda-forge
libcblas                  3.9.0           16_linux64_openblas    conda-forge
libexpat                  2.5.0                hcb278e6_1    conda-forge
libffi                    3.4.2                h7f98852_5    conda-forge
libgcc-ng                 12.2.0              h65d4601_19    conda-forge
libgfortran-ng            12.2.0              h69a702a_19    conda-forge
libgfortran5              12.2.0              h337968e_19    conda-forge
libgomp                   12.2.0              h65d4601_19    conda-forge
liblapack                 3.9.0           16_linux64_openblas    conda-forge
libnsl                    2.0.0                h7f98852_0    conda-forge
libopenblas               0.3.21          pthreads_h78a6416_3    conda-forge
libsqlite                 3.42.0               h2797004_0    conda-forge
libstdcxx-ng              12.2.0              h46fd767_19    conda-forge
libuuid                   2.38.1               h0b41bf4_0    conda-forge
libzlib                   1.2.13               h166bdaf_4    conda-forge
ncurses                   6.3                  h27087fc_1    conda-forge
numpy                     1.24.3          py311h64a7726_0    conda-forge
openssl                   3.1.0                hd590300_3    conda-forge
packaging                 23.1               pyhd8ed1ab_0    conda-forge
pandas                    2.0.1           py311h320fe9a_1    conda-forge
patsy                     0.5.3              pyhd8ed1ab_0    conda-forge
pip                       23.1.2             pyhd8ed1ab_0    conda-forge
platformdirs              3.5.1              pyhd8ed1ab_0    conda-forge
pooch                     1.7.0              pyha770c72_3    conda-forge
pysocks                   1.7.1              pyha2e5f31_6    conda-forge
python                    3.11.3          h2755cc3_0_cpython    conda-forge
python-dateutil           2.8.2              pyhd8ed1ab_0    conda-forge
python-tzdata             2023.3             pyhd8ed1ab_0    conda-forge
python_abi                3.11                    3_cp311    conda-forge
pytz                      2023.3             pyhd8ed1ab_0    conda-forge
readline                  8.2                  h8228510_1    conda-forge
requests                  2.31.0             pyhd8ed1ab_0    conda-forge
scikit-learn              1.2.2           py311h103fc68_1    conda-forge
scipy                     1.10.1          py311h64a7726_3    conda-forge
setuptools                67.7.2             pyhd8ed1ab_0    conda-forge
six                       1.16.0             pyh6c4a22f_0    conda-forge
statsmodels               0.14.0          py311h1f0f07a_1    conda-forge
suppa                     2.3                        py_2    bioconda
threadpoolctl             3.1.0              pyh8a188c0_0    conda-forge
tk                        8.6.12               h27826a3_0    conda-forge
typing-extensions         4.6.1                hd8ed1ab_0    conda-forge
typing_extensions         4.6.1              pyha770c72_0    conda-forge
tzdata                    2023c                h71feb2d_0    conda-forge
urllib3                   2.0.2              pyhd8ed1ab_0    conda-forge
wheel                     0.40.0             pyhd8ed1ab_0    conda-forge
xz                        5.2.6                h166bdaf_0    conda-forge
```



For summarizing StringTie output and splitting TPM/PSI files for SUPPA, R version 4.2.0.
Full session info:
```
R version 4.2.0 (2022-04-22)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Red Hat Enterprise Linux 8.8 (Ootpa)

Matrix products: default
BLAS/LAPACK: /vast/palmer/apps/avx2/software/OpenBLAS/0.3.12-GCC-10.2.0/lib/libopenblas_haswellp-r0.3.12.so

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
 [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8
 [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
 [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
 [9] LC_ADDRESS=C               LC_TELEPHONE=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats4    stats     graphics  grDevices utils     datasets  methods
[8] base

other attached packages:
 [1] getopt_1.20.3        rtracklayer_1.58.0   GenomicRanges_1.50.2
 [4] GenomeInfoDb_1.34.9  IRanges_2.32.0       S4Vectors_0.36.2
 [7] BiocGenerics_0.44.0  purrr_1.0.2          stringr_1.4.0
[10] tidyr_1.2.0          tibble_3.2.1         readr_2.1.5
[13] dplyr_1.1.4

loaded via a namespace (and not attached):
 [1] pillar_1.9.0                compiler_4.2.0
 [3] restfulr_0.0.15             XVector_0.38.0
 [5] MatrixGenerics_1.10.0       bitops_1.0-7
 [7] tools_4.2.0                 zlibbioc_1.44.0
 [9] lattice_0.20-45             lifecycle_1.0.4
[11] pkgconfig_2.0.3             rlang_1.1.3
[13] Matrix_1.4-1                DelayedArray_0.24.0
[15] cli_3.6.2                   parallel_4.2.0
[17] yaml_2.3.5                  GenomeInfoDbData_1.2.9
[19] generics_0.1.2              Biostrings_2.66.0
[21] vctrs_0.6.5                 hms_1.1.1
[23] grid_4.2.0                  tidyselect_1.2.1
[25] Biobase_2.58.0              glue_1.7.0
[27] R6_2.5.1                    fansi_1.0.6
[29] BiocParallel_1.32.6         XML_3.99-0.9
[31] tzdb_0.4.0                  magrittr_2.0.3
[33] matrixStats_1.2.0           GenomicAlignments_1.34.1
[35] codetools_0.2-18            Rsamtools_2.14.0
[37] ellipsis_0.3.2              SummarizedExperiment_1.28.0
[39] utf8_1.2.4                  stringi_1.7.6
[41] RCurl_1.98-1.6              crayon_1.5.1
[43] rjson_0.2.21                BiocIO_1.8.0
```


