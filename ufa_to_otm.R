ufa <-read.csv('ufa.csv',header=TRUE)

attach(ufa)

ufa_subset<-ufa[c("X","Y","FACILITYID","VICINITY","TBOX_L","TBOX_W","TBOX_STAT","SCI_NM","CMMN_NM","DATE_PLANT","DBH")]

ufa_subset$FACILITYID <- gsub("-","",ufa_subset$FACILITYID)
ufa_subset$TBOX_STAT <- ufa_subset$TBOX_STAT=="Plant"
ufa_subset$DATE_PLANT <- sub("T.*","",ufa_subset$DATE_PLANT)
  
ufa_subset$Other <- as.character(lapply(strsplit(as.character(SCI_NM), split=" x "), "[", 1))
ufa_subset$Cultivar <- as.character(lapply(strsplit(as.character(SCI_NM), split=" x "), "[", 2))
ufa_subset$Genus <- sub("^(\\w+)\\s?(.*)$","\\2",ufa_subset$Other)
ufa_subset$Species <- sub("^(\\w+)\\s?(.*)$","\\1",ufa_subset$Other)

ufa_subset$Genus <- sub("^\\(See Notes\\)$","NA",ufa_subset$Genus)
ufa_subset$Species <- sub("^Other$","NA",ufa_subset$Species)
ufa_subset$CMMN_NM <- sub("^Other \\(See Notes\\)$","NA",ufa_subset$CMMN_NM)

ufa_subset$Other <- NULL
ufa_subset$SCI_NM <- NULL

names(ufa_subset)[names(ufa_subset)=="X"] <- "Point X"
names(ufa_subset)[names(ufa_subset)=="Y"] <- "Point Y"
names(ufa_subset)[names(ufa_subset)=="FACILITYID"] <- "External ID Number"
names(ufa_subset)[names(ufa_subset)=="VICINITY"] <- "Street Address"
names(ufa_subset)[names(ufa_subset)=="TBOX_L"] <- "Plot Length"
names(ufa_subset)[names(ufa_subset)=="TBOX_W"] <- "Plot Width"
names(ufa_subset)[names(ufa_subset)=="TBOX_STAT"] <- "Tree Present"
names(ufa_subset)[names(ufa_subset)=="CMMN_NM"] <- "Common Name"
names(ufa_subset)[names(ufa_subset)=="DATE_PLANT"] <- "Date Planted"
names(ufa_subset)[names(ufa_subset)=="DBH"] <- "Diameter"

write.csv(ufa_subset,'ufa_otm.csv')