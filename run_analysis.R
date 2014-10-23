## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 2. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


        # install.packages("sqldf")
        library(sqldf)
        
        ## get current working dir
        wdir <- getwd()
        
        ## Read all data files into data frames
        
        ## - 'features.txt': List of all features.
        testfilepath <- paste(wdir, "features.txt", sep="/")
        features = read.table(file = testfilepath,
                              head = FALSE,
                              col.names = c("feature_id","feature_name"))
        feature_labels <- as.character(features$feature_name)
        
        ## - 'activity_labels.txt': Links the class labels with their activity name.
        testfilepath <- paste(wdir, "activity_labels.txt", sep="/")
        activities = read.table(file = testfilepath,
                                head = FALSE,
                                col.names = c("activity_id","activity_name"))
        activity_labels <- as.character(activities$activity_name)
        

        
        ## The following files are available for the Training data.  
        ## Training set and labels
        
        ## - 'train/X_train.txt': Training set.
        testfilepath <- paste(wdir, "X_train.txt", sep="/train/")
        X_train_set = read.table(file = testfilepath,
                                 head = FALSE,
                                 col.names = feature_labels)
        
        ## - 'train/y_train.txt': Training activity labels.
        testfilepath <- paste(wdir, "Y_train.txt", sep="/train/")
        Y_train_label = read.table(file = testfilepath,
                                   head = FALSE,
                                   col.names = c("activity_id"))
 
        ## - 'train/subject_train.txt': Training subjects
        ## Each row identifies the subject who performed the activity for each window sample. 
        ## Its range is from 1 to 30. 
        testfilepath <- paste(wdir, "subject_train.txt", sep="/train/")
        train_subjects = read.table(file = testfilepath,
                                    head = FALSE,
                                    col.names = c("subject_id"))
        
        ####################################################
        
        ## subset features with "mean()" and "std()"
        ## Extracts only the measurements on the mean and standard deviation for each measurement.
        extracted_features <- sqldf("select * from features where feature_name like '%std()%' or feature_name like '%mean()%'")
        extracted_feature_ids <- as.numeric(extracted_features$feature_id)
        ## extracted_X_train_set <- X_train_set[extracted_feature_ids]
        
        ## replace Y_train_label with activity names
        ## Uses descriptive activity names to name the activities in the data set
        attach(Y_train_label)
        Y_train_label$activity_name <-ifelse(activity_id == 1,activity_labels[1],
                                             ifelse(activity_id == 2,activity_labels[1],
                                                    ifelse(activity_id == 3,activity_labels[3],
                                                           ifelse(activity_id == 4,activity_labels[4],
                                                                  ifelse(activity_id == 5,activity_labels[5],
                                                                         ifelse(activity_id == 6,activity_labels[6],"NA"
                                                                         ))))))
        detach(Y_train_label) 
        
        
        ## Merge data horizontally using cbind
        train_dataset <- cbind(train_subjects, Y_train_label[,"activity_name"], X_train_set[extracted_feature_ids])
        colnames(train_dataset)[2] <- "activity_name"
        
        ## The following files are available for the Test data.  
        ## Test set and labels
        
        ## - 'test/X_test.txt': Test set.
        testfilepath <- paste(wdir, "X_test.txt", sep="/test/")
        X_test_set = read.table(file = testfilepath,
                                head = FALSE,
                                col.names = feature_labels)
        
        ## - 'test/y_test.txt': Test labels.
        testfilepath <- paste(wdir, "Y_test.txt", sep="/test/")
        Y_test_label = read.table(file = testfilepath,
                                  head = FALSE,
                                  col.names = c("activity_id"))
 
        ## - 'test/subject_test.txt': Test Subjects
        ## Each row identifies the subject who performed the activity for each window sample. 
        ## Its range is from 1 to 30. 
        testfilepath <- paste(wdir, "subject_test.txt", sep="/test/")
        test_subjects = read.table(file = testfilepath,
                                   head = FALSE,
                                   col.names = c("subject_id"))
 
        ####################################################
        
        ## subset features with "mean()" and "std()"
        ## Extracts only the measurements on the mean and standard deviation for each measurement.

        ## replace Y_test_label with activity names
        ## Uses descriptive activity names to name the activities in the data set
        attach(Y_test_label)
        Y_test_label$activity_name <-ifelse(activity_id == 1,activity_labels[1],
                                             ifelse(activity_id == 2,activity_labels[1],
                                                    ifelse(activity_id == 3,activity_labels[3],
                                                           ifelse(activity_id == 4,activity_labels[4],
                                                                  ifelse(activity_id == 5,activity_labels[5],
                                                                         ifelse(activity_id == 6,activity_labels[6],"NA"
                                                                         ))))))
        detach(Y_test_label) 
        
        ## Merge data horizontally using cbind
        test_dataset <- cbind(test_subjects, Y_test_label[,"activity_name"], X_test_set[extracted_feature_ids])
        colnames(test_dataset)[2] <- "activity_name"       
        
        ## Merge train and test dataset
        merged_dataset <- rbind(train_dataset, test_dataset)
        
        ## Appropriately labels the data set with descriptive variable names. 
        colnames(merged_dataset) <- c("subject_id", 
                                        "activity_name",
                                        "tBodyAcc-mean()-X",
                                        "tBodyAcc-mean()-Y",
                                        "tBodyAcc-mean()-Z",
                                        "tBodyAcc-std()-X",
                                        "tBodyAcc-std()-Y",
                                        "tBodyAcc-std()-Z",
                                        "tGravityAcc-mean()-X",
                                        "tGravityAcc-mean()-Y",
                                        "tGravityAcc-mean()-Z",
                                        "tGravityAcc-std()-X",
                                        "tGravityAcc-std()-Y",
                                        "tGravityAcc-std()-Z",
                                        "tBodyAccJerk-mean()-X",
                                        "tBodyAccJerk-mean()-Y",
                                        "tBodyAccJerk-mean()-Z",
                                        "tBodyAccJerk-std()-X",
                                        "tBodyAccJerk-std()-Y",
                                        "tBodyAccJerk-std()-Z",
                                        "tBodyGyro-mean()-X",
                                        "tBodyGyro-mean()-Y",
                                        "tBodyGyro-mean()-Z",
                                        "tBodyGyro-std()-X",
                                        "tBodyGyro-std()-Y",
                                        "tBodyGyro-std()-Z",
                                        "tBodyGyroJerk-mean()-X",
                                        "tBodyGyroJerk-mean()-Y",
                                        "tBodyGyroJerk-mean()-Z",
                                        "tBodyGyroJerk-std()-X",
                                        "tBodyGyroJerk-std()-Y",
                                        "tBodyGyroJerk-std()-Z",
                                        "tBodyAccMag-mean()",
                                        "tBodyAccMag-std()",
                                        "tGravityAccMag-mean()",
                                        "tGravityAccMag-std()",
                                        "tBodyAccJerkMag-mean()",
                                        "tBodyAccJerkMag-std()",
                                        "tBodyGyroMag-mean()",
                                        "tBodyGyroMag-std()",
                                        "tBodyGyroJerkMag-mean()",
                                        "tBodyGyroJerkMag-std()",
                                        "fBodyAcc-mean()-X",
                                        "fBodyAcc-mean()-Y",
                                        "fBodyAcc-mean()-Z",
                                        "fBodyAcc-std()-X",
                                        "fBodyAcc-std()-Y",
                                        "fBodyAcc-std()-Z",
                                        "fBodyAccJerk-mean()-X",
                                        "fBodyAccJerk-mean()-Y",
                                        "fBodyAccJerk-mean()-Z",
                                        "fBodyAccJerk-std()-X",
                                        "fBodyAccJerk-std()-Y",
                                        "fBodyAccJerk-std()-Z",
                                        "fBodyGyro-mean()-X",
                                        "fBodyGyro-mean()-Y",
                                        "fBodyGyro-mean()-Z",
                                        "fBodyGyro-std()-X",
                                        "fBodyGyro-std()-Y",
                                        "fBodyGyro-std()-Z",
                                        "fBodyAccMag-mean()",
                                        "fBodyAccMag-std()",
                                        "fBodyBodyAccJerkMag-mean()",
                                        "fBodyBodyAccJerkMag-std()",
                                        "fBodyBodyGyroMag-mean()",
                                        "fBodyBodyGyroMag-std()",
                                        "fBodyBodyGyroJerkMag-mean()",
                                        "fBodyBodyGyroJerkMag-std()"
                                                ) 
        
        ## From merged_dataset, create a second, independent tidy data set with 
        ## the average of each variable (column) for each activity and 
        ## the average of each variable (column) for each subject.
        
        ## to be done.
        
        
        #         ## Inertial Signals (Training)
        #  
        #         ## - 'train/Inertial Signals/total_acc_x_train.txt': 
        #         ## The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
        #         ## Every row shows a 128 element vector. 
        #         ## The same description applies for the 'total_acc_y_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
        #         testfilepath <- paste(wdir, "total_acc_x_train.txt", sep="/train/Inertial Signals/")
        #         train_total_acc_x_train = read.table(file = testfilepath,
        #                                              head = FALSE)
        #         
        #         testfilepath <- paste(wdir, "total_acc_y_train.txt", sep="/train/Inertial Signals/")
        #         train_total_acc_y_train = read.table(file = testfilepath,
        #                                              head = FALSE)
        #         
        #         testfilepath <- paste(wdir, "total_acc_z_train.txt", sep="/train/Inertial Signals/")
        #         train_total_acc_z_train = read.table(file = testfilepath,
        #                                              head = FALSE)
        #         
        #         ## - 'train/Inertial Signals/body_acc_x_train.txt': 
        #         ## The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
        #         testfilepath <- paste(wdir, "body_acc_x_train.txt", sep="/train/Inertial Signals/")
        #         train_body_acc_x_train = read.table(file = testfilepath,
        #                                             head = FALSE)
        #         
        #         testfilepath <- paste(wdir, "body_acc_y_train.txt", sep="/train/Inertial Signals/")
        #         train_body_acc_y_train = read.table(file = testfilepath,
        #                                             head = FALSE)
        #         
        #         testfilepath <- paste(wdir, "body_acc_z_train.txt", sep="/train/Inertial Signals/")
        #         train_body_acc_z_train = read.table(file = testfilepath,
        #                                             head = FALSE) 
        #         
        #         ## - 'train/Inertial Signals/body_gyro_x_train.txt': 
        #         ## The angular velocity vector measured by the gyroscope for each window sample. 
        #         ## The units are radians/second. 
        #         testfilepath <- paste(wdir, "body_gyro_x_train.txt", sep="/train/Inertial Signals/")
        #         train_body_gyro_x_train = read.table(file = testfilepath,
        #                                              head = FALSE)
        #         
        #         testfilepath <- paste(wdir, "body_gyro_y_train.txt", sep="/train/Inertial Signals/")
        #         train_body_gyro_y_train = read.table(file = testfilepath,
        #                                              head = FALSE)
        #         
        #         testfilepath <- paste(wdir, "body_gyro_z_train.txt", sep="/train/Inertial Signals/")
        #         train_body_gyro_z_train = read.table(file = testfilepath,
        #
        
#         ## Inertial Signals (Test)
#         
#         ## - 'test/Inertial Signals/total_acc_x_test.txt': 
#         ## The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
#         ## Every row shows a 128 element vector. 
#         ## The same description applies for the 'total_acc_y_test.txt' and 'total_acc_z_test.txt' files for the Y and Z axis. 
#         testfilepath <- paste(wdir, "total_acc_x_test.txt", sep="/test/Inertial Signals/")
#         train_total_acc_x_test = read.table(file = testfilepath,
#                                              head = FALSE)
#         
#         testfilepath <- paste(wdir, "total_acc_y_test.txt", sep="/test/Inertial Signals/")
#         train_total_acc_y_test = read.table(file = testfilepath,
#                                                  head = FALSE)
#         
#         testfilepath <- paste(wdir, "total_acc_z_train.txt", sep="/test/Inertial Signals/")
#         train_total_acc_z_test = read.table(file = testfilepath,
#                                              head = FALSE)
#         
#         ## - 'test/Inertial Signals/body_acc_x_test.txt': 
#         ## The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
#         testfilepath <- paste(wdir, "body_acc_x_test.txt", sep="/test/Inertial Signals/")
#         train_body_acc_x_test = read.table(file = testfilepath,
#                                             head = FALSE)
#         
#         testfilepath <- paste(wdir, "body_acc_y_test.txt", sep="/test/Inertial Signals/")
#         train_body_acc_y_test = read.table(file = testfilepath,
#                                             head = FALSE)
#         
#         testfilepath <- paste(wdir, "body_acc_z_test.txt", sep="/test/Inertial Signals/")
#         train_body_acc_z_test = read.table(file = testfilepath,
#                                             head = FALSE) 
#         
#         ## - 'test/Inertial Signals/body_gyro_x_test.txt': 
#         ## The angular velocity vector measured by the gyroscope for each window sample. 
#         ## The units are radians/second. 
#         testfilepath <- paste(wdir, "body_gyro_x_test.txt", sep="/test/Inertial Signals/")
#         train_body_gyro_x_test = read.table(file = testfilepath,
#                                              head = FALSE)
#         
#         testfilepath <- paste(wdir, "body_gyro_y_test.txt", sep="/test/Inertial Signals/")
#         train_body_gyro_y_test = read.table(file = testfilepath,
#                                              head = FALSE)
#         
#         testfilepath <- paste(wdir, "body_gyro_z_test.txt", sep="/test/Inertial Signals/")
#         train_body_gyro_z_test = read.table(file = testfilepath,
#                                              head = FALSE)
