# FGDC_servicelist_GP
The file titled "all_service_info.xml" is a list of all services tagged in the Geoplatform Resilience Community (https://communities.geoplatform.gov/resilience/).

This list is an ATOM feed specifically formatted for input to the FGDC Service Status Checker (https://statuschecker.fgdc.gov/). The FGDC Service Status Checker checks the health and status of the services in the Resilience Community daily and emails a report to the DCD project lead. (Currently being emailed to jeanne.leroux@nsstc.uah.edu).

The "GP_services.R" script can be used to automatically update the ATOM feed in the event that services tagged in the Resilience Community change (e.g. a service URL might change, when a new version of a service becomes available, etc.). The R script grabs the necessary information about the services tagged
in the Resilience Community and outputs it into the appropriately formatted XML file for the ATOM feed, as well as a CSV copy. Newly generated XML and CSV files should be re-uploaded to this repo to replace the outdated files as needed. 

Please contact Jeanne le Roux at jeanne.leroux@nsstc.uah.edu for questions.
