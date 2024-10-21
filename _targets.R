library(targets)
library(tarchetypes)

tar_option_set(
  packages = c(
    "tidycensus",
    "sf",
    "RSocrata",
    "lubridate",
    "broom",
    "biscale",
    "cowplot",
    "gtsummary",
    "tidyverse"
    ),
  format = "qs"
)

tar_source()

timestamp_url <- "https://data.sfgov.org/resource/y8fp-fbf5.json?$select=data_last_changed_dt&$where=dataset_id='5cei-gny5'"
evictions_url <- "https://data.sfgov.org/resource/5cei-gny5.geojson?$limit=9999999"

tar_plan(
  tar_change(
    evictions,
    st_read(evictions_url),
    change = read.socrata(timestamp_url)
  ),
  acs_variables = get_acs_variables(),
  census_data = get_census_data(years = c(2010, 2019), variables = acs_variables),
  model_data = merge_data(evictions, census_data),
  model = fit_model(model_data),
  map = make_bivariate_map(model_data),
  plot = plot_data(model_data),
  tar_quarto(report, path = "evictions.qmd")
)
