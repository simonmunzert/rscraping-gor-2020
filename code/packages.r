
# install packages from CRAN
p_needed <- c("tidyverse", "janitor", # modern data wrangling
              "rvest", # scraping suite
              "devtools", # developer tools; access to GitHub-hosted packages
              "ggmap", "osmdata" # fun with maps
)
packages <- rownames(installed.packages())
p_to_install <- p_needed[!(p_needed %in% packages)]
if (length(p_to_install) > 0) {
  install.packages(p_to_install)
}
lapply(p_needed, require, character.only = TRUE)
