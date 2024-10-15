merge_data <- function(evictions, census_data) {

  evictions <- st_transform(evictions, 7131) %>%
    filter(year(file_date) > 2020)

  census_pivot <- census_data %>%
    st_drop_geometry() %>%
    select(GEOID, variable, estimate, year) %>%
    arrange(GEOID, year, variable) %>%
    group_by(GEOID, variable) %>%
    reframe(percent_change = ((lead(estimate) - estimate)/estimate)*100) %>%
    drop_na() %>%
    pivot_wider(
      names_from = variable,
      values_from = percent_change,
      names_glue = "pct_change_in_{variable}",
    )

  tracts_only <- census_data %>%
    select(GEOID) %>%
    distinct(GEOID, .keep_all = TRUE)

  evictions_by_tract <- st_intersects(tracts_only, evictions)
  tracts_only$evictions <- lengths(evictions_by_tract)

  model_data <- tracts_only %>%
    inner_join(census_pivot, join_by(GEOID))

  return(model_data)
}


