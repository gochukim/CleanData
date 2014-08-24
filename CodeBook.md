This script "CodeBook.md"" describes the variables, the data, and any 
transformations or work that was performed to clean up the data

=========

# Source Files / Data
=========
Source data - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The source files we use to create the tidy data set from the extracted data archive are:

features_info.txt - Shows information about the variables used on the feature vector

features.txt - Measurements on the mean and standard deviation for each measurement

activity_labels.txt - Links the class labels with their activity name

train/X_train.txt - Training set

train/y_train.txt - Training labels

train/subject_train.txt - Identifies the train subject who performed the activity for each window sample

test/X_test.txt - Testing set

test/y_test.txt - Testing labels

test/subject_test.txt - Identifies the test subject who performed the activity for each window sample

merged_clean_data.txt - Data that's been cleansed and merged

data_set_with_averages.txt - The final tidy data set with averages


# Variables
=========
train_temp - Temporary training data set

test_temp - Temporart testing data set

merge_x - Merges the training data set and the testing data set

merge_s - Merges the training and testing subject data

merge_y - Merges the training label and the testing label data

features - Reads the table "features.txt"

extract_data - Extraction of standard deviation

Activities - Reads the table "activity_labels.txt"

cleaned - Clean data set with descriptive activity name labels

unique_subject - identifies the unique subject data

length_subject - identifies the length of subjects

length_activities - identifies the length of activities

number_column - identifies the number of columns

new_data - new tidy data set with each activity and each subject

new_average - new tidy data set with the average of each variable for each activity and each subject


# Transformations
=========
1) Merges the training and test sets to create one data set using: 

train/X_train.txt with test/X_test.txt - the result is a 10299 x 561 data frame, as in the original description ("Number of Instances: 10299" and "Number of Attributes: 561")

train/subject_train.txt with test/subject_test.txt - the result is a 10299 x 1 data frame with subject IDs

train/y_train.txt with test/y_test.txt - the result is also a 10299 x 1 data frame with activity IDs

2) Reads file features.txt and extracts only the measurements on the mean and standard deviation for each measurement. The result is a 10299 x 66 data frame, because only 66 out of 561 attributes are measurements on the mean and standard deviation. All measurements appear to be floating point numbers in the range (-1, 1).

3) Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:

walking

walkingupstairs

walkingdownstairs

sitting

standing

laying


4) The script also appropriately labels the data set with descriptive names: 
all feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed.

Then it merges the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. The result is saved as merged_clean_data.txt, a 10299x68 data frame such that the first column contains subject IDs, the second column activity names, and the last 66 columns are measurements. Subject IDs are integers between 1 and 30 inclusive. Names of the attributes are similar to the following:

tbodyacc-mean-x

tbodyacc-mean-y

tbodyacc-mean-z

tbodyacc-std-x

tbodyacc-std-y

tbodyacc-std-z

tgravityacc-mean-x

tgravityacc-mean-y


5) Finally, the script creates a second, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as data_set_with_averages.txt, a 180x68 data frame, where as before, the first column contains subject IDs, the second column contains activity names (see below), and then the averages for each of the 66 attributes are in columns 3 through 68. There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
