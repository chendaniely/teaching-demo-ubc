library(tidyverse)

# Column headers are values, not variable names -----
tumor <- read_csv("./data/tumorgrowth_long.csv")

tumor_tidy <- tumor %>%
  pivot_longer(`0`:last_col(), names_to = "day", values_to = "size")

tumor_tidy %>%
  drop_na()

# Multiple variables stored in one column -----

tb <- read_csv("./data/tb_long.csv")

tb_tidy <- tb %>%
  pivot_longer(starts_with(c('m', 'f')))

tb_tidy <- tb_tidy %>%
  separate(name, into = c("sex", "age_group"), sep = 1)

tb_tidy %>%
  drop_na()

## Exercise 2

ebola <- read_csv("data/ebola.csv") %>%
  rename(date = Date, day = Day)
ebola

## Exercise 2 solution
solution_tidy2 <- ebola %>%
  pivot_longer(cols = c(-date, -day)) %>%
  separate(name, into = c("case_death", "country"), sep = "_") %>%
  drop_na()

solution_tidy2

# Variables are stored in both rows and columns -----

# medicare data on spending
cms <- read_csv("./data/cms_utilization.csv")
cms

cms_long <- cms %>%
  pivot_longer(`2007`:last_col(), names_to = "year")

cms_long


cms_tidy <- cms_long %>%
  pivot_wider(names_from = variable, values_from = value)

cms_tidy

cms_tidy %>%
  group_by(year, age_group) %>%
  summarize(avg_spending = mean(`Per Capita Spending-Actual ($)`, na.rm = TRUE))

cms_long %>%
  group_by(year, age_group, variable) %>%
  summarise(avg = mean(value, na.rm=TRUE))

# exercise -----

# ebola Example

ebola <- read_csv("data/ebola.csv")

ebola %>%
  pivot_longer(`Cases_Guinea`:last_col()) %>%
  separate(name, into = c("case_death", "country"), sep = "_") %>%
  pivot_wider(names_from = case_death, values_from = value) %>%
  drop_na()


# summative -----

library(readxl)
library(writexl)

dirty <- read_excel("data/cmv.xlsx")

# solution
# clean <- dirty %>%
#   pivot_longer(cols = c(donor_negative, donor_positive),
#                names_to = "donor_status",
#                values_to = "recipient_status",
#                values_drop_na = TRUE)

write_xlsx(clean, "data/cmv_clean.xlsx")
