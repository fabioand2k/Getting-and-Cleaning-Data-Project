## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## package to manipulate dataframe
library(dplyr)

## set default directory of dataset
setwd("C:/rscripts/coursera_getting_data/UCI HAR Dataset")

data_train_y <- read.table("train/y_train.txt", quote="\"")
data_test_y <- read.table("test/y_test.txt", quote="\"")

features <- read.table("features.txt", quote="\"")
activity_labels <- read.table("activity_labels.txt", quote="\"")

subject_train <- read.table("train/subject_train.txt", quote="\"")
subject_test <- read.table("test/subject_test.txt", quote="\"")

data_train_x <- read.table("train/X_train.txt", quote="\"")
data_test_x <- read.table("test/X_test.txt", quote="\"")

colnames(activity_labels)<- c("V1","Activity")

subject<- rename(subject_train, subject=V1)
train_0<- cbind(data_train_y,subject)
train_1<- merge(train_0,activity_labels, by=("V1"))

colnames(data_train_x)<- features[,2]

train_2<- cbind(train_1,data_train_x)
train_3<- train_2[,-1]
train_4<- select(train_3,contains("subject"), contains("Activity"), contains("mean"), contains("std"))

colnames(activity_labels)<- c("V1","Activity")
subjecta<- rename(subject_test, subject=V1)
test_0<- cbind(data_test_y,subjecta)
test_1<- merge(test_0,activity_labels, by=("V1"))

colnames(data_test_x)<- features[,2]

test_2<- cbind(test_1,data_test_x)

test_3<- test_2[,-1]

test_4<- select(test_3,contains("subject"), contains("Activity"), contains("mean"), contains("std"))

analysis<- rbind(train_4,test_4)

run_analysis<- (analysis%>%
                  group_by(subject,Activity) %>%
                  summarise_each(funs( mean)))

write.table(run_analysis,"./tidy_cleaning.txt",sep=" ",row.name=FALSE) 
               
               
               

