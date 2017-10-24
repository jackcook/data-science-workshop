train_data <- train[train$passenger_count > 0 & train$passenger_count < 7, ] %>%
    group_by(passenger_count) %>%
    count()

train_data %>%
    ggplot(aes(passenger_count, n, fill = passenger_count)) +
    geom_col() +
    labs(x = "Passengers", y = "", title = "Number of NYC Taxi Rides") +
    scale_x_continuous(breaks = c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)) +
    scale_y_sqrt(label = unit_format(unit = "k", scale = 1e-3, sep = "")) +
    atom_theme

ggsave("passenger_count.png")