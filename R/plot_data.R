plot_data <- function(model_data) {

  model_data %>%
    ggplot(aes(x = pct_change_in_median_income, y = evictions)) +
    geom_point(alpha = 0.9) +
    geom_smooth(method = "lm", se = FALSE, color = "firebrick") +
    scale_x_continuous(labels = \(x) scales::percent(x/100)) +
    scale_y_continuous(limits = c(0, 50)) +
    labs(
      x = "% Change in Median Household Income (2020 vs. 2010)",
      y = "Eviction Notices",
      title = "Filed Eviction Notices by Change in Median Income",
      subtitle = "2020-Present"
    ) +
    pilot::theme_pilot()
}
