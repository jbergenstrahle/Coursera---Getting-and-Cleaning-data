---
title: "CodeBook - Getting and cleaning data project"
output: html_document
---

####Original data source

The data used is a collection of human activity recordings from Samsung Galaxy S accelerometers during various activities.
The data set can be obtained from the following website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data was downloaded from the following url:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

####Transformations of the original data

Check the readme.md file for detailed instructions to run the provided R-script that transforms the data into a tidy data set.
The run_analysis.R script does the following to the downloaded data:
1. Adds the subject data (i.e. subject number id) to the train and test data sets respectively.
2. Adds the activity data (i.e. activity id) to the train and test data sets respectively.
3. Merges the two created data frames into one. This creates a 10299x563 sized data frame.
4. The feature variables of interest (i.e. mean and standard deviation measurements) are selected from the merged data frame into a new data frame.
5. The numeric activity ID are substituted to descriptive names.
6. The columns (3:68) containing the measured mean and std data are given descriptive variable headers according to the names provided in features.txt from the original data set. 
7. The "dplyr" package is used to group the data by activity and subject id.
8. According to the grouping in step 7, the mean of each measured variable are calculated.
9. A .txt file with the tidy data set is created in the working directory. 

####Tidy data set variable description
The following variables are included in the tidy_data.txt:

* Activity
    - Walking, Walking upstairs, Walking downstairs, Sitting, Standing, Laying
* Subject
    - Subject 1-30
    
The measured variables in columns 3:68 consists of gyroscope 3-axial raw signals. "-XYZ" refers to the signals in the X, Y and Z directions.
For each of the XYZ-variables, the mean() and std() are indicated (e.g. tBodyAcc-mean()-X, are the variable for the mean value for the body acceleration in the X-direction). The values that are presented in the tidy_data.txt are **mean values** of the described measurements (i.e. mean values of the mean and std).
The mean of the following variables are included: (for each variable the mean and std are included in the tidy_data.txt)

Time-domain signals:

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag

Fast Fourier Transform (FFT) produced values:

* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyBodyAccJerkMag
* fBodyBodyGyroMag
* fBodyBodyGyroJerkMag

For a more detailed description of the feature variables, please see features_info.txt provided in the downloaded original data set.
