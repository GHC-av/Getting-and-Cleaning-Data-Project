setwd("C:/Users/andrea/Desktop/Data Science/WorkDir/Project G&C data")
filename <- "dataset.zip"

##Download file from the given URL and unzip (if necessary)
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method="libcurl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

##Read the files in the train and test folders (Activities, Subjects and Features data)
xtest<-read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
ytest<-read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
ytrain<-read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
s_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
s_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

##Concatenate training and test datatables by rows
data_feat<-rbind(xtrain, xtest)
data_act<-rbind(ytrain, ytest)
data_subjects<-rbind(s_train,s_test)

##set names to variables
names(data_act)<-"activity"
names(data_subjects)<-"subject"
feat_names<-read.table("./UCI HAR Dataset/features.txt", header = FALSE)
names(data_feat)<-feat_names$V2

##Merge columns to create a data frame with all the necessary data [df]
sub_act<-cbind(data_subjects,data_act)
df<-cbind(data_feat,sub_act)

##Subset feature names by measurment on the mean and the standard deviation
ms_sub<-grep("mean\\(\\)|std\\(\\)", feat_names$V2)
sub_featnames<-feat_names[ms_sub,2]

##Subset the data frame [df] by the selected feature names
sel_var<-c(as.character(sub_featnames), "subject", "activity" )
df_sub<-subset(df, select = sel_var)

##Read the descriptive activity names
act_names<-read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

##Factorize the variable activity in the subsetted dataframe using activity names
df_sub$activity<-factor(df_sub$activity, levels = act_names[,1], labels = act_names[,2])

##Appropriately labels the data set with descriptive variable names
names(df_sub)<-gsub("^t", "time", names(df_sub))
names(df_sub)<-gsub("^f", "frequency", names(df_sub))
names(df_sub)<-gsub("Acc", "Accelerometer", names(df_sub))
names(df_sub)<-gsub("Gyro", "Gyroscope", names(df_sub))
names(df_sub)<-gsub("Mag", "Magnitude", names(df_sub))
names(df_sub)<-gsub("BodyBody", "Body", names(df_sub))

##From the data set df_sub a second data frame is created with the average of each variable for each activity and each subject.
library(dplyr)
df_sub2<-aggregate(. ~subject + activity, df_sub, mean)
write.table(df_sub2, file = "UCI HAR Dataset/tidydata.txt",row.names = FALSE, quote = FALSE)

