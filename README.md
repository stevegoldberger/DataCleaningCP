READ ME - Human Activity Recognition Using Smartphones Data Set 
===============================================================

This readme file explains the code processsing of the UCI Human activity data using Smart
phones Dataset.

1. Read in the data

The first step is the data is read in.  The following data sets are read in with the following purposes:
	- activity_labels.txt: Determine the 6 different activity codes and what they are
	- features.txt:  Determine the 561 variable codes
	- X_test.txt: Each measurement of the 561 variables in the test data
	- y_test.txt: What activity was taking place for the observation in the test data
	- subject_test.txt: Identify each subject in the test data by number
	- X_train.txt: Each measurement of the 561 variables in the train data
	- y_train.txt: What activity was taking place for the observation in the train data
	- subject_train.txt: Identify each subject in the train data by number

2. Create the Factor variables/list and combine

The test and the training data were combined by simply appending the training data to the test data (x_train to y_train).  Additionally three factor variables were created to describe the observations within the combined data:
	- factOrig: The origin of the observation, either test data or training data
	- factSub: The Subject by number
	- factAct: The Activity by type (names taken from activity_labels.txt)

With the combined data and these three factors then the average and standard deviation for each of the 561 variables within each factor can be calculated.  This is first done by spliting the combined data along each factor combination (Origin X Subject X Activity) and then taking the mean and sd.

3. Calculate the Mean and Standard Deviation

The mean and standard deviation are calcuated by using lapply and apply in R.  For each factor combination a data frame is defined and then the mean and standard deviation for each variable of the respective data frame is calculated.


4. Clean up

The final data sets are cleaned up and two data sets are created:
	a. MeanCD - the mean of each variable by Origin X Subject X Activity.  Each Row of the data frame is the mean value of the column variable.
	b. sdCD - the standard deviation of each variable by Origin X Subject X Activity.  Each Row of the data frame is the standard deviation value of the column variable.