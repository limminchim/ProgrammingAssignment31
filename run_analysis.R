## R Assignment for "Getting and Cleaning Data"

## File: run_analysis.R 
## Function that does the following:
## 0. Read training and test data from local folder
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each 
##    measurement. 
## 2. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
## 6. Save final data to text file
## 
## The goal is to prepare tidy data that can be used for later analysis.

cleanAndPrepareTidyData <- function() {


        # install.packages("sqldf")
        library(sqldf)
        library(dplyr)
        library(reshape2)
        library(tcltk)
        library(stringr)
        
        ## get current working dir
        wdir <- getwd()
        
        ## Read all data files into data frames
        
        ## Read 'features.txt': List of all features.
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
        
        ## Read training dataset, activity labels and subjects
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
 
        ## Read test dataset, activity labels and subjects
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
        ####################################################
        ## 3. Uses descriptive activity names to name the activities in the data set
        ## replace Y_train_label with activity names
        attach(Y_train_label)
        Y_train_label$activity_name <-ifelse(activity_id == 1,activity_labels[1],
                                             ifelse(activity_id == 2,activity_labels[2],
                                                    ifelse(activity_id == 3,activity_labels[3],
                                                           ifelse(activity_id == 4,activity_labels[4],
                                                                  ifelse(activity_id == 5,activity_labels[5],
                                                                         ifelse(activity_id == 6,activity_labels[6],"NA"
                                                                         ))))))
        detach(Y_train_label)         

        ## replace Y_test_label with activity names
        attach(Y_test_label)
        Y_test_label$activity_name <-ifelse(activity_id == 1,activity_labels[1],
                                            ifelse(activity_id == 2,activity_labels[2],
                                                   ifelse(activity_id == 3,activity_labels[3],
                                                          ifelse(activity_id == 4,activity_labels[4],
                                                                 ifelse(activity_id == 5,activity_labels[5],
                                                                        ifelse(activity_id == 6,activity_labels[6],"NA"
                                                                        ))))))
        detach(Y_test_label) 

        ####################################################
        ####################################################
        ## 1. Merges the training and the test sets to create one data set.
        ## Merge data horizontally using cbind
        train_dataset <- cbind(Y_train_label[,"activity_name"], train_subjects, X_train_set)
        colnames(train_dataset)[1] <- "activity_name"
         ## Merge data horizontally using cbind
        test_dataset <- cbind(Y_test_label[,"activity_name"], test_subjects, X_test_set)
        colnames(test_dataset)[1] <- "activity_name"       
        ## Merge train and test dataset
        merged_dataset_all <- rbind(train_dataset, test_dataset)
        
        ####################################################
        ####################################################
        ## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

        extracted_features <- sqldf("select * from features where 
                                    feature_name like '%std%' or 
                                    feature_name like '%mean()%'")
        
        extracted_feature_ids <- as.numeric(extracted_features$feature_id)
        ## extracted_X_train_set <- X_train_set[extracted_feature_ids]
        ## Merge data horizontally using cbind
        train_dataset <- cbind(Y_train_label[,"activity_name"], train_subjects, X_train_set[extracted_feature_ids])
        colnames(train_dataset)[1] <- "activity_name"
        ## Merge data horizontally using cbind
        test_dataset <- cbind(Y_test_label[,"activity_name"], test_subjects, X_test_set[extracted_feature_ids])
        colnames(test_dataset)[1] <- "activity_name"       
        ## Merge train and test dataset
        merged_dataset_with_mean_std <- rbind(train_dataset, test_dataset)
        

        ####################################################
        ####################################################
        ## 4. Appropriately labels the data set with descriptive variable names. 
        col_names1 <-c("activity", "subject")
        ## This is the list of only features with the mean and standard deviation for the measurement. 
        col_names2 <- features[extracted_feature_ids,-1]
        ## make all valid R column names
        col_names2 <- make.names(col_names2, unique = TRUE)
        ## freq domain signals
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyGyroJerkMag", 
                                       "frequency.domain.3d.body.angular.velocity.jerk.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyBodyGyroJerkMag", 
                                      "frequency.domain.3d.body.angular.velocity.jerk.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyAccJerkMag", 
                                       "frequency.domain.3d.body.linear.acceleration.jerk.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyBodyAccJerkMag", 
                                      "frequency.domain.3d.body.linear.acceleration.jerk.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyGyroMag", 
                                      "frequency.domain.3d.body.gyroscope.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyBodyGyroMag", 
                                      "frequency.domain.3d.body.gyroscope.magnitude")       
        
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyAccMag", 
                                       "frequency.domain.3d.body.acceleration.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyGyro", 
                                       "frequency.domain.body.gyroscope.X.direction")
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyAccJerk", 
                                       "frequency.domain.linear.acceleration.jerk")
        col_names2 <- str_replace_all(col_names2, pattern = "fBodyAcc", 
                                       "frequency.domain.body.acceleration")
        ## time domain signals
        col_names2 <- str_replace_all(col_names2, pattern = "tBodyGyroJerkMag", 
                                       "time.domain.3d.body.angular.velocity.jerk.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "tBodyGyroMag", 
                                       "time.domain.3d.body.gyroscope.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "tBodyAccJerkMag", 
                                       "time.domain.3d.body.linear.acceleration.jerk.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "tGravityAccMag", 
                                       "time.domain.3d.gravity.acceleration.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "tBodyAccMag", 
                                       "time.domain.3d.body.acceleration.magnitude")
        col_names2 <- str_replace_all(col_names2, pattern = "tBodyGyroJerk", 
                                       "time.domain.body.angular.velocity.jerk")
        col_names2 <- str_replace_all(col_names2, pattern = "tBodyGyro", 
                                       "time.domain.body.gyroscope")
        col_names2 <- str_replace_all(col_names2, pattern = "tBodyAccJerk", 
                                       "time.domain.body.linear.acceleration.jerk")
        col_names2 <- str_replace_all(col_names2, pattern = "tGravityAcc", 
                                       "time.domain.gravity.acceleration")
        col_names2 <- str_replace_all(col_names2, pattern = "tBodyAcc", 
                                       "time.domain.body.acceleration")
        ## direction of signals
        col_names2 <- str_replace_all(col_names2, pattern = "..X", 
                                       "..x.direction")
        col_names2 <- str_replace_all(col_names2, pattern = "..Y", 
                                       "..y.direction")        
        col_names2 <- str_replace_all(col_names2, pattern = "..Z", 
                                       "..z.direction") 
        ## derived values
        col_names2 <- str_replace_all(col_names2, pattern = "meanFreq..", 
                                       ".weighted.average.of.frequency.components")
        col_names2 <- str_replace_all(col_names2, pattern = "mean..", 
                                       "mean.value")
        col_names2 <- str_replace_all(col_names2, pattern = "std..", 
                                       "standard.deviation")
        ## join the 2 sets        
        valid_col_names1 <- make.names(col_names1, unique = TRUE)
        valid_col_names2 <- make.names(col_names2, unique = TRUE)
        valid_col_names <- c(valid_col_names1, valid_col_names2)
        ## Replace the column names with descriptive variable names. 
        colnames(merged_dataset_with_mean_std) <- valid_col_names
    
        ####################################################
        ####################################################
        ## 5. From the data set in step 4, creates a second, independent tidy 
        ## data set with the average of each variable for each activity and 
        ## each subject.

        ## melt the merged dataset to get a narrow dataset with 
        ## ids = activity + subject and variables = all features
        merged_dataset_narrow <- melt(merged_dataset_with_mean_std, 
                                           id.vars=valid_col_names1)

        ## compute the average of each variable for each activity and 
        ## each subject.
        merged_dataset_wide <- dcast(merged_dataset_narrow, 
                                          activity + subject ~ variable, 
                                          fun.aggregate = mean)
        
        ## melt the dataset to get it back into narrow format
        ## tidy data set:
        ## a. each variable forms a column
        ## b. each observation forms a row
        ## c. Each table/file stores data about one kind of observation
        melt_merge_dataset <- melt(merged_dataset_wide, 
                                   id.vars=valid_col_names1,
                                   variable.name = "variable", 
                                   value.name = "average.of.variable.values.for.activity.and.subject") 
          
        ####################################################
        ####################################################
        ## save tidy data set created in step 5 of the instructions 
        ## as a txt file created with write.table() using row.name=FALSE 
        write.table(melt_merge_dataset, 
                    file = "melt_merge_dataset.txt",
                    row.names=FALSE, 
                    sep=" ")
        
}        
        
  
