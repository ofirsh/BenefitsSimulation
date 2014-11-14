cutoff <- function(minx, maxx,maxy,cutoffx,x)
{
    ysat <- (x>=cutoffx)*0
    
    slope <- ( 0 - maxy ) / ( cutoffx - minx )
    
    yslope <- (maxy + (x-minx)*slope)*(x<cutoffx)
    
    return(ysat + yslope)
    
}