suppressPackageStartupMessages(library(scales))
library(ggplot2)

# Helpful functions ----

# When using a file-based target, {targets} requires that the function that
# saves the file returns a path to the file. write_csv() invisibly returns the
# data frame being written, so we need a wrapper function to save the file and
# return the path.
save_csv <- function(df, path) {
  readr::write_csv(df, path)
  return(path)
}

# fs::file_copy() returns a path to the copied file, which is nice for
# {targets}. This is a wrapper function to make it so we only need to specify
# the destination folder; the filename of the copied file will remain the same
copy_file <- function(original_file, new_folder) {
  fs::file_copy(path = original_file,
                new_path = fs::path(new_folder, basename(original_file)),
                overwrite = TRUE)
}


# Pipeline just for generating, saving, and copying data ----
save_data <- list(
  ## Generate or save data ----
  #
  ### Save any data files from packages ----
  # mpg
  tar_target(data_mpg,
             save_csv(ggplot2::mpg,
                      here_rel("files", "data", "package_data", "cars.csv")),
             format = "file"),

  # palmerpenguins for problem set 1, 2
  tar_target(data_penguins,
             save_csv(tidyr::drop_na(palmerpenguins::penguins, body_mass_g),
                      here_rel("files", "data", "package_data", "penguins.csv")),
             format = "file"),

  # gapminder for class 1, 2
  tar_target(data_gapminder,
             save_csv(gapminder::gapminder,
                      here_rel("files", "data", "package_data", "gapminder.csv")),
             format = "file"),

  # UK Election data for Midterm
  tar_target(data_ukelection,
             save_csv(ukelection2019::ukvote2019,
             here_rel("files", "data", "package_data", "ukvote2019.csv")),
             format = "file"),

  # US Birth ages for problem set 07
  tar_target(data_uscenpops,
             save_csv(uscenpops::uscenpops,
             here_rel("files", "data", "package_data", "uscenpops.csv")),
             format = "file"),


  ### Copy files to project folders ----
  # Problem set 01
  tar_target(copy_gapminder_1,
             copy_file(data_gapminder,
                       new_folder = here_rel("projects", "01-problem-set", "data"))),

  tar_target(copy_penguins_1,
             copy_file(data_penguins,
                       new_folder = here_rel("projects", "01-problem-set", "data")))
)


  # # Problem set 02
  # tar_target(copy_gapminder_2,
  #            copy_file(data_gapminder,
  #                      new_folder = here_rel("projects", "02-problem-set", "data"))),
  #
  # tar_target(copy_penguins_2,
  #            copy_file(data_penguins,
  #                      new_folder = here_rel("projects", "02-problem-set", "data"))),
  #
  # # Midterm
  # tar_target(copy_ukelection,
  #            copy_file(data_ukelection,
  #                     new_folder = here_rel("projects", "midterm", "data"))),
  #
  # # Problem set 07
  # tar_target(copy_uscenpops,
  #            copy_file(data_uscenpops,
  #                      new_folder = here_rel("projects", "07-problem-set", "data"))),
  #
  # # Problem set 08
  # tar_target(copy_apple,
  #            copy_file(original_file = here_rel("files", "data", "apple.csv"),
  #                      new_folder = here_rel("projects", "08-problem-set", "data")))



