library(targets)
library(tarchetypes)
suppressPackageStartupMessages(library(tidyverse))

## Parallelize things --- when we build the PDFs
## it'll take forever otherwise
library(crew)
tar_option_set(
 controller = crew_controller_local(workers = 15)
)

## Variables and options
class_number <- "SOCIOL 232"
base_url <- "https://visualizingsociety.com/"
page_suffix <- ".html"

options(tidyverse.quiet = TRUE,
        dplyr.summarise.inform = FALSE)

tar_option_set(
  packages = c("tibble"),
  format = "rds",
  workspace_on_error = TRUE
)

# Deployment variables:
# See deploy_site below for how these are applied
yaml_vars <- yaml::read_yaml(here::here("_variables.yml"))

# There's no way to get a relative path directly out of here::here(), but
# fs::path_rel() works fine with it (see
# https://github.com/r-lib/here/issues/36#issuecomment-530894167)
here_rel <- function(...) {fs::path_rel(here::here(...))}

## Load functions for the pipeline
source("R/tar_slides.R")
source("R/tar_projects.R")
source("R/tar_data.R")
source("R/tar_calendar.R")
source("R/tar_mermaid.R")

# Ensure deletion_candidates has at least one dummy dir, to keep target branching happy
if(!fs::dir_exists(here::here("00_dummy_files"))) { fs::dir_create(here::here("00_dummy_files")) }
if(!fs::dir_exists(here::here("00_dummy_files/figure-revealjs"))) { fs::dir_create(here::here("00_dummy_files/figure-revealjs")) }
fs::file_create(here::here("00_dummy_files/figure-revealjs/00_dummy.png"))


get_flipbookr_orphans <- function() {
  all_candidates <- fs::dir_ls(glob = "*_files/figure-revealjs/*.png", recurse = TRUE)
  all_candidates <- all_candidates[stringr::str_detect(all_candidates, "_site", negate = TRUE)]
  if(length(all_candidates) == 0) { return(character(0))}
  all_candidates
}

relocate_orphans <- function(file) {
  if(length(file) == 0) { return(character(0))}
  if(is.null(file)) { return(character(0))}
  if(stringr::str_detect(file, "00_dummy")) { return(character(0))}
  fs::file_move(file, paste0("_site/slides/", file))
}

get_leftover_dirs <- function() {
  # the figure-revealjs subdirs will all have been moved
  deletion_candidates <- fs::dir_ls(glob = "*_files", recurse = TRUE)
  deletion_candidates <- deletion_candidates[stringr::str_detect(deletion_candidates, "_site|_targets", negate = TRUE)]
  }

remove_leftover_dirs <- function (dirs) {
  if(length(dirs) == 0) { return(character(0))}
  if(is.null(dirs)) { return(character(0))}
  fs::dir_delete(dirs)
}


## SITE PIPELINE ----
list(
  ## Run all the data building and copying targets ----
  save_data,

  ### Link all these data building and copying targets into individual dependencies ----
  tar_combine(copy_data, tar_select_targets(save_data, starts_with("copy_"))),
  tar_combine(build_data, tar_select_targets(save_data, starts_with("data_"))),

  ## Project folders ----
  ### Zip up each project folder ----
  #
  # Get a list of all folders in the project folder, create dynamic branches,
  # then create a target for each that runs the custom zippy() function, which
  # uses system2() to zip the folder and returns a path to keep targets happy
  # with `format = "file"`
  #
  # The main index.qmd page loads project_zips as a target to link it as a dependency
  #
  # Use tar_force() and always run this because {targets} seems to overly cache
  # the results of list.dirs()
  tar_force(project_paths,
            list.dirs(here_rel("projects"),
                      full.names = FALSE, recursive = FALSE),
            force = TRUE),
  tar_target(project_files, project_paths, pattern = map(project_paths)),
  tar_target(project_zips, {
    copy_data
    build_data
    zippy(project_files, "projects")
  },
  pattern = map(project_files),
  format = "file"),


  ## Class schedule calendar ----
  tar_target(schedule_file, here_rel("data", "schedule.csv"), format = "file"),
  tar_target(schedule_page_data, build_schedule_for_page(schedule_file)),
  tar_target(schedule_ical_data, build_ical(schedule_file, base_url, page_suffix, class_number)),
  tar_target(schedule_ical_file,
             save_ical(schedule_ical_data,
                       here_rel("files", "schedule.ics")),
             format = "file"),

  # Broken
  # tar_target(workflow_graph, tar_mermaid(
  #   targets_only = TRUE, outdated = FALSE,
  #   legend = FALSE, color = FALSE, store = "_targets"
  # )),
  # tar_quarto(readme, here_rel("README.qmd")),

  ## Build site ----
  tar_quarto(site, path = ".", quiet = FALSE),

  ## Convert HTML slides to PDF ----
  ### Render the built html slides in _site/slides to PDFs
  ### We wait till quarto has built the site to do this.
  # tar_files(rendered_slides,
  #           list.files(here_rel("_site", "slides"),
  #              pattern = "\\.html", full.names = TRUE)),

  tar_files(rendered_slides, {
            # Force dependencies
            site
            fl <- list.files(here_rel("slides"),
                       pattern = "\\.qmd", full.names = TRUE)
            paste0("_site/", stringr::str_replace(fl, "qmd", "html"))
            }),

  tar_target(quarto_pdfs, {
    html_to_pdf(rendered_slides)
    },
    pattern = map(rendered_slides),
    format = "file"),

  ## Fix any flipbookr leftover files
  tar_files(flipbookr_orphans, {
    # Force dependencies
    rendered_slides
    # Flipbooks created in the top level
    get_flipbookr_orphans()
  }
  ),

  tar_target(move_orphans, {
    relocate_orphans(flipbookr_orphans)
  },
  pattern = map(flipbookr_orphans),
  format = "file"),

  ## Remove any flipbookr leftover dirs
  tar_files(flipbookr_dirs, {
    # Force dependencies
    quarto_pdfs
    # Top-level flipbookr dirs now empty
    get_leftover_dirs()
  }
  ),

  tar_target(empty_dirs, {
    remove_leftover_dirs(flipbookr_dirs)
  },
  pattern = map(flipbookr_dirs)),


  ## Upload site ----
  tar_target(deploy_script, here_rel("deploy.sh"), format = "file"),
  tar_target(deploy_site, {
    # Force dependencies
    site
    # Run the deploy script if both conditions are met
    # deploy_username and deploy_site are set in _variables.yml
    if (Sys.info()["user"] != yaml_vars$deploy$user | yaml_vars$deploy$site != TRUE) message("Deployment vars not set. Will not deploy site.")
    if (Sys.info()["user"] == yaml_vars$deploy$user & yaml_vars$deploy$site == TRUE) message("Running deployment script ...")
    if (Sys.info()["user"] == yaml_vars$deploy$user & yaml_vars$deploy$site == TRUE) processx::run(paste0("./", deploy_script), echo = TRUE)
  })
)
