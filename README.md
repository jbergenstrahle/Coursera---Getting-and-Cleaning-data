Coursera---Getting-and-Cleaning-data
====================================

Tidy Data project

####Repository documents
The repository includes the following documents:
- README.md
- CodeBook.md
- run_analysis.R
- tidy_data.txt

####User instructions
1.Download the data zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzip to desired location. Use the default name of the folder.

2.Set the working directory in R to the location of the unzipped data folder.

3.To run the R script, the "dplyr"-package is needed, if not already installed, type install.package("dplyr") in your R console before running the script.

4.Run run_analysis.R 

5.The tidy_data.txt file is created in the unzipped data folder.

####The CodeBook
The CodeBook.md includes a description of the variables in the tidy_data.txt output file, as well as the transformations performed on the original data.

####The tidy data
The output file of the run_analysis.R script is provided, which consist of a tidy data set obtained via transformation of the original data set. See CodeBook.md for details of the data set. 
