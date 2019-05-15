library(jsonlite)
library(tidyverse)
stores <- fromJSON("stores.json")
stores <- stores$data
stores <- cbind(stores, c(stores$address, stores$coordinates, stores$today))%>%
  select(-address,-coordinates,-today) %>%
  tbl_df()
colnames(stores)[6:8] <- c("district", "address1", "address2")

stores1 <- select(stores,-features)
stores1$city <- as.character(stores1$city)
stores1$district <- as.character(stores1$district)
stores1$address1 <- as.character(stores1$address1)
stores1$address2 <- as.character(stores1$address2)
stores1$postalCode <- as.character(stores1$postalCode)

stores1$city[which(stores1$city=="Beijing")] <- "北京市"
stores1$city[which(stores1$city=="Guangzhou")] <- "广州市"
paste(stores1$city[-grep(pattern = "市", x=stores1$city)], "市", sep = "")