# Data Source (UCI HAR Dataset)
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# 1. Merges the training and the test sets to create one data set.
tmp1 <- read.table("UCI HAR Dataset/train/X_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/X_test.txt")
X <- rbind(tmp1, tmp2)

tmp1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
S <- rbind(tmp1, tmp2)

tmp1 <- read.table("UCI HAR Dataset/train/y_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/y_test.txt")
Y <- rbind(tmp1, tmp2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
feature <- read.table("UCI HAR Dataset/features.txt")
index <- grep("-mean\\(\\)|-std\\(\\)", feature[, 2])

# 3. Uses descriptive activity names to name the activities in the data set.
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
activity[, 2] = gsub("_", "", tolower(as.character(activity[, 2])))
Y[,1] = activity[Y[,1], 2]

# 4. Appropriately labels the data set with descriptive activity names.
X <- X[, index]
names(X) <- feature[index, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))
names(S) <- "subject"
names(Y) <- "activity"

# 5.From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject.
uniqueSubject = unique(S)[,1]
numSubject = length(unique(S)[,1])
numActivity = length(activity[,1])
mtable <- cbind(S, Y, X)
numCol = dim(mtable)[2]
result = mtable[1:(numSubject*numActivity), ]

row = 1
for (s in 1:numSubject) {
    for (a in 1:numActivity) {
        result[row, 1] = uniqueSubject[s]
        result[row, 2] = activity[a, 2]
        tmp <- mtable[mtable$subject==s & mtable$activity==activity[a, 2], ]
        result[row, 3:numCol] <- colMeans(tmp[, 3:numCol])
        row = row+1
    }
}
write.table(result, file = "tidydataset.txt", row.name = FALSE)
