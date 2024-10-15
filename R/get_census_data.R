get_census_data <- function(years, variables) {
  names(years) <- years
  map_dfr(years, \(year) {
    get_acs(
      geography = "tract",
      state = "CA",
      county = "San Francisco",
      variables = variables,
      year = year,
      geometry = TRUE
    )
  }, .id = "year") %>%
    st_transform(7131)
}
