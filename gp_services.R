#this script uses the GeoPlatform API to obtain all the services registered in the resilience community.
#once the the service information is gathered, an output csv is created of the information required by FGDC 
#in order to register an ATOM feed to check the services. Once in the CSV, you can export the table as an XML file
#and upload it to the Github ATOM feed.
#Github ATOM feed: https://raw.githubusercontent.com/fkcook/FGDC_servicelist_GP/master/all_service_info_master_update_march5.xml
#FGDC Status checker links: https://statuschecker.fgdc.gov/main-report/impact_161 ||| https://statuschecker.fgdc.gov/dashboard/impact_161

#Package to work with JSON in R (you will need to import from the Packages tab to the right)
#if not already installed, be sure to install the package in RStudio
library(RJSONIO) 

#Read the JSON text from the following URL
services <- fromJSON("https://ual.geoplatform.gov/api/communities/4eebc494059beab9fda54cb078927ddc/items?type=regp:Service&size=200")

#Create an empty vector to hold all of the service IDs
id <- c()
title <- c() 

#Loop through each service entry in the JSON file (now an R list)
for(i in 1:length(services[[1]])){
  id[i] <- services[[1]][[i]][['id']] 
  title[i] <- services[[1]][[i]][['label']] 
}

#Create an empty vector to hold all of the service urls
serviceUrl <- c()
service_types <- c()

#Now loop though each service to get its URL (this could take a few seconds)
for(i in 1:length(services[[1]])){
  service_info <- fromJSON(paste0("https://ual.geoplatform.gov/api/services/", id[i]))
  serviceUrl[i] <- service_info$href
  service_types[i] <- service_info$serviceType$label
}
#Substitute titles with FGDC required fields into a new vector 
service_typesnew <- gsub("Esri REST Map Service", "agsmapserver", service_types)

#repeat step with replace service_types with service_typesnew until all replaced
service_typesnew1 <- gsub("Esri REST Tile Service", "agsmapserver", service_typesnew)
service_typesnew2 <- gsub("Esri REST Feature Service", "agsfeatureserver", service_typesnew1)
service_typesnew3 <- gsub("Esri REST Image Service", "agsimageserver", service_typesnew2)
service_typesnew4 <- gsub("OGC Web Map Service \\(WMS\\)", "wms", service_typesnew3)
serviceType <- gsub("OGC Web Feature Service \\(WFS\\)", "wfs", service_typesnew4)

#Create a data frame of the info so far
all_service_info <- data.frame(id, title, serviceType, serviceUrl, stringsAsFactors = FALSE)
View(all_service_info) #View the data frame

#Write the data frame to a CSV
write.table(all_service_info, quote=FALSE, row.names = FALSE, col.names = c("id", "title", "serviceType", "serviceUrl"), file = "all_service_info.csv", sep = ",")

#Write the data frame to an XML file
#Package to work with writing XML, will need to be installed if not already installed
library(XML)

#Referencing column names that will make up the tags in the XML
names(all_service_info) <-c("id","title", "serviceType", "serviceURL")

#Begin writing XML by adding tags using a for loop to achieve the desired tree structure
xml <- xmlTree()

xml$addTag("feed", close = FALSE, namespace = list(xsi = "http://www.w3.org/2001/XMLSchema-instance"))
for(i in 1:nrow(all_service_info)) {
  xml$addTag("entry", close = FALSE)
  
  for(j in names(all_service_info)) {
    xml$addTag(j, all_service_info[i,j])
  }
  xml$closeTag()
}
xml$closeTag()

#View the xml before saving to ensure desired output
xml$value()
#Save the xml
cat(saveXML(xml$value(), encoding = "UTF-8", indent = TRUE, prefix = '<?xml version="1.0" encoding "UTF-8" standalone = "yes"?>'), file = "all_service_info.xml")

