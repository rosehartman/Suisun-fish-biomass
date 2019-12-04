#analysis of area of wetlands near UC Davis SuisuN marsh fish sampling locations
#Rosemary Hartman
# 12/2/2019

library(tidyverse)
library(lubridate)

wetarea = read.csv("wetlandarea.csv")

wetarea2 = group_by(wetarea, Code, SiteName, Slough, Descriptor, Status, Type) %>%
  summarize(wet = sum(Shape_Area))

#now lets do it by vegetation type
vegarea= group_by(wetarea, Code, SiteName, Slough, Descriptor, Status, Type, CalVegName) %>%
  summarize(wet = sum(Shape_Area))

#now whether it is tidal or non-tidal wetland
tidalarea= group_by(wetarea, Code, SiteName, Slough, Descriptor, Status, Type, Habitat) %>%
  summarize(wet = sum(Shape_Area))

#I changed something here