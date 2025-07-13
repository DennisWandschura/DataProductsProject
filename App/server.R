#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)
library(ggiraphExtra)

# Define server logic required to draw a histogram
function(input, output, session) {
    
    mydata <- iris
    model1 <- lm(Sepal.Length ~ Petal.Length, mydata)
    model2 <- lm(Sepal.Length ~ Petal.Length + Petal.Width, mydata)
    rangePetalLength <- range(mydata$Petal.Length)
    
    predict1 <- reactive({
       value <- predict(model1, data.frame(Petal.Length = input$petalLength))
       data.frame(Sepal.Length = value, Petal.Length = input$petalLength)
    })
    
    predict2 <- reactive({
        value <- predict(model2, data.frame(Petal.Length = input$petalLength, Petal.Width = input$petalWidth))
        data.frame(Sepal.Length = value, Petal.Length = input$petalLength, Petal.Width = input$petalWidth)
    })

    output$myPlot <- renderPlot({
       gg <- ggplot(mydata, aes(y = Sepal.Length, x = Petal.Length)) + 
            geom_point()
       
       if(input$showModel1)
       {
           gg <- gg + stat_smooth(method = "lm", formula = y ~ x, color = "red", se = FALSE) + 
           geom_point(data = predict1(), color = "red", size = 4)
       }
       
       if(input$showModel2)
        {
           linePoints <- predict(model2, data.frame(Petal.Length = rangePetalLength, Petal.Width = input$petalWidth))
           lineData <- data.frame(Petal.Length = rangePetalLength, Sepal.Length = linePoints)
           
           gg <- gg + geom_point(data = predict2(), color = "blue", size = 4) + 
               geom_line(data = lineData, color = "blue")  
       } 
       
       gg
    })
}
