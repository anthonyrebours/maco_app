# Packages

pacman::p_load(
  openalexR,
  tidyverse, 
  rio, 
  here
)


# OpenAlex Data

su <- oa_fetch(
  entity = "institution",
  ror = "https://ror.org/02en5vm52"
)


# Data wrangling

su <- su %>% unnest(associated_institutions, names_sep = "_")

su %>% 
  select(associated_institutions_ror, associated_institutions_display_name) %>% 
  mutate(associated_institutions_ror = str_remove(associated_institutions_ror, 
                                                  pattern = "https://ror.org/")) %>% 
  rename("from" = associated_institutions_ror, 
         "to" = associated_institutions_display_name) %>% 
  mutate("col") %>% 
  export(here("data", "thesaurus_ror.csv"), encoding = "Latin-1")
