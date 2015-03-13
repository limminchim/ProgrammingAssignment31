README.MD for ProgrammingAssignment31
======================================
Description: Repository for Programming Assignment 1 under "Getting and Cleaning Data" - Coursera

How to run script:

1. Download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Unzip into working directory
   Ensure that the original folder and file structure is retained in the root of the working directory
3. Copy script file "run_analysis.R" into working directory
4. Start RStudio
5. Set the working directory to be the same as that above
6. Open "run_analysis.R" file in R Studio and run the following scripts
   > install.packages("sqldf")  
   > source('<your_working_directory>/run_analysis.R')  
   > getDataAndPrepareTidyData()  

7. You should expect to see an output file "melt_merge_dataset.txt" in the working directory




