# Coursera - Developing Data Products- Course Project

# server.R file for the shiny app

# This app was developed to help people choose the best car for their trip, 
# using mtcars dataset, from [R]

library(shiny)
library(datasets)
library(dplyr)
library(rCharts)

shinyServer(function(input, output) {
  
  
  # Show the top economical cars based on the set filters
  output$CarPlot <- renderPlot({
    
    disp_seq <- seq(from = input$disp[1], to = input$disp[2], by = 0.1)
    hp_seq <- seq(from = input$hp[1], to = input$hp[2], by = 1)
    
    data <- transmute(mtcars, Car = rownames(mtcars), MilesPerGallon = mpg, 
                      GasolineExpenditure = input$dis/mpg*input$cost,
                      Cylinders = cyl, Displacement = disp, Horsepower = hp, 
                      Transmission = am)
    data <- filter(data, GasolineExpenditure <= input$gas, Cylinders %in% input$cyl, 
                   Displacement %in% disp_seq, Horsepower %in% hp_seq, Transmission %in% input$am)
    data <- mutate(data, Transmission = ifelse(Transmission==0, "Automatic", "Manual"))
    data <- arrange(data, GasolineExpenditure)
    
    # Set the parametrs of the plot
    par(las=2) # make label text perpendicular to axis
    par(mar=c(5,8,4,2)) # increase y-axis margin.
    counts <- data$GasolineExpenditure[1:5]
    counts<-round(counts, digits=2)
    bplt<-barplot(counts, main="Cars with least gas cost per trip",main.lab=2, font =2, horiz=TRUE, names.arg=data$Car[1:5], cex.names=0.8, xlim=range(0:50), col=c("red", "green", "yellow", "blue", "orange"), xlab='Trip Cost in $', cex.main=2, cex.axis=1.5,cex.lab=2)
    
    text(x=counts +2, y= bplt, labels=as.character(counts), xpd=TRUE)
    
    
  } )
})