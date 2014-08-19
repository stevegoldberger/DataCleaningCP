# Stephen Goldberger
# 8/19/2014

#1. Read in the data
setwd("Coursera/DataCleaning/DataCleaningCP")
if (!file.exists("UCI.zip")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL,destfile = "UCI.zip")
        unzip("UCI.zip")
}

al <- read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)
names(al) <- c("Code","Activity")

feat <- read.table("UCI HAR Dataset/features.txt")
names(feat) <- c("Code","Variable")

subtest <-read.table("UCI HAR Dataset/test/subject_test.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
test <- rep(0,dim(ytest)[1])

subtrain <-read.table("UCI HAR Dataset/train/subject_train.txt")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
train <- rep(1,dim(ytrain)[1])

#2. Create the Factor variables/list and combine

data <- rbind(xtest,xtrain)
factOrig <- as.factor(c(test,train))
levels(factOrig) <- c("test","train")
factSub <- as.factor(c(subtest[,1],subtrain[,1]))
factAct <- as.factor(c(ytest[,1],ytrain[,1]))
levels(factAct) <- al[,2]

lsFact <- list(factOrig,factSub,factAct)

lsData <- split(data,lsFact)

# 3. Calculate the Mean and Standard Deviation

avCP <- function(x) {apply(x,2,mean,na.rm=TRUE)}
sdCP <- function(x) {apply(x,2,sd,na.rm =TRUE)}

meanData <- sapply(lsData,avCP) 
sdData <- sapply(lsData,sdCP) 

# 4. Clean up

rownames(meanData) <- feat[,2]
rownames(sdData) <- feat[,2]

cleanMData <- meanData[,!is.na(colSums(meanData))]
CD <- t(cleanMData)
MeanCD <- data.frame(CD)
names <- unlist(strsplit(rownames(MeanCD),"\\."))
index <- rep(1:3,length(rownames(MeanCD)))

MeanCD$Source <- names[index==1]
MeanCD$Subject <- names[index==2]
MeanCD$Activity <- names[index==3]

sdCD <- data.frame(t(sdData[,!is.na(colSums(sdData))]))
sdCD$Source <- names[index==1]
sdCD$Subject <- names[index==2]
sdCD$Activity <- names[index==3]
                   
write.table(MeanCD,"meanData.csv",sep=",",row.name=FALSE)
