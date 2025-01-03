# Load Required Libraries
required_packages <- c("readxl", "tidyverse", "gt", "patchwork", "ggplot2")

# Example Dataset (Replace with Actual Data)
plot.data <- tibble(
    subtype = c("Neutral", "Unfavorable", "Favorable"),
    IRR = c(1.2, 0.8, 1.5),
    CI_lower = c(0.9, 0.5, 1.2),
    CI_upper = c(1.5, 1.1, 1.8)
)

# Set Subtype Order
plot.data$subtype <- factor(plot.data$subtype, levels = c("Neutral", "Unfavorable", "Favorable"))

# Create Main Plot
p_mid <- plot.data %>%
  ggplot(aes(y = subtype)) +
  geom_point(aes(x = IRR), shape = 15, size = 4) +
  geom_linerange(aes(xmin = CI_lower, xmax = CI_upper)) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  labs(x = "Incidence Rate Ratio (95% CI)", y = "") +
  theme_classic() +
  theme(axis.line.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank())

# Pre-plotting Table
plot.data_rdy <- plot.data %>%
  mutate(
    IRR_lab = sprintf("%.2f (%.2f–%.2f)", IRR, CI_lower, CI_upper)
  ) %>%
  bind_rows(
    tibble(
      subtype = "ALL Risk Group",
      IRR_lab = "Incidence Rate Ratio (95% CI)"
    )
  ) %>%
  mutate(subtype = fct_rev(fct_relevel(subtype, "ALL Risk Group")))

# Create Left Table Plot
p_left <- plot.data_rdy %>%
  ggplot(aes(y = subtype)) +
  geom_text(aes(x = 0, label = subtype), hjust = 0, fontface = "bold") +
  geom_text(aes(x = 1, label = IRR_lab), hjust = 0) +
  theme_void() +
  coord_cartesian(xlim = c(0, 4))

# Combine Plots
final_plot <- p_left + p_mid + plot_layout(ncol = 2, widths = c(1, 2))

# Display Plot
print(final_plot)
