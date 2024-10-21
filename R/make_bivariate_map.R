make_bivariate_map <- function(model_data) {

  data <- bi_class(model_data, x = pct_change_in_median_income, y = evictions, style = "quantile", dim = 4)
  map <- ggplot() +
    geom_sf(data = data, mapping = aes(fill = bi_class), color = "white", size = 0.1, show.legend = FALSE) +
    bi_scale_fill(pal = "GrPink2", dim = 4, flip_axes = TRUE) +
    bi_theme()

  legend <- bi_legend(pal = "GrPink2",
                      dim = 4,
                      xlab = "Higher % Change in Income ",
                      ylab = "More Evictions ",
                      flip_axes = TRUE,
                      size = 8)

  plot <- ggdraw() +
    draw_plot(map, 0, 0, 1, 1) +
    draw_plot(legend, 0.2, .65, 0.2, 0.2)

  plot
}
