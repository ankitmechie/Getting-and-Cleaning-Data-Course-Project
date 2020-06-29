run_analysis.R does the following:


1. It downloads the data and extracts it into the folder: UCI HAR Dataset
2. It assigns the data into following data frames:
	features 
	activities
	subject_test 
	x_test 
	y_test 
	subject_train 
	x_train 
	y_train 
3. It merges training and test data
	X by merging x_train and x_test using rbind() 
	Y by merging y_train and y_test using rbind()
	Subject by merging subject_train and subject_test using rbind()
	Merged_Data by merging Subject, Y and X using cbind() 
4. Extracts only the measurements on the mean and standard deviation for each measurement.
	AllData contains the measurements on the mean and standard deviation (std) for each measurement
5. Uses descriptive activity names to name the activities in the data set
	All the data set are labelled with descriptive name sets using gsub
6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
	FinalData is created by sumarizing AllData and exported to FinalData.txt file.
