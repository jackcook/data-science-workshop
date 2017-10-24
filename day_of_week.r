library(data.table)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tibble)
library(tidyr)

train <- as.tibble(fread("train.csv"))

train_data <- train[train$passenger_count > 0 & train$passenger_count < 7, ] %>%
    mutate(wday = wday(pickup_datetime, label = TRUE)) %>%
    group_by(wday) %>%
    count()

train_data %>%
    ggplot(aes(wday, n, fill = wday)) +
    geom_point(color = "#34495e", size = 6) +
    labs(x = "Day", y = "", title = "Number of NYC Taxi Rides") +
    scale_y_continuous(label = unit_format(unit = "K", scale = 1e-3, sep = "")) +
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

ggsave("day_of_week.png")
