library(dplyr)
library(stringi)

## Directory to store the data
data_dir <- "data"

## Function tha accomplished the requirements of the week 4 assigment for "Getting and clearing data" course
## Returns:
##  The tidy data set described in point 5
run_analysis <- function(){
    ## The actual date
    date <- Sys.Date()
    ## The URL containing the data
    download_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
    ## The name og the zip file
    zip_file <- file.path(data_dir,paste0("project_",date,".zip"))
    ## The name of the file containing the training set features
    train_data_file <- file.path(data_dir,"UCI HAR Dataset","train","X_train.txt")
    ## The name of the file containing the test set features
    test_data_file <- file.path(data_dir,"UCI HAR Dataset","test","X_test.txt")
    ## The name of the file containing the training set labels
    train_labels_file <- file.path(data_dir,"UCI HAR Dataset","train","y_train.txt")
    ## The name of the file containing the test set labels
    test_labels_file <- file.path(data_dir,"UCI HAR Dataset","test","y_test.txt")
    ## The name of the file containing the training set subjects
    train_subject_file <- file.path(data_dir,"UCI HAR Dataset","train","subject_train.txt")
    ## The name of the file containing the test set subjects
    test_subject_file <- file.path(data_dir,"UCI HAR Dataset","test","subject_test.txt")
    ## Creation of the working environment
    if(!file.exists(data_dir)){dir.create(data_dir)}
    if(!file.exists(zip_file)){
        download.file(download_url, zip_file)
        unzip(zip_file,exdir = data_dir)    
    }
    ## Read variable names
    names <- read_col_names()
    ## Read datasets files
    print("Reading train features ...")
    train_dataset <- read.fwf(train_data_file, widths = rep(16, times=561), colClasses="numeric", col.names = names)
    print("Reading test features ...")
    test_dataset <- read.fwf(test_data_file, widths = rep(16, times=561), colClasses="numeric", col.names = names)
    print("Reading train labels ...")
    train_labels <- read.csv(train_labels_file, header = FALSE, colClasses="numeric", col.names = "activity")
    print("Reading test labels ...")
    test_labels <- read.csv(test_labels_file, header = FALSE, colClasses="numeric", col.names = "activity")
    print("Reading train subjects ...")
    train_subjects <- read.csv(train_subject_file, header = FALSE, colClasses="numeric", col.names = "subject")
    print("Reading test subjects ...")
    test_subjects <- read.csv(test_subject_file, header = FALSE, colClasses="numeric", col.names = "subject")
    ## Merge the two datasets (Point 1)
    data <-merge(train_dataset, test_dataset, train_labels, test_labels, train_subjects, test_subjects)
    ## Get the variables related to means and stds (Point 2)
    data <- get_mean_and_dev_features(data)
    ## Rename the column appropriately (Point 4) 
    data <- rename_variables(data)
    ## Substitute the activity codes with the corrisponding activity labels (Point 3)
    data <- substitute_activity_values(data)
    ## Calculate the average of each variable for each activity and each subject (Point 5)
    means <- calculate_means(data)
}

## This function merges together the the features, the labels and the subjects observations
## from train and test datasets
##
## Args:
##  train_dataset: data frame holding the train features
##  test_dataset: data frame holding the test features
##  train_labels: data frame holding the train labels
##  test_labels: data frame holding the test labels
##  train_subjects: data frame holding the train subjects
##  test_subjects: data frame holding the test subjects
## Returns:
##  The merged data set
merge <- function(train_dataset, test_dataset, train_labels, test_labels, train_subjects, test_subjects){
    ## Append the labels of train and test sets
    labels <- rbind(train_labels, test_labels)
    ## Append the labels of train and test subjects
    subjects <- rbind(train_subjects, test_subjects)
    ## Append the train and test datasets
    dataset <- rbind(train_dataset, test_dataset)
    ## Attach the labels variables to the features dataset
    dataset <- cbind(subjects,dataset, labels)
}

## This function reads and returns the names of the features from the "features.txt" file
##
## Returns:
##  A vector containing the names of the features in the expected order
read_col_names <- function(){
    ## File containing the variable name
    name_file <- file.path(data_dir,"UCI HAR Dataset","features.txt")
    ## Read the data from the file
    names <- read.delim(name_file,sep = " ",header = FALSE)
    ## Get the names from the retrieved data
    names <- names[,2]
}

## This function get a subset of the provided data set containing the variables of the means and std
## calculations with the labels and the subjects
##
## Args:
##  x: the datas set to subset
## Returns:
##  A subset containing the desired variables
get_mean_and_dev_features <- function(x){
    ## Pattern of the features of the dataset to isolate
    ## It contains the patterns for the mean and std columns and also the names of the activity and subject 
    ## columns
    pattern <- ".+.mean\\.\\..*|.+.std\\.\\..*|^activity$|^subject$"
    ## Get the names using the patterns
    res <- grep(pattern,names(x))
    ## Subset the dataset with the desired features
    x[,res]
}

## This function rename the column name of the provided data set to make them suitable for
## a tidy data set
##
## Args:
##  x: the data set to be changed
## Returns:
##  The modified data set
rename_variables <- function(x){
    ## The names of the columns present some dot (.) characters to substitute the characters
    ## read from the names file that was not allowed in a variable name. 
    ## The following line will delete them
    colnames(x) <- gsub("\\.","",names(x))
    ## Transform every chaacter to lower case
    colnames(x) <- tolower(names(x))
    ## Return the modified data set
    x
}

## This function replace the vales in the activity column with the corrisponding labels read from 
##"activity_labels.txt" file.
##
## Args:
##  x: the data set to modify
## Returns:
##  the modified data set
substitute_activity_values <- function(x){
    ## The file containing the descriptive names of the labels
    labels_file <- file.path(data_dir,"UCI HAR Dataset","activity_labels.txt")
    ## Read the content from the activity labels file
    labels <- read.delim(labels_file, sep = " ", header = FALSE)[2]
    ## Retrieve the descriptive values
    labels <- labels[,1]
    labels <- as.character(labels)
    ## Substitute the codes of the labels with the names
    x$activity <- labels[x$activity]
    ## Return the modified dataset
    x

}

## This function creates a data set with the average of each variable
## for each activity and each subject.
##
## Args:
##  x: the dataset containing the source data
## Returns:
##  The desired data set
calculate_means <- function(x){
    ## Group the dataset by the subject and ther activity columns
    means <- group_by(x,subject, activity)
    ## Calculate the means of the means and dev columns
    means <- summarise_all(means,mean)
}



