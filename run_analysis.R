# This R script will merge two datasets into one, then prepare tidy data that 
# can be used for further analysis.

# 1) Merges the training and the test sets to create one data set.
train_temp <- read.table("Data/train/X_train.txt")
test_temp <- read.table("Data/test/X_test.txt")
merge_x <- rbind(train_temp, test_temp)
train_temp <- read.table("Data/train/subject_train.txt")
test_temp <- read.table("Data/test/subject_test.txt")
merge_s <- rbind(train_temp, test_temp)
train_temp <- read.table("Data/train/y_train.txt")
test_temp <- read.table("Data/test/y_test.txt")
merge_y <- rbind(train_temp, test_temp)

# 2) Extracts only the measurements on the mean and standard deviation for each 
# measurement.
features <- read.table("Data/features.txt")
extract_date <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
merge_x <- merge_x[, extract_data]
names(merge_x) <- features[extract_data, 2]
names(merge_x) <- gsub("\\(|\\)", "", names(merge_x))
names(merge_x) <- tolower(names(merge_x))  

# 3) Uses descriptive activity names to name the activities in the data set.
activities <- read.table("Data/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
merge_y[,1] = activities[merge_y[,1], 2]
names(merge_y) <- "activity"

# 4) Appropriately labels the data set with descriptive activity names.
names(merge_s) <- "subject"
cleaned <- cbind(merge_s, merge_y, merge_x)
write.table(cleaned, "Data/merged_clean_data.txt")

# 5) Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
unique_subject = unique(merge_s)[,1]
length_subject = length(unique(merge_s)[,1])
length_activities = length(activities[,1])
number_column = dim(cleaned)[2]
new_data = cleaned[1:(length_subject*length_activities), ]
row = 1
for (s in 1:length_subject) {
        for (a in 1:length_activities) {
                new_data[row, 1] = unique_subject[s]
                new_data[row, 2] = activities[a, 2]
                tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
                new_data[row, 3:number_column] <- colMeans(tmp[, 3:number_column])
                row = row+1
        }
}
write.table(new_data, "data_set_with_averages.txt", row.name=FALSE)
new_average <- read.table("data_set_with_averages.txt")

# Dispalys the Final Variables
new_data
new_average