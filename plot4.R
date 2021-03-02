# Week1 Exploratory data analysis project
# plot4 file

# load data prep functions
source("data_prep.R")

# load common plotting functions
source("plot_common.R")

# load plot2, plot3 functions
source("plot2.R")
source("plot3.R")

plot4A <- function(df, pageFormat=TRUE, fileName=NULL) {
    # Time series plot of Voltage.
    #
    # inputs:
    #   df(data frame)
    #   pageFormat(bool):  if True, format page for single plot.
    #   fileName(str):  filename for plot
    # returns:
    #   None
    
    singleTimeSeriesPlot(df$DateTime, df$Voltage,
                         pageFormat=pageFormat,
                         yLabel="Voltage",
                         xLabel="datetime", fileName=fileName)
}

plot4B <- function(df, pageFormat=TRUE, fileName=NULL) {
    # Time series plot of Global_reactive_power
    #
    # inputs:
    #   df(data frame)
    #   pageFormat(bool):  if True, format page for single plot.
    #   fileName(str):  filename for plot
    # returns:
    #   None
    
    singleTimeSeriesPlot(df$DateTime, df$Global_reactive_power,
                         pageFormat=pageFormat,
                         yLabel="Global_reactive_power",
                         xLabel="datetime", fileName=fileName)
}

plot4 <- function(df, fileName=NULL) {
    # 4 in 1 chart
    #
    # inputs:
    #   df(data frame)
    #   fileName(str): filename, if NULL no file will be saved.
    # returns:
    #   None
    
    # page setup
    par(mfcol=c(2,2))
    par("mar"=c(4,4,4,4))
    
    #print("plotting charts ...")
    plot2(df, pageFormat=FALSE)
    plot3(df, pageFormat=FALSE, cex=0.5)
    plot4A(df, pageFormat=FALSE)
    plot4B(df, pageFormat=FALSE)
    
    # save plot to file
    if (!is.null(fileName)) {
        savePlot(fileName)
    }
}

plot4Complete <- function () {
    # import data and do plot 2.
    df<- loadDataSet()
    plot4(df, fileName="plot4.png")
    df  # return data set to env
}