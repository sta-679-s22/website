library(hexSticker)
library(tidyverse)
library(touringplans)
library(broom)

seven_dwarfs <- seven_dwarfs_train_2018 %>%
  filter(hour == 17)

seven_dwarfs_with_ps <- glm(
  extra_magic_morning ~ wdw_ticket_season + close + weather_wdwhigh,
  data = seven_dwarfs,
  family = binomial()
) %>%
  augment(type.predict = "response", data = seven_dwarfs)
p <- ggplot() +
  geom_histogram(
    data = seven_dwarfs_with_ps %>% filter(extra_magic_morning == 1),
    aes(x = .fitted),
    fill = "#6667AB",
    bins = 40
  ) +
  geom_histogram(
    data = seven_dwarfs_with_ps %>% filter(extra_magic_morning == 0),
    aes(
      x = .fitted,
      y = -after_stat(count)
    ),
    fill = "#e2c1c0",
    bins = 40
  ) +
  labs(x = "",
       y = "") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text = element_blank(),
        panel.grid = element_blank())


sticker(p,
        package = "STA 679", 
        p_size = 15,
        s_x = 1,
        s_y = .75,
        s_width = 2,
        s_height = 1.2,
        filename = "images/icon.png",
        h_color = "#6667AB",
        h_fill = "white",
        p_color = "#6667AB")
