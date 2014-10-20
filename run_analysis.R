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
        
        ## Read data
        
        ## - 'features.txt': List of all features.
        testfilepath <- paste(wdir, "features.txt", sep="/")
        features = read.table(file = testfilepath,
                              head = FALSE,
                              col.names = c("num","label"))
        feature_labels <- as.character(features$label)
        
        ## - 'activity_labels.txt': Links the class labels with their activity name.
        testfilepath <- paste(wdir, "activity_labels.txt", sep="/")
        activities = read.table(file = testfilepath,
                                head = FALSE,
                                col.names = c("num","label"))
        activity_labels <- as.character(activities$label)
        
        ## - 'train/X_train.txt': Training set.
        testfilepath <- paste(wdir, "X_train.txt", sep="/train/")
        X_train_set = read.table(file = testfilepath,
                                 head = FALSE,
                                 col.names = feature_labels)
        
        ## - 'train/y_train.txt': Training labels.
        testfilepath <- paste(wdir, "Y_train.txt", sep="/train/")
        Y_train_label = read.table(file = testfilepath,
                                 head = FALSE,
                                 col.names = c("training_label"))
        
        ## - 'test/X_test.txt': Test set.
        testfilepath <- paste(wdir, "X_test.txt", sep="/test/")
        X_test_set = read.table(file = testfilepath,
                                head = FALSE,
                                col.names = feature_labels)
        
        ## - 'test/y_test.txt': Test labels.
        testfilepath <- paste(wdir, "Y_test.txt", sep="/test/")
        Y_test_label = read.table(file = testfilepath,
                                  head = FALSE,
                                  col.names = c("test_label"))

        
        ## The following files are available for the train and test data. Their descriptions are equivalent. 
        
        ## - 'train/subject_train.txt': 
        ## Each row identifies the subject who performed the activity for each window sample. 
        ## Its range is from 1 to 30. 
        testfilepath <- paste(wdir, "subject_train.txt", sep="/train/")
        train_subjects = read.table(file = testfilepath,
                                  head = FALSE,
                                  col.names = c("subject_label"))
        
        ## - 'train/Inertial Signals/total_acc_x_train.txt': 
        ## The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
        ## Every row shows a 128 element vector. 
        ## The same description applies for the 'total_acc_y_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
        testfilepath <- paste(wdir, "total_acc_x_train.txt", sep="/train/Inertial Signals/")
        ## - 'train/Inertial Signals/total_acc_x_train.txt': 
        ## The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
        ## Every row shows a 128 element vector. 
        ## The same description applies for the 'total_acc_y_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
        testfilepath <- paste(wdir, "total_acc_x_train.txt", sep="/train/Inertial Signals/")
        train_total_acc_signal_x_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "total_acc_y_train.txt", sep="/train/Inertial Signals/")
        train_total_acc_signal_y_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "total_acc_z_train.txt", sep="/train/Inertial Signals/")
        train_total_acc_signal_z_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        ## - 'train/Inertial Signals/body_acc_x_train.txt': 
        ## The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
        testfilepath <- paste(wdir, "body_acc_x_train.txt", sep="/train/Inertial Signals/")
        train_body_acc_signal_x_axis = read.table(file = testfilepath,
                                            head = FALSE)
        
        testfilepath <- paste(wdir, "body_acc_y_train.txt", sep="/train/Inertial Signals/")
        train_body_acc_signal_y_axis = read.table(file = testfilepath,
                                            head = FALSE)
        
        testfilepath <- paste(wdir, "body_acc_z_train.txt", sep="/train/Inertial Signals/")
        train_body_acc_signal_z_axis = read.table(file = testfilepath,
                                            head = FALSE) 
        
        ## - 'train/Inertial Signals/body_gyro_x_train.txt': 
        ## The angular velocity vector measured by the gyroscope for each window sample. 
        ## The units are radians/second. 
        testfilepath <- paste(wdir, "body_gyro_x_train.txt", sep="/train/Inertial Signals/")
        train_body_gyro_signal_x_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "body_gyro_y_train.txt", sep="/train/Inertial Signals/")
        train_body_gyro_signal_y_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "body_gyro_z_train.txt", sep="/train/Inertial Signals/")
        body_gyro_signal_z_axis = read.table(file = testfilepath,
                                             head = FALSE)       
        train_total_acc_signal_x_axis = read.table(file = testfilepath,
                                       head = FALSE)
        
        testfilepath <- paste(wdir, "total_acc_y_train.txt", sep="/train/Inertial Signals/")
        train_total_acc_signal_y_axis = read.table(file = testfilepath,
                                             head = FALSE)

        testfilepath <- paste(wdir, "total_acc_z_train.txt", sep="/train/Inertial Signals/")
        train_total_acc_signal_z_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        ## - 'train/Inertial Signals/body_acc_x_train.txt': 
        ## The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
        testfilepath <- paste(wdir, "body_acc_x_train.txt", sep="/train/Inertial Signals/")
        train_body_acc_signal_x_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "body_acc_y_train.txt", sep="/train/Inertial Signals/")
        train_body_acc_signal_y_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "body_acc_z_train.txt", sep="/train/Inertial Signals/")
        train_body_acc_signal_z_axis = read.table(file = testfilepath,
                                             head = FALSE) 
        
        ## - 'train/Inertial Signals/body_gyro_x_train.txt': 
        ## The angular velocity vector measured by the gyroscope for each window sample. 
        ## The units are radians/second. 
        testfilepath <- paste(wdir, "body_gyro_x_train.txt", sep="/train/Inertial Signals/")
        train_body_gyro_signal_x_axis = read.table(file = testfilepath,
                                            head = FALSE)
        
        testfilepath <- paste(wdir, "body_gyro_y_train.txt", sep="/train/Inertial Signals/")
        train_body_gyro_signal_y_axis = read.table(file = testfilepath,
                                            head = FALSE)
        
        testfilepath <- paste(wdir, "body_gyro_z_train.txt", sep="/train/Inertial Signals/")
        train_body_gyro_signal_z_axis = read.table(file = testfilepath,
                                            head = FALSE)       


        ## - 'test/subject_train.txt': 
        ## Each row identifies the subject who performed the activity for each window sample. 
        ## Its range is from 1 to 30. 
        testfilepath <- paste(wdir, "subject_test.txt", sep="/test/")
        train_subjects = read.table(file = testfilepath,
                                    head = FALSE,
                                    col.names = c("subject_label"))
   
        
        ## - 'test/Inertial Signals/total_acc_x_test.txt': 
        ## The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
        ## Every row shows a 128 element vector. 
        ## The same description applies for the 'total_acc_y_test.txt' and 'total_acc_z_test.txt' files for the Y and Z axis. 
        testfilepath <- paste(wdir, "total_acc_x_train.txt", sep="/test/Inertial Signals/")
        test_total_acc_signal_x_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "total_acc_y_train.txt", sep="/test/Inertial Signals/")
        test_total_acc_signal_y_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "total_acc_z_train.txt", sep="/test/Inertial Signals/")
        test_total_acc_signal_z_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        ## - 'train/Inertial Signals/body_acc_x_train.txt': 
        ## The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
        testfilepath <- paste(wdir, "body_acc_x_train.txt", sep="/test/Inertial Signals/")
        test_body_acc_signal_x_axis = read.table(file = testfilepath,
                                            head = FALSE)
        
        testfilepath <- paste(wdir, "body_acc_y_train.txt", sep="/test/Inertial Signals/")
        test_body_acc_signal_y_axis = read.table(file = testfilepath,
                                            head = FALSE)
        
        testfilepath <- paste(wdir, "body_acc_z_train.txt", sep="/test/Inertial Signals/")
        test_body_acc_signal_z_axis = read.table(file = testfilepath,
                                            head = FALSE) 
        
        ## - 'train/Inertial Signals/body_gyro_x_train.txt': 
        ## The angular velocity vector measured by the gyroscope for each window sample. 
        ## The units are radians/second. 
        testfilepath <- paste(wdir, "body_gyro_x_train.txt", sep="/test/Inertial Signals/")
        test_body_gyro_signal_x_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "body_gyro_y_train.txt", sep="/test/Inertial Signals/")
        test_body_gyro_signal_y_axis = read.table(file = testfilepath,
                                             head = FALSE)
        
        testfilepath <- paste(wdir, "body_gyro_z_train.txt", sep="/test/Inertial Signals/")
        test_body_gyro_signal_z_axis = read.table(file = testfilepath,
                                             head = FALSE)       
        
        
