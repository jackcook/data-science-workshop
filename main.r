library(data.table)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tibble)
library(tidyr)

train <- as.tibble(fread('./Desktop/train.csv'))

train_data <- train %>%
    mutate(hpick = hour(pickup_datetime)) %>%
    group_by(hpick) %>%
    summarise(median_duration = median(trip_duration)/60)

train_data %>%
    ggplot(aes(hpick, median_duration)) +
    geom_smooth(color = "#34495e", fill = "#2c3e50", method = "loess", span = 1/2) +
    labs(x = "Time", y = "Median Duration", title = "Duration of NYC Taxi Rides") +
    scale_x_continuous(breaks = c(0, 5, 10, 15, 20), labels = c("12am", "5am", "10am", "3pm", "8pm")) +
    scale_y_continuous(breaks = c(8, 9, 10, 11, 12), labels = c("8", "9", "10", "11", "12 minutes")) +
    theme(
        plot.background = element_rect(fill = "#eeeeee"),
        panel.background = element_rect(fill = "#eeeeee"),
        panel.grid.major = element_line(size = 0.4, linetype = "solid", colour = "#dcdcdc"),
        panel.grid.minor = element_line(size = 0),
        text = element_text(size = 16, family = "San Francisco Display", face = "bold"),
        axis.title.x = element_text(margin = margin(t = 20)),
        axis.title.y = element_text(margin = margin(r = 20)),
        axis.text.y = element_text(hjust = 0, margin = margin(r = -50)),
        plot.title = element_text(margin = margin(b = 20), hjust = 0.5),
        legend.position = "none",
        plot.margin = unit(c(1, 1.5, 1, 1), "cm"),
        axis.ticks = element_blank()
    )

ggsave("plot.png")
