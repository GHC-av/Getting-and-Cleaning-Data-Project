#Source Data

A full description of the data used in this project can be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
The experiments have been video-recorded to label the data manually.
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#Attribute Information

For each record in the dataset it is provided:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.

#Project sections

##Section 1: Merges the training and the test sets to create one data set.
*xtest, xtrain contain the Training and the Test set
*ytest, ytrain containg the Training and the Test labels
*s_test, s_train contain the Training and the Test subjects
*data_feat concatenates by rows xtrain xtest
*data_act concatenates by rows ytrain ytest
*data_sub concatenates by rows s_train s_test
*feat_names contains the names of the features (column names for the data_feat dataset)
*sub_act merge data_act and data_sub
*df merge sub_act and data_feat. It's the dataframe used for the further analysis

##Section 2:Extracts only the measurements on the mean and standard deviation for each measurement.
ms_sub is a vector containing the index of the feature names about the measurment on mean and std. 
*sub_featnames subset feat_names according to ms_sub
*sel_var is the set of variable used to subset df dataframe
*df_sub is a subset of the dataframe df based on variables in sel_var 

##Section 3: Uses descriptive activity names to name the activities in the data set
*act_names contains the descriptive activity names. it is a data frame used to factorize the column "activity" of the df_sub data frame

##Section 4: Appropriately labels the data set with descriptive variable names.
*Use gsub function for pattern replacement to clean up the data labels.

##Section 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
*Package dplyr has been used to aggregate data in df_sub according to activity and subject
*df_sub2 data set with the average of each veriable for each activity and subject
*tidydata.txt is the output of the previous analysis
