# functions used to load and parse data.

# URL for source data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# download folder for zip file
downloadFolder <- ".\\"  # working directory
tempFile <- paste0(downloadFolder, "tempfile.zip")

# data file configuration
targetFile = "household_power_consumption.txt"
header <- TRUE
delim <- ";"  # semi-colon delimited file
colClasses=c("Date"="character",
             "Time"="character",
             #"Global_active_power"="numeric"
             #"Global_reactive_power"="numeric"
             "Voltage"="numeric"
             #"Global_intensity"="numeric"
             #"sub_metering_1"="numeric"
             #"sub_metering_2"="numeric"
             #"sub_metering_3"="numeric"
)

# data folder within zip file
# if zip structure changes this may need to be updated.
dataFolder <- paste0(downloadFolder, "")

downLoadFile <- function (url) {
    # Download zip file from URL to local drive.
    #
    # inputs:
    #   url(str): URL address
    # returns:
    #   tempFile(str): name of downloaded zip file
    tempFile <- paste0(downloadFolder, "tempfile.zip")
    print(paste0("downloading file: ", url, " to: ", tempFile))
    f = download.file(url, destfile=tempFile, mode='wb')
    print("file downloaded")
    tempFile  # return temp file name
}

extractZipFile <- function(tempFile=tempFile) {
    # Extract data file from zip file.
    #
    # inputs:
    #   tempFile(str) = zip filename (full path)
    # returns:
    #   None
    #
    print(paste0("unzipping file: ", tempFile, " to: ", downloadFolder))
    library(utils)
    suppressWarnings(unzip(zipfile = tempFile, overwrite=FALSE))
    # if data files already exist in folder then line above will generate 28
    # warnings. I have overwrite set to FALSE in case a different data set is
    # being used for grading.
    
    print("unzipping complete")
}

loadDFFromFile <- function(targetFolder, targetFile, header=TRUE, delim="",
                           colClasses=NA) {
    # Read extracted file and load into data frame.
    #
    # inputs:
    #   targetFolder(str):  path to data file
    #   targetFile(str):    name of data file
    #   header(bool):       TRUE if data file has a header
    #   delim(str):         data file delimiter
    #   colClasses(vector)  vector of column classes
    # returns:
    #   dat
    print("loading data from file...")
    fullFilePath <- paste0(targetFolder, targetFile)
    #dat <- read.delim(fullFilePath, header=header, sep=delim,
    #                  colClasses=colClasses,
    #                  stringsAsFactors=FALSE, na.strings='NULL')
    dat <- read.csv(fullFilePath, header=header, sep=delim,
                    colClasses=colClasses)
}

convertDataColumn <- function(df, dataColumn, dataFormat,
                              suppressWarnings=TRUE) {
    # Clean numeric data columns that did not parse to numeric during load.
    #
    # inputs:
    #   df(data frame):          target data frame
    #   dataColumn(vector):      vector of target column numbers
    #   dataFormat(func):        conversion function to apply
    #   suppressWarnings(bool):  TRUE to suppress coercion warning msgs
    #   
    # returns:
    #   df(data frame)
    if (suppressWarnings==TRUE) {
        df[, dataColumn] <- suppressWarnings(sapply(df[, dataColumn],
                                                    dataFormat))
    }
    else {
        df[, dataColumn] <- sapply(df[, dataColumn], dataFormat)
    }
    df  # return data frame
}

loadDataSet <- function() {
    # download data and load into data frame
    tf <- downLoadFile(url)
    extractZipFile(tf)
    df <- loadDFFromFile(downloadFolder, targetFile, header,
                         delim)
    
    # convert data columns to date and number
    print("converting data columns to proper types...")
    df <- convertDataColumn(df, c(3:9), as.numeric)
    df$Date <- as.Date(df$Date, "%d/%m/%Y")
    library(chron)
    df$Time <- chron(times=df$Time)
    
    # create combined date/time column
    df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S")
    
    # subset rows based on dates 2007-02-01 and 2007-02-02
    df <- df[(df$Date=="2007-02-01" | df$Date =="2007-02-02"),]
    df  # return data frame
}