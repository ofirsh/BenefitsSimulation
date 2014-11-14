source("cutoff.R")

benefits <- seq(from = 100, to = 500, length.out = 20)
attrition <- cutoff(100,500,40,300,benefits)
currentAttrition <- cutoff(100,500,40,300,200)