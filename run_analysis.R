#import data.table
library(data.table)


##### FEATURES -- COLUMN VARIABLES ####
featuresLink = file.path(getwd(), "UCI HAR Dataset/features.txt")
features <- data.table(read.table(featuresLink))

#get some inforamtion and statistics about the features data.
class(features)
head(features, 5)
names(features)
dim(features)
str(features)

#transpose the features data and extract the variable names 
tfeatures <- transpose(features)
tfeatures = tfeatures[2,]


##### TRAIN DATA #############

#read in the X_train data
X_train_file = file.path(getwd(), "UCI HAR Dataset/train/X_train.txt")
x_train <- data.table(read.table(X_train_file, col.names=tfeatures))

#get some inforamtion and statistics about the X_train data.
class(x_train)
#View(head(x_train, 2))
head(x_train, 2)
length(names(x_train))
dim(x_train)
str(x_train)
#View(x_train)
x_train


#read in the Y_train data
y_train_file = file.path(getwd(), "UCI HAR Dataset/train/Y_train.txt")
y_train <- data.table(read.table(y_train_file))

#get some inforamtion and statistics about the Y_train data.
#View(head(y_train,2))
head(y_train,2)
names(y_train)
dim(y_train)
str(y_train)
summary(y_train)



#read in the subject_train data
subject_train_Link = file.path(getwd(), "UCI HAR Dataset/train/subject_train.txt")
subject_train <- data.table(read.table(subject_train_Link))


#get some inforamtion and statistics about the subject_train data.
class(subject_train)
#View(head(subject_train, 5))
head(subject_train, 5)
names(subject_train)
dim(subject_train)
str(subject_train)

#match X_train subjects unto X_train data
x_train_subj_data <- cbind(subject= subject_train, activity = y_train, x_train)
#View(head(x_train_subj_data, 60))
head(x_train_subj_data, 60)
names(x_train_subj_data)
dim(x_train_subj_data)


#####  MAPPING ACTIVITY NAMES to TRAIN data  #######
#3 Uses descriptive activity names to name the activities in the data set

#read in the "activity labels"
activityLink = file.path(getwd(), "UCI HAR Dataset/activity_labels.txt")
activity_labels <- data.table(read.table(activityLink))

#get some information and statistics about the activity_labels
class(activity_labels)
head(activity_labels, 5)
names(activity_labels)
dim(activity_labels)
str(activity_labels)

#extract the activity labels
activity_labels <- transpose(activity_labels)
activity.labels <- activity_labels[2,]

#loop through TRAIN data and replace activity indexes with activity names
for(i in 1:6){
    x_train_subj_data$activity.V1 <- gsub(i, activity.labels[[i]], x_train_subj_data$activity.V1 )
}
#View(head(x_train_subj_data, 60))
head(x_train_subj_data, 60)





#### TEST DATA ######
#read in the X_test data and label the columns names with the feature variables
X_test_file = file.path(getwd(), "UCI HAR Dataset/test/X_test.txt")
x_test <- data.table(read.table(X_test_file, col.names=tfeatures))

#get some information and statistics about the X_test data
class(x_test)
#View(head(x_test, 4))
head(x_test, 4)
names(x_test)
dim(x_test)
str(x_test)
summary(x_test)

#read in the Y_test data
y_test_file = file.path(getwd(), "UCI HAR Dataset/test/y_test.txt")
y_test <- data.table(read.table(y_test_file))

#get some information and statistics about the Y_test data
class(y_test)
head(y_test, 1)
names(y_test)
dim(y_test)
str(y_test)

#read in the "subject_test" data
subject_test_Link = file.path(getwd(), "UCI HAR Dataset/test/subject_test.txt")
subject_test <- data.table(read.table(subject_test_Link))

#get some information and statistics about the subject_test data
class(subject_test)
head(subject_test, 5)
names(subject_test)
dim(subject_test)
str(subject_test)

#match y_test_subjects , y_test_label unto X_test data using cbine
y_test_subj_data <- cbind(subject= subject_test,activity= y_test, x_test)

##get some information and statistics about the resulting dataframe
#View(head(y_test_subj_data, 60))
head(y_test_subj_data, 60)
names(y_test_subj_data)
dim(y_test_subj_data)


#match activity names to the activity labels in the test data
#loop through TRAIN data and replace activity indexes with activity names
for(i in 1:6){
    y_test_subj_data$activity.V1   <- gsub(i, activity.labels[[i]], y_test_subj_data$activity.V1 )
}

#View(head(y_test_subj_data, 60))
head(y_test_subj_data, 60)






#### 1) Merges the training and the test sets to create one data set.####
merged.data <- rbind(y_test_subj_data, x_train_subj_data)
#View(head(merged.data, 100))
head(merged.data, 100)
dim(merged.data)
#View(merged.data)
merged.data



#2. Extracts only the measurements on the mean and standard deviation for each measurement
#this will only select column names that include the words either "mean" or "std"
#column names that include "meanFreq" are excluded as these are weighted averages and not base means
library(dplyr)
data.mean_std <- merged.data %>% 
    select(matches('mean|std|subject|activity', ignore.case = TRUE)) %>%
    select(-contains("meanFreq", ignore.case = TRUE))
    #head(2)
#View(data.mean_std)
data.mean_std
ncol(data.mean_std)
names(data.mean_std)


#3 : Step 3 has already been tackled above


#4.Appropriately labels the data set with descriptive variable names.
#Remove all periods in column names
names(data.mean_std) <- gsub("\\.", "", names(data.mean_std))
names(data.mean_std)
ncol(data.mean_std)

#capitalise all mean
names(data.mean_std) <- gsub("mean", "Mean", names(data.mean_std))
names(data.mean_std)
ncol(data.mean_std)


#capitalise all std
names(data.mean_std) <- gsub("std", "Std", names(data.mean_std))
names(data.mean_std)
ncol(data.mean_std)


#replace all Acc with Accelerometer
names(data.mean_std) <- gsub("Acc", "Accelerometer", names(data.mean_std))
names(data.mean_std)
ncol(data.mean_std)



#replace all "Gyro" with Accelerometer
names(data.mean_std) <- gsub("Gyro", "Gyroscope", names(data.mean_std))
names(data.mean_std)
ncol(data.mean_std)


#replace all "subjectV1" with "subject"
names(data.mean_std) <- gsub("subjectV1", "subject", names(data.mean_std))
names(data.mean_std)
ncol(data.mean_std)

#replace all "activityV1" with "activity"
names(data.mean_std) <- gsub("activityV1", "activity", names(data.mean_std))
names(data.mean_std)
ncol(data.mean_std)



#5 From the data set in step 4, creates a second, independent tidy 
#data set with the average of each variable for each activity and each subject
tidy_data <- data.mean_std %>% 
                group_by(subject, activity ) %>%
                
                summarise_each(funs(mean))
head(tidy_data)
dim(tidy_data)
#View(tidy_data)
tidy_data
str(tidy_data)
names(tidy_data)

#creating tidy dataset with row.name=FALSE
file_path = file.path(getwd(), "tidy_data.txt")
write.table(tidy_data, file = file_path, row.name=FALSE) 


#code to read tidy data
# 
# read_data <- read.table(file_path, header = TRUE) 
# View(read_data)

