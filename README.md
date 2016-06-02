# Developing Data Products Project

## Description

This is a simple shiny application, composed of server.R and ui.R, and published to shinyapps.io, where it can be accessed at 
 https://anfe67.shinyapps.io/DevDataProductsProj/.  

The data used for the application is by NASA GISS Surface Temperature Analysis (GISTEMP).

(http://data.giss.nasa.gov/gistemp/). The values are differences from the means for years 1951-1980 expressed in Farenheit degrees. The Data consists of :

* Individual Months global averages 1881 - 2015 (I removed 1880 and 2016 because incomplete)
* Aggregated seasonal averages (WINTER=DJF, SPRING=MAM, SUMMER=JJA, FALL=SON)
* The dataset also contains two times the year of the observation, I removed one.

The application produces line plots of x=year vs y = selected months or seasonal global aggregated temperatures. 

## Inputs and Outputs 

There are two basic controls, 

* A checkboxGroupInput to select the averages to plot 
* A range type slider to select the time period


