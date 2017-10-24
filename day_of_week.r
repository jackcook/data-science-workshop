train_data <- train[train$passenger_count > 0 & train$passenger_count < 7, ] %>%
    mutate(wday = wday(pickup_datetime, label = TRUE)) %>%
    group_by(wday) %>%
    count()

train_data %>%
    ggplot(aes(wday, n, fill = wday)) +
    geom_point(color = "#34495e", size = 6) +
    labs(x = "Day", y = "", title = "Number of NYC Taxi Rides") +
    scale_y_continuous(label = unit_format(unit = "k", scale = 1e-3, sep = "")) +
    atom_theme

ggsave("day_of_week.png")