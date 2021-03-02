# common plotting functions.

histogramData <- function(df) {
    # Histograms of all numeric data.
    #
    # inputs:
    #   df(data frame)
    # returns:
    #   None
    
    # histogram all numeric data
    par(mfrow=c(4,2))
    par("mar"=c(2,2,2,2))
    print("plotting histograms for all numeric columns...")
    hist(df$Global_active_power, xlab="killowatts")
    hist(df$Global_reactive_power, xlab="killowatts")
    hist(df$Voltage, xlab="volts")
    hist(df$Global_intensity, xlab="ampere")
    hist(df$Sub_metering_1, xlab="watt-hour of active energy")
    hist(df$Sub_metering_2, xlab="watt-hour of active energy")
    hist(df$Sub_metering_3, xlab="watt-hour of active energy")
    #lapply(df[3:9], FUN=hist)  # lapply does not include titles
    outFile <- "histograms.pdf"
    print(paste("saving histograms to:", outFile, "..."))
    dev.copy(device=pdf, file=outFile)
    dev.off()
}

correlationMatrix <- function(df) {
    # Correlation matrix of all numeric data.
    #
    # inputs:
    #   df(data frame)
    # returns:
    #   None
    library(car)
    par(mfrow=c(4,2))
    par("mar"=c(3,3,3,3))
    print("plotting correlation matrix of all numeric columns...")
    scatterplotMatrix(~ df$Global_active_power + df$Global_reactive_power, data = df)
    outFile <- "correlationMatrix.pdf"
    print(paste("saving correlation matrix to:", outFile, "..."))
    dev.copy(device=pdf, file=outFile)
    dev.off()
}

savePlot <- function(fileName) {
    # Export to file in working directory.
    # inputs:
    #   fileName(str):  filename with extension
    # outputs:
    #   None
    outFile <- fileName
    print(paste("saving plot to:", outFile, "..."))
    dev.copy(device=png, file=outFile)
    dev.off()
}

singleTimeSeriesPlot <- function(x, y, pageFormat=TRUE, yLabel="",
                                 xLabel="", fileName=NULL) {
    # Single time-series plot
    #
    # inputs:
    #   df(data frame)
    #   x (vector): time series
    #   y (vector): response data column
    #   pageFormat(bool):  if TRUE will format page for single plot.
    #   yLabel(str): label for y-axis
    #   xLabel(str): label for x-axis
    #   fileName(str):  filename for plot
    # returns:
    #   None
    
    # histogram all numeric data
    if (pageFormat) {
        par(mfrow=c(1,1))
        par("mar"=c(4,4,4,4))
    }
    #print("plotting chart ...")
    plot(x, y, type="l", xlab=xLabel,
         ylab=yLabel)
    
    # save plot to file
    if (!is.null(fileName)) {
        savePlot(fileName)
    }
}
