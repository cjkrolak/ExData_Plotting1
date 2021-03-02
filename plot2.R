#  code to generate plot 2, time series plot of global active power.

# load data prep functions
source("data_prep.R")

# load common plotting functions
source("plot_common.R")

plot2 <- function(df, pageFormat=TRUE, fileName=NULL) {
    # Time series plot of Active Power.
    #
    # inputs:
    #   df(data frame)
    #   pageFormat(bool):  if TRUE will format page for single plot.
    #   fileName(str):  filename for plot
    # returns:
    #   None
    
    singleTimeSeriesPlot(df$DateTime, df$Global_active_power,
                         pageFormat=pageFormat,
                         yLabel="Global Active Power (killowatts)",
                         xLabel="", fileName=fileName)
}

plot2Complete <- function () {
    # import data and do plot 2.
    df<- loadDataSet()
    plot2(df, pageFormat=TRUE, fileName="plot2.png")
    df  # return data set to env
}