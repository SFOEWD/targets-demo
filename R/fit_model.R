fit_model <- function(model_data) {

  m <- lm(evictions ~ pct_change_in_median_income, data = model_data)
  list(
    model = m,
    diagnotics = glance(m),
    summary = tidy(m),
    residuals = augment(m)
  )
}

