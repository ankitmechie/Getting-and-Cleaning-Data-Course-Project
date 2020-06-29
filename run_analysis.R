#The program does the following:
#1. Downloads the data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#of which description can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#2. Merges the training and the test sets to create one data set.
#3. Extracts only the measurements on the mean and standard deviation for each measurement.
#4. Uses descriptive activity names to name the activities in the data set
#5. Appropriately labels the data set with descriptive variable names.
#6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#The stepwise description of program is as below:


#Step 1:
#Initiate the library dplyr
library(dplyr)


#Step 2:
#Download the dataset
filename <- "Dataset.zip"
fileURL <- " https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, filename, method="curl")
#Unzip the dataset
unzip(filename) 


#Step 3:
#Assign the dataframes from the dataset
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Step4:
#Merge the training and testing data set
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)


#Step 5:
#Extract only the measurements on the mean and standard deviation for each measurement.
AllData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


#Step 6:
#descriptive activity names to name the activities in the data set
AllData$code <- activities[AllData$code, 2]


#Step 7:
#label the data set with descriptive variable names
names(AllData)[2] = "activity"
names(AllData)<-gsub("Acc", "Accelerometer", names(AllData))
names(AllData)<-gsub("Gyro", "Gyroscope", names(AllData))
names(AllData)<-gsub("BodyBody", "Body", names(AllData))
names(AllData)<-gsub("Mag", "Magnitude", names(AllData))
names(AllData)<-gsub("^t", "Time", names(AllData))
names(AllData)<-gsub("^f", "Frequency", names(AllData))
names(AllData)<-gsub("tBody", "TimeBody", names(AllData))
names(AllData)<-gsub("-mean()", "Mean", names(AllData), ignore.case = TRUE)
names(AllData)<-gsub("-std()", "STD", names(AllData), ignore.case = TRUE)
names(AllData)<-gsub("-freq()", "Frequency", names(AllData), ignore.case = TRUE)
names(AllData)<-gsub("angle", "Angle", names(AllData))
names(AllData)<-gsub("gravity", "Gravity", names(AllData))


#Step 8:
#From the data set in step 7, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- AllData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)


#Step 9:
#Generate 1 liner description of the FinalData
str(FinalData)
