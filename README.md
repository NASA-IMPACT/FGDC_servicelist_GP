# FGDC_servicelist_GP
List of services tagged in the Geoplatform Resilience Community (https://communities.geoplatform.gov/resilience/).

This list is an ATOM feed specifically formatted for input to the FGDC Service Status Checker (https://statuschecker.fgdc.gov/). The FGDC Service Status Checker checks the health and status of the services in the Resilience Community daily and emails a report to the DCD project lead.

The "GP_services.R" script can be used to automatically update the ATOM feed in the event that services tagged in the Resilience Community change (e.g. a service URLs might change, a new version of a service might become available, etc.). The R script grabs the necessary information about the services tagged
in the Resilience Community and outputs it into a CSV file. Once in the CSV, the info can be exported as an XML file using the XML
"all_service_info.xml" file as the appropriate mapping file (note: the code is the process of being updated to automatically output the results in the appropriate XML format as opposed a CSV that needs to be manually converted to an XML). Copy and paste the XML information
into the github service info file. 
Contact Jeanne le Roux at jeanne.leroux@nsstc.uah.edu for questions.
