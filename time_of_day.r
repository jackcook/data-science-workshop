train_data <- train %>%
    mutate(hpick = hour(pickup_datetime)) %>%
    group_by(hpick) %>%
    summarise(median_duration = median(trip_duration)/60)

train_data <- add_row(train_data, hpick = 24, median_duration = train_data[[2]][1])

train_data %>%
    ggplot(aes(hpick, median_duration)) +
    geom_smooth(color = "#34495e", fill = "#2c3e50", method = "loess", span = 1/2, level = 0.5) +
    geom_smooth(color = "#34495e", fill = "#2c3e50", method = "loess", span = 1/2, level = 0.95) +
    labs(x = "Time", y = "Median Duration", title = "Duration of NYC Taxi Rides") +
    scale_x_continuous(breaks = c(0, 6, 12, 18, 24), labels = c("12am", "6am", "12pm", "6pm", "12am")) +
    scale_y_continuous(breaks = c(9, 10, 11, 12), labels = c("9", "10", "11", "12 minutes")) +
    atom_theme +
    theme(
        axis.text.y = element_text(hjust = 0, margin = margin(r = -50)),
        axis.title.y = element_text(margin = margin(r = 20))
    )

ggsave("time_of_day.png")
