# Week1 Exploratory data analysis project
# plot1 file

# load data prep functions
source("data_prep.R")

# load common plotting functions
source("plot_common.R")

plot1 <- function(df) {
    # Histograms Global Active Power.
    #
    # inputs:
    #   df(data frame)
    # returns:
    #   None
    
    # page setup
    par(mfrow=c(1,1))
    par("mar"=c(4,4,4,4))

    print("plotting histogram ...")
    hist(df$Global_active_power, xlab="Global Active Power (killowatts)",
         ylab="Frequency", col=c("red"), main="Global Active Power")

    # save to file
    outFile <- "plot1.png"
    print(paste("saving histogram to:", outFile, "..."))
    dev.copy(device=png, file=outFile)
    dev.off()
}

plot1Complete <- function () {
    # import data and do plot 1.
    df<- loadDataSet()
    plot1(df)
    df  # return data set to env
}
