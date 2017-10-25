library(data.table)
library(dplyr)
library(ggplot2)
library(lubridate)
library(scales)
library(tibble)
library(tidyr)

train_big <- as.tibble(fread("train.csv"))

# Generate another sample, if needed
# write.csv(train_big[sample(nrow(train_big), 50000), ], "train_sample.csv")

atom_theme <- theme(
    plot.background = element_rect(fill = "#eeeeee"),
    panel.background = element_rect(fill = "#eeeeee"),
    panel.grid.major = element_line(size = 0.4, linetype = "solid", colour = "#cccccc"),
    panel.grid.minor = element_line(size = 0),
    text = element_text(size = 16, family = "San Francisco Display", face = "bold"),
    axis.title.x = element_text(margin = margin(t = 20)),
    plot.title = element_text(margin = margin(b = 20), hjust = 0.5),
    legend.position = "none",
    plot.margin = unit(c(1, 1.5, 1, 1), "cm"),
    axis.ticks = element_blank()
)
