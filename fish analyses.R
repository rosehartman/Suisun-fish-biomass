#fish analyses

library(tidyverse)
library(readxl)
library(lubridate)

#import data

fishcatch = read_excel("fishcatch.xlsx")

str(fishcatch)

#make a unique sample ID
fishcatch = mutate(fishcatch, sample = paste(StationCode, MethodCode, SampleDate), Year = year(SampleDate))

ggplot(fishcatch, aes(x = Year)) + geom_bar()+
  facet_wrap(~StationCode, scales = "free_y")

#table of samples per year
samps = as.data.frame(table(fishcatch$StationCode, fishcatch$Year))
names(samps) = c("StationCode", "Year", "count")

fishRecent = filter(fishcatch, Year > 1995)
