library(tidyverse)

cms <- read_csv("data/cms_utilization.csv")
cms

cms_long <- cms %>%
  pivot_longer(`2007`:last_col(), names_to = "year")

cms_tidy <- cms_long %>%
  pivot_wider(names_from = variable, values_from = value)

cms_tidy %>%
  group_by(year, age_group) %>%
  summarize(avg_spending = mean(`Per Capita Spending-Actual ($)`, na.rm = TRUE))

cms_long %>%
  group_by(year, age_group, variable) %>%
  summarize(avg = mean(value, na.rm = TRUE))

# exerxise
ebola <- read_csv("data/ebola.csv")
ebola

# solution
ebola %>%
  pivot_longer(`Cases_Guinea`:last_col()) %>%
  separate(name, into = c("case_death", "country"), sep = "_") %>%
  pivot_wider(names_from = case_death, values_from = value) %>%
  drop_na()
