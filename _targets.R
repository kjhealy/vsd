library(targets)
library(tarchetypes)
suppressPackageStartupMessages(library(tidyverse))

#library(crew)
#tar_option_set(
#  controller = crew_controller_local(workers = 15)
#)

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

# Deployment flag—one of two tests to deploy_site target.
# See deploy_site below for the user condition

Sys.setenv(DEPLOY_VSD = FALSE)

# There's no way to get a relative path directly out of here::here(), but
# fs::path_rel() works fine with it (see
# https://github.com/r-lib/here/issues/36#issuecomment-530894167)
here_rel <- function(...) {fs::path_rel(here::here(...))}

## Load functions for the pipeline
source("R/tar_slides.R")
source("R/tar_projects.R")
source("R/tar_data.R")
source("R/tar_calendar.R")


## THE MAIN PIPELINE ----
list(
  ## Run all the data building and copying targets ----
  save_data,

  ### Link all these data building and copying targets into individual dependencies ----
  tar_combine(copy_data, tar_select_targets(save_data, starts_with("copy_"))),
  tar_combine(build_data, tar_select_targets(save_data, starts_with("data_"))),


  # The main index.qmd page loads quarto_slides as a target to link it as a dependency
  # The slide folder is excluded from the main quarto render.
  # tar_files(quarto_files, list.files(here_rel("slides"),
  #                                      pattern = "\\.qmd",
  #                                      full.names = TRUE)),
  # tar_target(quarto_slides,
  #            render_quarto(quarto_files),
  #            pattern = map(quarto_files),
  #            format = "file"),

  ### Convert HTML slides to PDF ----
  #
  # Use dynamic branching to get a list of all slide .html files and
  # convert them to PDF
  #
  # The main index.qmd page loads quarto_pdfs as a target to link it as a dependency
  #tar_files(quarto_html_files, {
  #  quarto_slides
  #  list.files(here_rel("_site", "slides"),
  #             pattern = "\\.html",
  #             full.names = TRUE)
  #}),
#
#   tar_target(quarto_pdfs,
#              html_to_pdf(quarto_html_files),
#              pattern = map(quarto_html_files),
#              format = "file"),



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


  ## Render the README ----
  #tar_target(workflow_graph, tar_mermaid(targets_only = TRUE, outdated = FALSE,
  #                                         legend = FALSE, color = FALSE)),
  #tar_quarto(readme, here_rel("README.qmd")),


  ## Build site ----
  tar_quarto(site, path = ".", quiet = FALSE),

  ## Upload site ----
  tar_target(deploy_script, here_rel("deploy.sh"), format = "file"),
  tar_target(deploy_site, {
    # Force dependencies
    site
    # Run the deploy script if both conditions are met
    if (Sys.info()["user"] != "kjhealy" | Sys.getenv("DEPLOY_VSD") != "TRUE") message("Deployment vars not set. Will not deploy site.")
    if (Sys.info()["user"] == "kjhealy" & Sys.getenv("DEPLOY_VSD") == "TRUE") message("Running deployment script ...")
    if (Sys.info()["user"] == "kjhealy" & Sys.getenv("DEPLOY_VSD") == "TRUE") processx::run(paste0("./", deploy_script), echo = TRUE)
  })
)
