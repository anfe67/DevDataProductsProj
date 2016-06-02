library(shiny)

# Read GISTEMP data
gisTempData <- read.csv("GISTEMPData.csv")

# Remove columns that I do not plan to use...
gisTempData$J.D<-NULL
gisTempData$D.N <-NULL

# Rename last 4 columns
names(gisTempData)[14]<-"WINTER"
names(gisTempData)[15]<-"SPRING"
names(gisTempData)[16]<-"SUMMER"
names(gisTempData)[17]<-"FALL"

checkBoxes<-setdiff(names(gisTempData), c("Year", "Year.1"))

shinyUI(pageWithSidebar(
      headerPanel('Deviation of world temperature from mean 1951-1980. Source: NASA GISTEMP'),
      sidebarPanel(
            sidebarLayout(
                  
                        checkboxGroupInput('show_lines', 'Variables in GISTEMP to Plot:', checkBoxes),
                        # Simple Range
                        sliderInput("range", "Years:",
                                    min = 1881, max = 2015, value = c(1881,2015), width="300px", ticks=TRUE)
                  )
      ),
      mainPanel(
            plotOutput('myplot'),
            helpText("How to use:
                      Select months or seasons and they will be displayed as line plots. 
                      Seasonal average deviations from mean(1951-1980) are displayed in 
                      dotted format. Year range selection can be performed with the slider.
                      Important: This is just data visualization, there is no statistical 
                      modeling behind, data is as downloaded, I just removed data from 
                      1880 and 2016 because they were incomplete. 
                      Data source: NASA GISTEMP (http://data.giss.nasa.gov/gistemp/)")      
      )
))



