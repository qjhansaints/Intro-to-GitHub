setwd("C:/Users/Qyle Jhan Santos/Desktop/specdata")
library(dplyr)

xtest     <- read.table("UCI HAR Dataset/test/X_test.txt")      
ytest     <- read.table("UCI HAR Dataset/test/y_test.txt")         
sub_test  <- read.table("UCI HAR Dataset/test/subject_test.txt")   
xtrain    <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain    <- read.table("UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
features  <- read.table("UCI HAR Dataset/features.txt")
acts      <- read.table("UCI HAR Dataset/activity_labels.txt")

## Merges training and test sets to create one data set
x       <- rbind(xtrain, xtest)
y       <- rbind(ytrain, ytest)
subject <- rbind(sub_train, sub_test)
Data    <- cbind(subject, y, x)

## Extracts measurements on the mean and standard deviation for each measurement
extracted_data  <- grepl("(-std\\(\\)|-mean\\(\\))",features$V2, subject, y)
filtered_data    <- Data[, which(extracted_data == TRUE)]

## Uses descriptive activity names to name the activities in the dataset
activity <- as.factor(y$V1)
levels(activity) <- acts$V2
subs <- as.factor(subject$V1)
filtered_data <- cbind(subs,activity,filtered_data)

## Appropriately labels the data set with descriptive variable names
filtered_features <- (cbind(features,extracted_data)
                     [extracted_data==TRUE,])$V2
clean <- function(feature) {
  tolower(gsub("(\\(|\\)|\\-)","",feature))}
filtered_features <- sapply(filtered_features, clean)
names(filtered_data)[3:ncol(filtered_data)] <- filtered_features
write.csv(filtered_data,file="dataset1.csv")
write.table(filtered_data, "dataset1.txt", sep="\t")

## From the data set in step 4, create a second, independent tidy data set
  # with the average of each variable for each activity and each subject
Final_Data <- filtered_data %>% group_by(activity, subs) %>% summarise_all(funs(mean))