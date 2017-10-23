library(data.table)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tibble)
library(tidyr)

train <- as.tibble(fread('./Desktop/train.csv'))

train %>%
    mutate(hpick = hour(pickup_datetime)) %>%
    group_by(hpick, vendor_id) %>%
    summarise(median_duration = median(trip_duration)/60) %>%
    ggplot(aes(hpick, median_duration, color = vendor_id)) +
    geom_smooth(method = "loess", span = 1/2) +
    geom_point(size = 4) +
    labs(x = "Hour of the day", y = "Median trip duration [min]") +
    theme(legend.position = "none")
