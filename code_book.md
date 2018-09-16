# Code book

# Introduction.

This dataset is generated to complete the week 4 assigment of the “Getting and cleaning data” course at Coursera.

## Study design

### Original data set

This dataset derived from the "Human Activity Recognition Using Smartphones Data Set" dataset you can find here --> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
That dataset containes signar readings from the accelerometer and the gyroscope of a Samsung Galaxy S II mobile. For details about the experiments and the nature of the signals please refer to the original dataset web page and files.

### Data analysis

The data set I generated from the original one had the pourpose of show the average of all the variables related to means and standard deviation for every subject and every activity.
This goal was achieved by the following steps:

1 - Merges the training and the test sets to create one data set.

2 - Extracts only the measurements on the mean and standard deviation for each measurement.

3 - Uses descriptive activity names to name the activities in the data set

4 - Appropriately labels the data set with descriptive variable names.

5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


So I created a new tidy dataset taking only the average (mean) and standard deviation (std) variables from the original dataset along with the subject code and the activity code.
After that I calculate the mean of every variable for every subject and every activity.
I couldn't substitute the values from the subject values because I didn't have a reference table, but I could change the activity code using the following table:


1 -> WALKING

2 -> WALKING_UPSTAIRS

3 -> WALKING_DOWNSTAIRS

4 -> SITTING

5 -> STANDING

6 -> LAYING

The steps performed to generate the dataset are implemented and described in the run_analysis.R script.


## Code book

Here are the names and the meaning of the dataset variables. 


The code of the subject who performed the experiment. It is a category number
subject


The activity performed by the subject during the experiment. It is a category label
activity


### Time domain signals at 50Hz. They are continues values.


**Accelerator body component signals mean along the three axis**

tbodyaccmeanx

tbodyaccmeany      

tbodyaccmeanz


**Accelerator body component signals standard deviation mean along the three axis**

tbodyaccstdx

tbodyaccstdy

tbodyaccstdz


**Accelerator gravity component signals mean along the three axis**

tgravityaccmeanx

tgravityaccmeany

tgravityaccmeanz


**Accelerator gravity component signals standard deviation mean along the three axis**

tgravityaccstdx  

tgravityaccstdy

tgravityaccstdz


**Accelerator body component Jerk signals mean along the three axis**

tbodyaccjerkmeanx
tbodyaccjerkmeany       
tbodyaccjerkmeanz

**Accelerator body component Jerk signals standard deviation mean along the three axis**
tbodyaccjerkstdx

tbodyaccjerkstdy

tbodyaccjerkstdz


**Gyroscope signals mean along the three axis**

tbodygyromeanx

tbodygyromeany

tbodygyromeanz


**Gyroscope signals standard deviation mean along the three axis**

tbodygyrostdx           

tbodygyrostdy

tbodygyrostdz


**Gyroscope Jerk signals mean along the three axis**

tbodygyrojerkmeanx

tbodygyrojerkmeany  

tbodygyrojerkmeanz


**Gyroscope Jerk signals standard deviation mean along the three axis**

tbodygyrojerkstdx

tbodygyrojerkstdy

tbodygyrojerkstdz


**Accelerator body component signals magnitude mean**

tbodyaccmagmean


**Accelerator body component signals magnitude standard deviation mean**

tbodyaccmagstd


**Accelerator gravity component signals magnitude mean**

tgravityaccmagmean


**Accelerator gravity component signals magnitude standard deviation mean**

tgravityaccmagstd       


**Accelerator body component Jerk signals magnitute mean**

tbodyaccjerkmagmean


**Accelerator body component Jerk signals magnitude standard deviation mean**

tbodyaccjerkmagstd


**Gyroscope signals magnitude mean**

tbodygyromagmean


**Gyroscope signals magnitude standard deviation mean**

tbodygyromagstd


**Gyroscope Jerk signals magnitude mean**

tbodygyrojerkmagmean


**Gyroscope Jerk signals magnitude standard deviation mean**

tbodygyrojerkmagstd



### Fast Fourier transform. They are continues values.

**Accelerator body component signals mean along the three axis**

fbodyaccmeanx

fbodyaccmeany 

fbodyaccmeanz


**Accelerator body component signals standard deviation mean along the three axis**

fbodyaccstdx

fbodyaccstdy

fbodyaccstdz


**Accelerator body component Jerk signals mean along the three axis**

fbodyaccjerkmeanx

fbodyaccjerkmeany

fbodyaccjerkmeanz


**Accelerator body component Jerk signals standard deviation mean along the three axis**

fbodyaccjerkstdx 

fbodyaccjerkstdy

fbodyaccjerkstdz


**Gyroscope signals mean along the three axis**

fbodygyromeanx

fbodygyromeany  

fbodygyromeanz


**Gyroscope signals standard deviation mean along the three axis**

fbodygyrostdx

fbodygyrostdy

fbodygyrostdz 


**Accelerator body component signals magnitude mean**

fbodyaccmagmean


**Accelerator body component signals magnitude standard deviation mean**

fbodyaccmagstd


**Accelerator body component Jerk signals magnitute mean**

fbodybodyaccjerkmagmean


**Accelerator body component Jerk signals magnitute standard deviation mean**

fbodybodyaccjerkmagstd  


**Gyroscope signals magnitude mean**

fbodybodygyromagmean


**Gyroscope signals magnitude standard deviation mean**

fbodybodygyromagstd


**Gyroscope Jerk signals magnitude mean**

fbodybodygyrojerkmagmean


**Gyroscope Jerk signals magnitude standard deviation mean**

fbodybodygyrojerkmagstd 


