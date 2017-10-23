library(data.table)
library(dplyr)
library(ggplot2)
library(tibble)
library(tidyr)

train <- as.tibble(fread("train.csv"))

train_data <- train[train$passenger_count > 0 & train$passenger_count < 7, ] %>%
    group_by(passenger_count) %>%
    count()

train_data %>%
    ggplot(aes(passenger_count, n, fill = passenger_count)) +
    geom_col() +
    labs(x = "Passengers", y = "", title = "Number of NYC Taxi Rides") +
    scale_x_continuous(breaks = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)) +
    scale_y_sqrt(breaks = c(3e+05, 6e+05, 9e+05), labels = c("300k", "600k", "900k")) +
    theme(
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

ggsave("passenger_count.png")
