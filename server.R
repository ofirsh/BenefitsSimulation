
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#
# attach(mtcars)
library(shiny)
source("cutoff.R")

benefits <- round(seq(from = 100, to = 500, length.out = 20))
trainingPeriod <- 1:6

shinyServer(function(input, output) {
   
  
  output$attritionrate <- renderText({signif(cutoff(100,500,input$maxattrition,input$bensaturation,input$benefits),2)})
    
  output$distPlot <- renderPlot({

    attrition <- cutoff(100,500,input$maxattrition,input$bensaturation,benefits)
    currentAttrition <- cutoff(100,500,input$maxattrition,input$bensaturation,input$benefits)
    
    nTrainingMonths <- input$trainingperiod
    
      
    par(mfrow = c(2,2))
    # layout(mat = c(1:3), widths = 2, heights = 2)
    # par(mfrow = c(3,1))
    
    plot(attrition ~ benefits, lwd = 3, col = "cyan", main = "Attrition vs. Benefits", xlab = "benefits($)", ylab = "attrition(%)")
    lines(benefits,attrition, col = "blue")
    
    benefitsCost <- input$numberee * input$benefits
    # assuming 3 months training and given attrition rate based on benefits
    attritionCost <- input$salary * nTrainingMonths * input$numberee * (currentAttrition / 100)
    overallCost <- benefitsCost + attritionCost
    
#     cat("benefit cost")
#     cat(benefitsCost)
#     cat("attrition cost")
#     cat(attritionCost)
    
    cost <- matrix(c(attritionCost,benefitsCost), ncol = 1)
    rownames(cost) <- c('Attrition', 'Benefits')
    colnames(cost) <- c("Cost")
    cost.table <- as.table(cost)
    barplot(cost.table, main="Cost breakdown",xlab="", ylab = "$", col=c("darkblue","red"),legend = rownames(cost.table))
    
    # vector data on benefits cost and attrition cost across 
    benefitsCostV <- input$numberee * benefits
    attritionCostV <- input$salary * nTrainingMonths * input$numberee * (attrition / 100)
    totalCostV <- benefitsCostV + attritionCostV

    plot(benefitsCostV ~ benefits,col = "red", main = "Cost vs. Benefits", xlab = "benefits($)", ylab = "cost($)")
    lines(benefits,benefitsCostV, col = "red", lwd = 3)
    points(benefits,attritionCostV, col = "blue")
    lines(benefits,attritionCostV, col = "blue",lwd = 3)
    points(benefits,totalCostV, col = "purple")
    lines(benefits,totalCostV, col = "purple",lwd = 3)

    minBenefitsIndex <- which.min(totalCostV)
    minBenefits <- benefits[minBenefitsIndex]
    minBenefitsCost <- totalCostV[minBenefitsIndex]

    abline(v=minBenefits,col = "cyan", lty = "dashed", lwd = 1)
    symbols(minBenefits,minBenefitsCost,circles=20, fg = "darkorange", inches = FALSE, add=TRUE, lwd = 2)
    # arrows(x1=minBenefits,y1=minBenefitsCost,angle=45, code=2, col = "darkorange")


#     cat("\n minBenefitsIndex \n",minBenefitsIndex)
#     cat("\n minBenefits \n",minBenefits)
#     cat("\n minBenefitsCost \n",minBenefitsCost)




    # symbols(minBenefits,minBenefitsCost,50, add=TRUE)
    

#     cat("\nbenefits\n",benefits)
#     cat("\nlength(benefits)\n",length(benefits))
#     cat("\nbenefitsCostV\n",benefitsCostV)
#     cat("\nattritionCostV\n",attritionCostV)
#     cat("\ntotalCostV\n",totalCostV)
#     cat("\ncostV\n",costV)
#     cat("\ncostV.table\n",costV.table)

# barplot(costV.table, main="Cost breakdown",xlab="", ylab = "$", col=c("darkblue","red"))


#     costV <- matrix(c(attritionCostV,benefitsCostV), ncol = length(benefits))
#     colnames(costV) <- c(benefits)
#     costV.table  <- as.table(costV)

    

    
#     counts <- table(mtcars$vs, mtcars$gear)
#     > counts
#     
#     3  4  5
#     0 12  2  4
#     1  3 10  1
    
#         plot(attrition ~ benefits, lwd = 3, col = "cyan")
#         lines(benefits,attrition, col = "black")
#     
#     plot(attrition ~ benefits, lwd = 3, col = "cyan")
#     lines(benefits,attrition, col = "pink")
    
#     plot(attrition ~ benefits, lwd = 3, col = "cyan")
#     lines(benefits,attrition, col = "yellow")
    
#     plot(wt,mpg, main="Scatterplot of wt vs. mpg")
#     plot(wt,disp, main="Scatterplot of wt vs disp")
#     hist(wt, main="Histogram of wt")
#     boxplot(wt, main="Boxplot of wt")
        
    
    
#     plot(attrition ~ benefits, lwd = 3, col = "cyan")
#     lines(benefits,attrition, col = "blue")
#     
#     plot(attrition ~ benefits, lwd = 3, col = "cyan")
#     lines(benefits,attrition, col = "black")
    
    
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2] 
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
#     
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
#     
  })
  
})
    