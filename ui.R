library(shiny)
library(plotly)
library(latex2exp)

# loss function 
shinyUI(fluidPage(
  fluidRow(
    column(4, offset = 8,
           sliderInput("s", withMathJax("$$s_\\lambda$$"),
           min = 1, max = 20, value = 1)),
    column(6, plotlyOutput("two_d")),
    column(6, plotlyOutput("thr_d"))
    )
  )
)