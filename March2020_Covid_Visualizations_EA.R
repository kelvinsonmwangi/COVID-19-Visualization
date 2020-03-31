library(tidyverse)
library(gganimate)
library(gifski)
library(rtweet)

coviddata <-read_csv("https://covid.ourworldindata.org/data/ecdc/total_cases.csv")

easternafrica <- coviddata %>% 
  select(date, Kenya, Uganda, Tanzania, Rwanda, Ethiopia) %>% 
  gather(key = "country", "cases", -date)

easternafrica <- easternafrica[!is.na(easternafrica$cases), ] 

plot <- easternafrica %>% 
ggplot() +
  geom_line(aes( x = date, y = cases, color = country), size = 1) +
  labs(title = "Trends in COVID-19 cases in Eastern Africa", 
       subtitle = "Data Source: https://ourworldindata.org/coronavirus-source-data", 
       caption = "Code://https://github.com/kelvinsonmwangi/COVID-19-Visualization") +
  xlab("")+
  ylab("Confirmed cases") +
  theme_test(base_size = 14) +
  transition_reveal(date)

animate(plot, nframes = 150, renderer = gifski_renderer("COVID-19EA.gif"))

#Spread the news
post_tweet(
  status = "Visualizing changes in COVID-19 confirmed cases across Eastern Africa using #rstats ",
  media = 'COVID-19EA.gif'
)
