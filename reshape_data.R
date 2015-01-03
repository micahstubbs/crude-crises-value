setwd("~/workspace/crude-crises-value")

dubai <- read.csv(file="WORLDBANK-WLD_CRUDE_DUBAI.csv",head=TRUE,sep=",")
brent <- read.csv(file="WORLDBANK-WLD_CRUDE_BRENT.csv",head=TRUE,sep=",")
wti <- read.csv(file="WORLDBANK-WLD_CRUDE_WTI.csv",head=TRUE,sep=",")

dubai$priceName <- c("Dubai Crude")
brent$priceName <- c("Brent Crude")
wti$priceName <- c("West Texas Intermediate")

dubai$symbol <- c("DB")
brent$symbol <- c("BZ")
wti$symbol <- c("CL")

# using the reshape and reshape2 package to merge the dataframes
# http://davetang.org/muse/2014/04/14/merging-multiple-data-frames/
library(reshape)
library(reshape2)
list_df <- list(dubai,brent,wti)
crude_price_history <- merge_all(list_df)

####

# plot a line chart
library(ggplot2)
ggplot(data=crude_price_history, aes(x=Date, y=Value, group=priceName, colour=priceName)) + geom_line() + geom_point()

####

