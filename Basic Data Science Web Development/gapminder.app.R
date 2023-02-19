library(tidyverse)
library(shiny)
library(ggplot2)
library(plotly)

gapminder <- read.csv("gapminder_clean.csv") %>% filter(continent != "")
new_names <- c("Agriculture, value added (% of GDP)", "CO2 emissions (metric tons per capita)", "Domestic credit provided by financial sector (% of GDP)",
                         "Electric power consumption (kWh per capita)", "Energy use (kg of oil per capita)", "Exports of goods and services (% of GDP)", "Fertility rate, total (births per woman)", 
                         "GDP growth (annual %)", "Imports of goods and services (% of GDP)", "Industry, value added (% of GDP)", "Inflation, GDP Deflator (annual %)", "Life expectancy at birth, total (years)", 
                         "Population density (people per sq km of land area)", "Services, etc., value added (% of GDP)", "GDP per capita")
variables <- colnames(gapminder)[! colnames(gapminder) %in% c("X", "Country.Name", "Year", "pop", "continent")]

label_text <- setNames(new_names, variables)


ui <- fluidPage(
  titlePanel("Explore the Gapminder Dataset!"),
  fluidRow(
    column(6, selectInput("x", label = "X-Axis", 
                       choices = setNames(variables, new_names), 
                       width = "100%")), 
    column(6, selectInput("y", label = "Y-Axis",
                        choices = setNames(variables, new_names),
                        width = "100%"))
  ),
  fluidRow(
    column(6, radioButtons("xscale", "X-Axis Scale", 
                           c("Linear" = "identity", 
                             "Logarithmic" = "log"))),
    column(6, radioButtons("yscale", "Y-Axis Scale", 
                           c("Linear" = "identity", 
                             "Logarithmic" = "log")))
  ),
  fluidRow(
    column(12, sliderInput("year", "Year", 
                           min = 1962, max = 2007,
                           value = 1962, step = 5, sep = ""))
  ),
  fluidRow(
    column(12, plotlyOutput("plot"))
  )
)

server <- function(input, output, session){
  
  selected_data <- reactive({
    data <- gapminder %>% filter(Year == input$year)
    df <- data[, c("Country.Name", "continent", "pop", input$x, input$y)]
    df <- df %>% na.omit()
  })

  
  output$plot <- renderPlotly({
    df <- selected_data()
    
    p <-  ggplot(data = df, aes(x = df[, input$x], y = df[, input$y], size = pop, text = paste0("Country: ", Country.Name, "\nContinent: ", continent, "\nPopulation: ", pop, "\n", label_text[input$x], ": ", get(input$x), "\n", label_text[input$y], ": ", get(input$y)))) + 
      geom_point(aes(fill = continent), alpha = 0.5, color = "black", pch= 21) +
      scale_size(range = c(.1, 24), guide = "none") +
      xlab(label_text[input$x]) + ylab(label_text[input$y])
    
    ggplotly(p, tooltip = "text", dynamicTicks = TRUE, height = 900, width = 1200) %>% layout(xaxis = list(type = input$xscale), yaxis = list(type = input$yscale), legend = list(title = list(text = "<b> Continent </b>")))
    
  }
  )
}

shinyApp(ui, server)
