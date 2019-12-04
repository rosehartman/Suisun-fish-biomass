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

#table of samples per station per year
samps = group_by(fishcatch, StationCode, Year, MethodCode) %>%
  summarize(ntrawl = length(unique(sample)))

#filter it to the past 20 years
fishRecent = filter(fishcatch, Year > 1997)
sampsRecent = filter(samps, Year >1997)

#Check out which stations are sampled continuously
stas = group_by(sampsRecent, StationCode, MethodCode) %>%
  summarize(trawls = sum(ntrawl))

#WE SHOULD probably take out all the beach seines, midwtaer trawls,
#and all the stations that are sampled less than 20 times in the past 20 years

fishR2 = filter(fishRecent, MethodCode == "OTR", StationCode %in% 
                  stas$StationCode[which(stas$trawls>20)])

#what stations are left?
unique(fishR2$StationCode)

#how does the sampling balance across months?
fishR2$Month = month(fishR2$SampleDate)


#it looks like we have roughly even distribution of samples across the year
stas2 = group_by(fishR2, StationCode, Month) %>%
  summarize(trawls = length(unique(sample)))
ggplot(stas2, aes(x= Month, y = trawls)) + geom_bar(stat = "identity") +
  facet_wrap(~StationCode)

