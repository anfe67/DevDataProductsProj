# This server.R reacts to modification of two inputs on the ui.T 
# to produce a plot of the world (global aggregates) temperatures 
# from 1882 to 2014. (data from 1881 and 2014 are incomplete)
# Data Source is NASA GISTEMP (http://data.giss.nasa.gov/gistemp/).  
#
# The two inputs are a checkboxGroupInput to select the features 
# to be plotted and a sliderInput to select the years range to plot. 
# Seasonal averages are plotted with a dotted line, a bit thicker. 
# 
# Seasons are approximated, being the average of 3 calendar months. 
# The data represented are deviations from the 1951-1980 means 

library(ggplot2)

# Read GISTEMP data (I have eliminated data for 1881 and 2016, 
# which are incomplete)
gisTempData <- read.csv("GISTEMPData.csv", header = TRUE)

# Remove columns that I do not plan to use...
gisTempData$J.D<-NULL
gisTempData$D.N <-NULL

# Rename last 4 columns
names(gisTempData)[14]<-"WINTER"
names(gisTempData)[15]<-"SPRING"
names(gisTempData)[16]<-"SUMMER"
names(gisTempData)[17]<-"FALL"

# Do not need the year in the checkboxes... 
colorBreaks<-setdiff(names(gisTempData), c("Year", "Year.1"))

# Omitting NAs
gisTempData<-na.exclude(gisTempData)

# Winter months in shades of blue, etc
predefinedColours=c("deepskyblue3",    # JANUARY 
                    "deepskyblue4",    # FEBRUARY
                    "chartreuse2",     # MARCH
                    "chartreuse3",     # APRIL
                    "chartreuse4",     # MAY
                    "firebrick2",      # JUNE
                    "firebrick3",      # JULY
                    "firebrick4",      # AUGUST
                    "chocolate2",      # SEPTEMBER
                    "chocolate3",      # OCTOBER
                    "chocolate4",      # NOVEMBER
                    "deepskyblue2",    # DECEMBER
                    "blue",            # WINTER 
                    "green",           # SPRING
                    "red",             # SUMMER
                    "brown" )          # FALL

shinyServer(
      function(input, output) {
            # Check which lines are needed..

            output$myplot <- renderPlot({
                                          # Selecting the data based on the slider... 
                                          gisTempData<-gisTempData[(gisTempData$Year >= input$range[1] ) & (gisTempData$Year <= input$range[2] ), ]

                                          # There is nothing selected to plot...                                           
                                          if (is.null(input$show_lines))
                                                return()
                                          
                                          # My x axis are the selected years  
                                          myp <- ggplot(data=gisTempData, aes(x=Year))

                                          if ("Jan" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Jan, color='Jan'))

                                          if ("Feb" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Feb, color='Feb'))

                                          if ("Mar" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Mar, color='Mar'))

                                          if ("Apr" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Apr, color='Apr'))

                                          if ("May" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=May, color='May'))

                                          if ("Jun" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Jun, color='Jun'))

                                          if ("Jul" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Jul, color='Jul'))

                                          if ("Aug" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Aug, color='Aug'))

                                          if ("Sep" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Sep, color='Sep'))

                                          if ("Oct" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Oct, color='Oct'))

                                          if ("Nov" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Nov, color='Nov'))
                                          
                                          if ("Dec" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=Dec, color='Dec'))

                                          if ("WINTER" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=WINTER, color='WINTER'), linetype='dotted', size=1.2)

                                          if ("SUMMER" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=SUMMER, color='SUMMER'), linetype="dotted", size=1.2)

                                          if ("FALL" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=FALL, color='FALL'), linetype="dotted", size=1.2)

                                          if ("SPRING" %in% input$show_lines)
                                                myp <- myp + geom_line(aes(y=SPRING, color='SPRING'), linetype="dotted", size=1.2)

                                          # Trying to have always the same colors... 
                                          usedColorIndexes <- which(colorBreaks %in% input$show_lines) 
                                          usedColors <- predefinedColours[usedColorIndexes]
                                          
                                          myp <- myp + labs(title ="Temperature deviations", x = "Year", y = "Seasonal Averages")
                                          
                                          myp <- myp + scale_colour_manual(values=usedColors, breaks=input$show_lines)
                                          myp
                  })      }
)
