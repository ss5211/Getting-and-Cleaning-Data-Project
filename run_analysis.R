# Download files and unzip
setwd("E:/Data_Science/coursera")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "auto")
unzip("./data/Dataset.zip", )

# read in training and testing data
setwd("E:/Data_Science/coursera/data/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
setwd("E:/Data_Science/coursera/data/UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt")
y_test <- read.table("y_test.txt")
X_test <- read.table("X_test.txt")

# merge data column combine subject, X and y for training set and test set
# then merge combined training set and test set by rbind() 
# corresponding to (1)
trainset <- data.frame(cbind(subject_train, X_train, y_train))
testset <- data.frame(cbind(subject_test, X_test, y_test))
Data <- data.frame(rbind(trainset, testset))
setwd("E:/Data_Science/coursera/data/UCI HAR Dataset")
features <- read.table("features.txt")
names(Data) <- c("subject_number", as.character(features[,2]), "activity_label")

# by grepping colnames with "mean" and "std" to extract the data we want 
# and assign descriptive names to each variable
# corresponding (2) & (4)
Data_mean <- Data[,grep("mean", colnames(Data))]
Data_std <- Data[,grep("std", colnames(Data))]
Data <- data.frame(cbind(Data[,1],Data_mean, Data_std, Data[,563]))
names(Data) <- c("subject_number", colnames(Data_mean), colnames(Data_std), "activity_label")

# Using descriptive activity names to name the activities in the data set
# corresponding (3)
# reading the descriptive activity names
setwd("E:/Data_Science/coursera/data/UCI HAR Dataset")
activity_label <- read.table("activity_labels.txt")
Data[,81] <- factor(Data[,81], activity_label[,1], activity_label[,2])
str(Data[,81])

# calculate mean values for each variable in groups grouped by sbuject_number and activity_label
# meets the requirement of (5)
library(reshape)
Molten <- melt(Data, id.vars = c("subject_number", "activity_label"))
Data2 <- cast(subject_number + activity_label ~ variable, data = Molten, fun = mean)
head(Data2)
write.table(Data2, file = "E:/Data_Science/coursera/data/UCI HAR Dataset/tidydata.txt",row.names=FALSE)
