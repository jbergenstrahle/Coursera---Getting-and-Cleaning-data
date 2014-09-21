#---1. Merge the training and the test sets to create one data set.

train = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header=FALSE)
#dim(train) -> 7352x561
trainSubject = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
trainLabels = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header=FALSE)
test = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header=FALSE)
#dim(test) -> 2947x561
testSubject = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
testLabels = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header=FALSE)

#Add the subject ID and label ID to train data frame and the test data frame respectively:
mergeTrain = cbind(trainSubject, train)
mergeTrain = cbind(trainLabels, mergeTrain)
#dim(mergeTrain) -> 7352x563
names(mergeTrain)[1] = "Activity"
names(mergeTrain)[2] = "Subject"

mergeTest = cbind(testSubject, test)
mergeTest = cbind(testLabels, mergeTest)
#dim(mergeTest) -> 2947x562
names(mergeTest)[1] = "Activity"
names(mergeTest)[2] = "Subject"

#Now each subject have a number of rows
#Lets merge the train and test datasets togheter, putting the test subjects below the train subjects:
mergeAll = rbind(mergeTrain, mergeTest)
#dim(mergeAll) -> 10299x563

#---2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features = read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", header=FALSE)
#dim(features) -> 561x2 -> The features variables are located according to 1 feature per row.
#According to readme file: mean()= Mean value, std()= Standard deviation in features.txt
#Lets extract only these values, they are located at row: 1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543  

select = c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)
#Since We have added 2 columns to our datasets above (Activiy Label and Sucject nr), the columns we want to select are select+2:
select = select+2
subdata = subset(mergeAll, select=c(1:2, select))
#dim(subdata) -> 10299x68

#---3. Uses descriptive activity names to name the activities in the data set

subdata[,1]=gsub("1", "Walking", subdata[,1])
subdata[,1]=gsub("2", "Walking upstairs", subdata[,1])
subdata[,1]=gsub("3", "Walking downstairs", subdata[,1])
subdata[,1]=gsub("4", "Sitting", subdata[,1])
subdata[,1]=gsub("5", "Standing", subdata[,1])
subdata[,1]=gsub("6", "Laying", subdata[,1])

#---4. Appropriately labels the data set with descriptive variable names.
#Lets change the column names of column 3:68 to the variable names according to the features.txt file:
select = select-2
colNames = as.character(features[select,2])
names(subdata)[3:68] = colNames
#We now have a data set with the following features:
#Headers: Column1=Actitivy label, Column2=Subject nr, Column3-68=Variable name
#Note: Each subject has a number of measurments, but the amount of measurments differs between subjects

#---5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr) #Loading the dplyr package
tidyData = tbl_df(subdata) #Creating a data frame tbl to be used by the dplyr functions
by_ActSub = group_by(tidyData, Activity, Subject) #Grouping the data by Activity and Subject, this means that compuations performed on the data frame will be done per group, i.e. Mean values for all measured variables are calculated for each subject and each activity. 

sumDF = summarise_each(by_ActSub, funs(mean)) #summarise_each execute the desired calculation (mean) for each column (not grouped)

#---6. Creating a .txt file with the final data set

write.table(sumDF, file="./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/tidy_data.txt", row.names=FALSE)


