#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Predicting sepal length"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("petalLength", "Petal length:", min = 1, max = 10.0, value = 2.0),
            sliderInput("petalWidth", "Petal width:", min = 0.1, max = 5.0, value = 1.0),
            checkboxInput("showModel1","Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2","Show/Hide Model 2", value = TRUE)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("myPlot")
        )
    )
)
