Description: Code Book for Programming Assignment 1 under "Getting and Cleaning Data" - Coursera
This Code Book describes the variables, the data, and any transformations or work that was performed to clean up the data 

Fulfill requirements:
======================
The assignment has been fulfilled through the following steps:
- Step 3: Merges the training and the test sets to create one data set.
- Step 4: Extracts only the measurements on the mean and standard deviation for each measurement.
- Step 2: Uses descriptive activity names to name the activities in the data set.
- Step 5: Appropriately labels the data set with descriptive variable names. 
- Step 6: From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Step 7: Save tidy data set as a txt file created with write.table() using row.name=FALSE

The source data set includes the following files:
=================================================
- 'README.txt': Code Book for source dataset 
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of 561 features and labels.
- 'activity_labels.txt': Links the 6 activity ids and activity labels.
- 'train/X_train.txt': Training data set with 7,352 observations of 561 features (variables).
- 'train/y_train.txt': Training data set of activity ids with 7,352 observations
- 'train/subject_train.txt': Training data set of subject ids with 7,352 observations. Each row identifies the subject who performed the training activity for each window sample. Its range is from 1 to 30. 
- 'test/X_test.txt':  Test data set with 2,947 observations of 561 features (variables).
- 'test/y_test.txt': Test data set of activity ids with 2,947 observations
- 'test/subject_test.txt': Test data set of subject ids with 2,947 observations. Each row identifies the subject who performed the test activity for each window sample. Its range is from 1 to 30. 

The files in the following folders are not used.
- 'train/Inertial Signals'
- 'test/Inertial Signals'

What the script does:
=====================
1.  Read data files
1a. Read features information into "features" dataframe - 561 observations of feature ids and feature names
1b. Read activity information into "activities" dataframe - 6 types of activities
    Extract the activity names into "activity_labels" vector
1c. Read training dataset, training activities and training subjects into datasets with 7,352 observations each:
    X_train_set
    Y_train_label
    train_subjects
1d. Read test dataset, training activities and training subjects into datasets with 2,947 observations each:
    X_test_set
    Y_test_label
    test_subjects

2.  Use descriptive activity names
2a. Add a new column to Y_train_label and Y_test_label that uses descriptive activity names to name the activities in the data sets   

3.  Merge the training and test sets (using row-bind) to create one data set
3a. For training datasets, column-bind them into one dataset:
    activity names, subjects and feature values
3b. For test datasets, column-bind them into one dataset:
    activity names, subjects and feature values
3c. Merge the training and test sets (using row-bind) to create one data set "merged_dataset_all" with 10,299 observations of 563 variables. 10,299 observations = 7,352 training observations + 2,947 test observations. 563 variables = activity name + subject + 561 features

4.  Extract only the measures on the mean and standard deviation for each measurement.
We do this by selecting 66 features with "std()" or "mean()" in their names because these are described in the data code book "features_info.txt" as the mean and standard deviation estimated from the measurements. The extracted measures are stored in dataframe "merged_dataset_with_mean_std" with 10,299 observations with 68 variables. 10,299 observations = 7,352 training observations + 2,947 test observations. 68 variables = activity name + subject + 66 std() or mean() features.

5. Appropriately labels the data set with descriptive variable names 
The script is used to generate descriptive names for the activity, subject and features based on what is described in "features_info.txt". The names are also valid R column names to provide ease-of-use in R. The column names of "merged_dataset_with_mean_std" is replaced with these descriptive names.
        activity
        subject
        time.domain.body.acceleration.mean.value.x.direction
        time.domain.body.acceleration.mean.value.y.direction
        time.domain.body.acceleration.mean.value.z.direction
        time.domain.body.acceleration.standard.deviation.x.direction
        time.domain.body.acceleration.standard.deviation.y.direction
        time.domain.body.acceleration.standard.deviation.z.direction
        time.domain.gravity.acceleration.mean.value.x.direction
        time.domain.gravity.acceleration.mean.value.y.direction
        time.domain.gravity.acceleration.mean.value.z.direction
        time.domain.gravity.acceleration.standard.deviation.x.direction
        time.domain.gravity.acceleration.standard.deviation.y.direction
        time.domain.gravity.acceleration.standard.deviation.z.direction
        time.domain.body.linear.acceleration.jerk.mean.value.x.direction
        time.domain.body.linear.acceleration.jerk.mean.value.y.direction
        time.domain.body.linear.acceleration.jerk.mean.value.z.direction
        time.domain.body.linear.acceleration.jerk.standard.deviation.x.direction
        time.domain.body.linear.acceleration.jerk.standard.deviation.y.direction
        time.domain.body.linear.acceleration.jerk.standard.deviation.z.direction
        time.domain.body.gyroscope.mean.value.x.direction
        time.domain.body.gyroscope.mean.value.y.direction
        time.domain.body.gyroscope.mean.value.z.direction
        time.domain.body.gyroscope.standard.deviation.x.direction
        time.domain.body.gyroscope.standard.deviation.y.direction
        time.domain.body.gyroscope.standard.deviation.z.direction
        time.domain.body.angular.velocity.jerk.mean.value.x.direction
        time.domain.body.angular.velocity.jerk.mean.value.y.direction
        time.domain.body.angular.velocity.jerk.mean.value.z.direction
        time.domain.body.angular.velocity.jerk.standard.deviation.x.direction
        time.domain.body.angular.velocity.jerk.standard.deviation.y.direction
        time.domain.body.angular.velocity.jerk.standard.deviation.z.direction
        time.domain.3d.body.acceleration.magnitude.mean.value
        time.domain.3d.body.acceleration.magnitude.standard.deviation
        time.domain.3d.gravity.acceleration.magnitude.mean.value
        time.domain.3d.gravity.acceleration.magnitude.standard.deviation
        time.domain.3d.body.linear.acceleration.jerk.magnitude.mean.value
        time.domain.3d.body.linear.acceleration.jerk.magnitude.standard.deviation
        time.domain.3d.body.gyroscope.magnitude.mean.value
        time.domain.3d.body.gyroscope.magnitude.standard.deviation
        time.domain.3d.body.angular.velocity.jerk.magnitude.mean.value
        time.domain.3d.body.angular.velocity.jerk.magnitude.standard.deviation
        frequency.domain.body.acceleration.mean.value.x.direction
        frequency.domain.body.acceleration.mean.value.y.direction
        frequency.domain.body.acceleration.mean.value.z.direction
        frequency.domain.body.acceleration.standard.deviation.x.direction
        frequency.domain.body.acceleration.standard.deviation.y.direction
        frequency.domain.body.acceleration.standard.deviation.z.direction
        frequency.domain.linear.acceleration.jerk.mean.value.x.direction
        frequency.domain.linear.acceleration.jerk.mean.value.y.direction
        frequency.domain.linear.acceleration.jerk.mean.value.z.direction
        frequency.domain.linear.acceleration.jerk.standard.deviation.x.direction
        frequency.domain.linear.acceleration.jerk.standard.deviation.y.direction
        frequency.domain.linear.acceleration.jerk.standard.deviation.z.direction
        frequency.domain.body.gyroscop..x.direction.direction.mean.value.x.direction
        frequency.domain.body.gyroscop..x.direction.direction.mean.value.y.direction
        frequency.domain.body.gyroscop..x.direction.direction.mean.value.z.direction
        frequency.domain.body.gyroscop..x.direction.direction.standard.deviation.x.direction
        frequency.domain.body.gyroscop..x.direction.direction.standard.deviation.y.direction
        frequency.domain.body.gyroscop..x.direction.direction.standard.deviation.z.direction
        frequency.domain.3d.body.acceleration.magnitude.mean.value
        frequency.domain.3d.body.acceleration.magnitude.standard.deviation
        frequency.domain.3d.body.linear.acceleration.jerk.magnitude.mean.value
        frequency.domain.3d.body.linear.acceleration.jerk.magnitude.standard.deviation
        frequency.domain.3d.body.gyroscope.magnitude.mean.value
        frequency.domain.3d.body.gyroscope.magnitude.standard.deviation
        frequency.domain.3d.body.angular.velocity.jerk.magnitude.mean.value
        frequency.domain.3d.body.angular.velocity.jerk.magnitude.standard.deviation
        
6. Create another independent tidy data set with the average of each variable for each activity and each subject from the data set derived in the previous step.
6a. Melt the merged dataset "merged_dataset_with_mean_std" to get a narrow dataset where ids = activity + subject and variables = all features
6b. Compute the average (mean) of each variable for each activity and each subject through a dcast. We end up with a wide dataset.
6c. Melt the dataset to get it back into narrow format "melt_merge_dataset" with 11,880 observtions of 4 variables.
11,880 observtions = 30 subjects x 6 activities X 66 measurements and the variables are
- activity description
- subject
- variable descriptive label
- average of variable values for activity and subject
This dataset satisfy the criteria for tidy data set
        i.   Each variable forms a column
        ii.  Each observation forms a row
        iii. Each table/file stores data about one kind of observation

7. Save tidy data set as a txt file "melt_merge_dataset.txt" created with write.table() using row.name=FALSE and space-delimited. This file has 1 header row, 11,880 data rows and 4 columns.

  




