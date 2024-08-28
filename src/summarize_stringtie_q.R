# Gather TPMs from StringTie
# Adapted from stringtie_quantifs/R/summarize_stringtie_q_output.R
library(dplyr)
library(readr)
library(tibble)
library(tidyr)
library(stringr)
library(purrr)
library(rtracklayer)

# if running on RStudio Server
# setwd("/gpfs/gibbs/project/hammarlund/aw853/reanalysis_tissue")

qdir <- "intermediates/240827_strq_outs/quantifications"
expdir <- "intermediates/240827_strq_outs/summaries"

# Read in data ----
samples_table <- tibble(sample_id = list.dirs(qdir,full.names=FALSE,recursive = FALSE),
                        sample_path = list.dirs(qdir,full.names=TRUE,recursive = FALSE))

stopifnot(all(! is.na(str_match(samples_table$sample_id, "^([a-z]+_[0-9]{7})$")[,2])))



import_file <- function(sample_id,sample_path){
  imp <- rtracklayer::import(paste0(sample_path, "/", sample_id, ".gtf"),
                             feature.type = "transcript") %>%
    as_tibble() %>%
    mutate(across(c(cov,FPKM,TPM), as.double))
  
  if("gene_name" %in% colnames(imp)){
    # I5r210 has no gene_name column, somehow
    imp <- imp %>%
      mutate(gene_name = if_else(is.na(ref_gene_name), gene_name, ref_gene_name)) %>%
      select(-c(width, source, type, score, phase, ref_gene_name))
  } else{
    imp <- imp %>%
      mutate(gene_name = ref_gene_name) %>%
      select(-c(width, source, type, score, phase, ref_gene_name))
  }
  imp
}


samples_table$content <- purrr::pmap(samples_table,
                                     import_file)


vals_long <- pmap_dfr(samples_table |> select(-sample_path),
                      function(sample_id, content){
                        content |>
                          select(transcript_id, cov, FPKM, TPM) |>
                          add_column(sample_id = sample_id)
                      })




mat_tpm <- vals_long %>%
  select(-FPKM,-cov) %>%
  pivot_wider(id_cols = transcript_id,
              names_from = sample_id,
              values_from = TPM)

write_tsv(mat_tpm,
          file.path(expdir, "240828_tx_TPM.tsv"))




