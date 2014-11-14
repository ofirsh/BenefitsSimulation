
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/

# http://benefits.shinyapps.io/BenefitsSimulation

# install.packages("shiny")
# library(shiny)
# runApp()

# deploy to Shiny hosted server
# https://github.com/rstudio/shinyapps/blob/master/guide/guide.md

# > shinyapps::setAccountInfo(name='benefits', token='xxxx', secret='yyyy')
# change the xxx and yyy with tokens from the shinyapps account
# > deployApp()


library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Cost Optimization (Benefits and Talent) - Simulation"),
  h5("This interactive application simulates the impact of multiple parameters on the overall cost, assuming a simple (naive?) linear model, with the following variables:"),
  h6(" 1.    Number of Employees"),
  h6(" 2.    Benefits Saturation ($): there is the (simplistic) assumption of linear dependency between the attrition rate and the benefits provided by the company. As the benefits increase, attrition rate drops to 0% attrition at the point of Benefits Saturation. Any increase in benefits above the Benefits Saturation point will not have any impact on the attrition rates."),
  h6(" 3.    Benefits ($): benefits provided by the company"),
  h6(" 4.    Max Attrition (%): maximal attrition rates at lowest benefits (100$)"),
  h6(" 5.    Training Period (months): number of months required to train a new EE"),
  h6(" 6.    Salary ($)"),
  h6("So increasing benefits will result with increased benefits cost, but may reduces attrition  and associated cost related to hiring and training of new staff."),
  h6("Ideas? Feedback? Talk to me. Thanks, Ofir"),
   
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    
    h5("Parameters"),
    
    sliderInput("numberee",
                "Number of Enployees:",
                min = 100,
                max = 1000,
                value = 200,
                step = 100),
    
    sliderInput("bensaturation",
                "Benefits Saturation (zero attrition) ($):",
                min = 200,
                max = 500,
                value = 300,
                step = 100),
    
    sliderInput("benefits",
                "Benefits ($):",
                min = 100,
                max = 500,
                value = 300,
                step = 100),
    
    sliderInput("maxattrition",
                "Maximum Attrition (at minimum Benefits) (%):",
                min = 10,
                max = 40,
                value = 20,
                step = 10),
    
    sliderInput("trainingperiod",
                "training period (months):",
                min = 1,
                max = 6,
                value = 3,
                step = 1),
    
    sliderInput("salary",
                "Salary ($):",
                min = 500,
                max = 5000,
                value = 500,
                step = 500)
   
  ),
    
  # Show a plot of the generated distribution
  mainPanel(
    h5("Attrition rate:"),
    textOutput("attritionrate"),
    plotOutput("distPlot")

  ),
  
  position = c("left"),
  fluid = TRUE
  

))

