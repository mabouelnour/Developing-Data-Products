# Final Project - DDP- Coursera Data Science Specialization

# ui.R file for the shiny app

# App to choose the most economical car for the trip - based on gas consumption-  using mtcars dataset, from [R] 

library(markdown)

shinyUI(navbarPage("Choose the best car to save on gas for the trip",
                   tabPanel("Top 5 Graph",
                            
                            # Sidebar
                            sidebarLayout(
                              sidebarPanel(
                                helpText("Choose the Trip and Car paramters to find the best  choices"),
                                sliderInput('dis', 'Trip Distance in MIles:',  325, min = 50, max = 400),
                                sliderInput('cost', 'Gas Price Per Gallon:', 2.7, min = 1.8, max = 3.0, step=0.01),
                                sliderInput('gas', 'Maximum Gas Budget for the Trip', 35, min=1, max=50),
                                checkboxGroupInput('cyl', 'Number of cylinders to Consider:', c("Four"=4, "Six"=6, "Eight"=8), selected = c(4,6,8)),
                                sliderInput('disp', 'Displacement', min=70, max=480, value=c(70,480), step=10),
                                sliderInput('hp', 'Car Horse Power ', min=,min(mtcars$hp), max=max(mtcars$hp), value=c(50,340), step=10),
                                checkboxGroupInput('am', 'Car Transmission:', c("Automatic"=0, "Manual"=1), selected = c(0,1))
                              ),
                              
                              
                              mainPanel(
                             #dataTableOutput('table')
                                h3("Plot of the Top 5 efficient cars based on your selections", align="center")  ,
                                plotOutput("CarPlot") 
                                
                              )
                            )
                   ),
                   tabPanel("Help",
                            mainPanel(
                              #includeMarkdown("about.md")
                              helpText("This App can help when making a decsision to rent a car for a trip if the decision is based solely on gas cost")
                            )
                   )
)
)   