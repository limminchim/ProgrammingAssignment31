README.MD for ProgrammingAssignment31
======================================
Description: Repository for Programming Assignment 1 under "Getting and Cleaning Data" - Coursera

How to run script:

1. Download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Unzip into working directory
   Ensure that the following folder and file structure is in the working directory
  
  activity_labels.txt     
  features.txt            
  activity_labels.txt
  features.txt
  features_info.txt       
  README.txt
  run_analysis.R
  + test 
    subject_test.txt
    X_test.txt
    y_test.txt
    + Inertial Signals
      body_acc_x_test.txt
      body_acc_y_test.txt
      body_acc_z_test.txt
      body_gyro_x_test.txt
      body_gyro_y_test.txt
      body_gyro_z_test.txt
      total_acc_x_test.txt
      total_acc_y_test.txt
      total_acc_z_test.txt      
  + train  
    subject_train.txt
    X_train.txt
    y_train.txt
    + Inertial Signals
      body_acc_x_train.txt
      body_acc_y_train.txt
      body_acc_z_train.txt
      body_gyro_x_train.txt
      body_gyro_y_train.txt
      body_gyro_z_train.txt
      total_acc_x_train.txt
      total_acc_y_train.txt
      total_acc_z_train.txt

3. Copy script file "run_analysis.R" into working directory
4. Start RStudio
5. Set the working directory to be the same as that above
6. Open "run_analysis.R" file in R Studio and run the following scripts
   > install.packages("sqldf")
   > source('<your_working_directory>/run_analysis.R')
   > getDataAndPrepareTidyData()
7. You should expect to see an output file "melt_merge_dataset.txt" in the working directory



