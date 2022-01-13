a) xtest  <- test/X_test.txt: 2947 observations, 561 variables (recorded features in test data)
b) ytest  <- test/y_test.txt: 2947 observations, 1 variable (test data of code labels in actvities)      
c) sub_test  <- test/subject_test.txt: 2947 observations, 1 variable    
d) xtrain <- train/X_train.txt: 7352 observations, 561 variables (recorded features in train data)
e) ytrain <- train/y_train.txt: 7352 observations, 1 variable (train data of code labels in activities)
f) sub_train <- train/subject_train.txt: 7352 observations, 1 variable (train data of volunteer subjects observed)
g) features  <- features.txt: 561 observations, 2 variables (from accelerometer and gyroscope)
h) acts  <- activity_labels.txt: 6 observations, 2 variables (activities performed; codes/labels)
1. Merges the training and the test sets to create one data set
  a) x: 10299 observations, 561 variables - used rbind() function to merge xtrain and xtest
  b) y: 10299 observations, 1 variable - merges ytrain and ytest using rbind() function
  c) subject: 10299 observations, 1 variable - created using rbind() function by merging sub_train and sub_test
  d) Data: 10299 observations, 563 variables - used cbind() function to be created through merging subject, y, and x 
2. Extracts only the measurements on the mean and standard deviation for each measurement
  a) extracted_data - identify all features that are either mean "-mean()" or standard deviations "-std()" of measurements using grep transfromation
  b) filtered_data: 10299 observations, 66 variables - columns that are not means or standard deviation features are removed from extracted_data
3. Uses descriptive activity names to name the activities in the data set
  a) activity - convert label codes to a factor 
  b) subs - transforms subject codes to factors
  c) filtered_data: 10299 observations, 68 variables - binds subject and activity 
4.	Appropriately labels the data set with descriptive variable names
  a) filtered_features - mean and standard deviation are attached as column names to the data set and cleaned; used extracted_data to get the names of all mean and standard deviation features  
  b) clean - function that does the cleaning; used a gsub regular expression to clean parenthesis and hyphens and make the name  lowercase 
  c) filtered_features - uses sapply to apply the function to all desired features
  Adds filtered_features to filtered_data; 
  d) names(filtered_data)[3:ncol(filtered_data)] <- filtered_features
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  a) Final_Data: 180 observations, 68 variables - created by using filtered_data, taking the means of each variable for activity and subject then grouped into to (by activity and subs)