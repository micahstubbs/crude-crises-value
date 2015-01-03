setwd("~/workspace/crude-crises-value")

# data from Quandl
# https://www.quandl.com/c/markets/crude-oil

wti_nymex <- read.csv(file="CHRIS-CME_CL1.csv",head=TRUE,sep=",")
wti_spot <- read.csv(file="DOE-RWTC.csv",head=TRUE,sep=",")
brent_ice <- read.csv(file="CHRIS-ICE_B1.csv",head=TRUE,sep=",")
brent_spot <- read.csv(file="DOE-RBRTE.csv",head=TRUE,sep=",")
opec_basket <- read.csv(file="OPEC-ORB.csv",head=TRUE,sep=",")

wti_nymex$priceName <- c("WTI Nymex")
wti_nymex$description <-c("Crude Oil Futures, Continuous Contract #1 (CL1) (Front Month)")
wti_nymex$Value <- c(wti_nymex$Settle)

brent_ice$priceName <- c("Brent ICE")
brent_ice$description <- c("Brent Crude Futures, Continuous Contract #1 (B1) (Front Month)")
brent_ice$Value <- c(brent_ice$Settle)

wti_spot$priceName <- c("WTI Spot")
wti_spot$description <- c("WTI Crude Oil Spot Price Cushing, OK FOB")

brent_spot$priceName <- c("Brent Spot")
brent_spot$description <- c("Europe Brent Crude Oil Spot Price FOB")

opec_basket$priceName <- c("OPEC Basket")
opec_basket$description <- c("OPEC Crude Oil Price")

# using the reshape and reshape2 package to merge the dataframes
# http://davetang.org/muse/2014/04/14/merging-multiple-data-frames/
library(reshape)
library(reshape2)
list_df <- list(wti_nymex, wti_spot, brent_ice, brent_spot, opec_basket)
crude_price_history <- merge_all(list_df)

write.csv(crude_price_history, file = "crude_price_history.csv",row.names=FALSE, na="")

####

# plot a line chart
library(ggplot2)
ggplot(data=crude_price_history, aes(x=Date, y=Value, group=priceName, colour=priceName)) + geom_line() + geom_point()

####

