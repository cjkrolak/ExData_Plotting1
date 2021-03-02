# Week1 Exploratory data analysis project
# plot3 file

# load data prep functions
source("data_prep.R")

# load common plotting functions
source("plot_common.R")

plot3 <- function(df, pageFormat=TRUE, cex=0.75, fileName=NULL) {
    # Time series plot of sub_metering_1,2,3
    #
    # inputs:
    #   df(data frame)
    #   cex(numeric): Legend font size scale
    #   fileName(str): filename, if NULL no file will be saved.
    # returns:
    #   None
    
    # page setup
    if (pageFormat) {
        par(mfrow=c(1,1))
        par("mar"=c(4,4,4,4))
    }
    
    #print("plotting chart ...")
    # empty plot
    plot(df$DateTime, df$Sub_metering_1,
         type="n", xlab="", # axes="yaxt",
         ylab="Energy sub metering")
    
    # data series
    lines(df$DateTime, df$Sub_metering_1, col = c("black"), type = 'l')
    lines(df$DateTime, df$Sub_metering_2, col = c("red"), type = 'l')
    lines(df$DateTime, df$Sub_metering_3, col = c("blue"), type = 'l')
    
    # weekday axis
    #axis(1, at=weekdays(df$DateTime))

    # add legend
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col=c("black", "red", "blue"), lty=c(1,1,1), cex=cex)
    
    # save plot to file
    if (!is.null(fileName)) {
        savePlot(fileName)
    }
}

plot3Complete <- function () {
    # import data and do plot 2.
    df<- loadDataSet()
    plot3(df, pageFormat=TRUE, fileName="plot3.png")
    df  # return data set to env
}