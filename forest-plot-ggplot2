
require(readxl); require(tidyverse); require(gt);require(patchwork);require(ggplot2)

# Specify the desired order
order <- c("Neutral", "Unfavorable", "Favorable")
plot.data$subtype <- factor(plot.data$subtype,levels=order)


p <- plot.data |>
  ggplot(aes(y=subtype), ) +
  theme_classic()

p

p <- p +
  geom_point(aes(x=IRR), shape=15, size=4) +
  geom_linerange((aes(xmin=CI_lower, xmax=CI_upper)))


# add a vertical line at 0 with geom_vline and rename the x axis
p <- p +
  geom_vline(xintercept = 0, linetype = "dashed") +
  labs(x = "Incidence Rate Ratio (95% CI)", y="")


p <- p +
  coord_cartesian(ylim=c(1,3), xlim = c(-1,62))
p_mid <- p +
  theme(axis.line.y = element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.y=element_blank(),
        axis.title.y=element_blank())

p_mid


# create pre-plotting table
plot.data_rdy <- plot.data |>
  mutate(across(
    c(IRR, CI_lower,CI_upper),
    ~str_pad(
      round(.x,2),
      width = 6,
      pad = "0",
      side= "right"
    )
  ),
  IRR_lab = paste0(IRR, " (", CI_lower, "-", CI_upper, ")")
  )|>
  
bind_rows(
  data.frame(
    subtype= "ALL Risk Group",
    IRR_lab = "Incidence Rate Ratio (95% CI)",
    CI_lower = "",
    CI_upper = ""
  )
) |>
  mutate(subtype = fct_rev(fct_relevel(subtype, "ALL Risk Group")))

glimpse(plot.data_rdy)

plot.data_rdy

p_left <- 
  plot.data_rdy |>
  ggplot(aes(y= subtype))
p_left

p_left <- 
  p_left +
  geom_text(aes(x=0, label = subtype), hjust=0, fontface="bold")
p_left <-
  p_left +
  geom_text(aes(x=1, label=IRR_lab),
            hjust=0,
            fontface=ifelse(plot.data_rdy$IRR_lab == "Incidence Rate Ratio (95% CI)", "bold", "plain"))
p_left <-
  p_left + 
  theme_void() +
  coord_cartesian(xlim=c(0,4))

layout <- c(
  area(t = 0, l = 0, b = 30, r=3),
  area(t = 1, l = 4, b = 30, r = 9)
)
p_left

p_left + p_mid + plot_layout()


plot.data <- plot.data %>% 
  mutate(log_irr = log(IRR),
         log_ci_lower = log(CI_lower),
         log_ci_upper = log(CI_upper)) #%>% 
  #filter(subtype != 'iAMP21') # RR of 0 and no CI; doesn't plot well.
