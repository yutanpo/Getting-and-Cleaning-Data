Getting and Cleaning Data (Peer Assessments): CODEBOOK
============================================

The R script (run_analysis.R) clean up the data as follows:

(Step1)
- Merge the below training data and the test data to create one data set:
--  "train/X_train.txt" and "test/X_test.txt": Number of Instances:10299 / Number of Attributes:561
--  "train/subject_train.txt" and "test/subject_test.txt": subject IDs:10299
--  "train/y_train.txt and "test/y_test.txt": activity IDs:10299

[Variables]
- tmp1, tmp2: Temporaty tables to merge the data.
- X: Merged table from "train/X_train.txt" and "test/X_test.txt".
- S: Merged table from "train/subject_train.txt" and "test/subject_test.txt".
- Y: Merged table from "train/y_train.txt and "test/y_test.txt".

(Step2)
- Read "features.txt" to extract only the measurements on the mean and standard deviation for each measurement.
* The result is a 10299x66 data(66 out of 561 attributes are measurements on the mean and standard deviation).
* The 66 data are tbodyacc-mean-x, tbodyacc-mean-y, tbodyacc-mean-z, tbodyacc-std-x, tbodyacc-std-y, tbodyacc-std-z, etc.

[Variables]
- feature: Table of "features.txt".
- index: Table to store index of the measurements on the mean and standard deviation

(Step3)
- Read "activity_labels.txt" to label activity names in the data.
* The activity names are walking, walkingupstairs, walkingdownstairs, sitting, standing and laying.

[Variables]
- activity: Table of "activity_labels.txt"

(Step4)
- Label the data set with descriptive names based on the result of previous steps.
* The result is a 10299x68 data(The first column contains subject IDs, the second column activity names, and the last 66 columns are measurements).

(Step5)
- Make an independent tidy data set with the average of each measurement for each activity and each subject.
* The result is saved as "tidydataset.txt"
* The data contains 180x68 data: the first column contains subject IDs, the second column contains activity names, and the averages for each of the 66 attributes are in columns 3 to 68. There are 30 subjects and 6 activities, therefore 180 rows in the data set.

[Variables]
- uniqueSubject: Table to store distinctive names of subjects
- numSubject: Number of uniqueSubject
- numActivity: Table to store distinctive names of activities
- mtable: Merged tables from tables in Step1 (X,S,Y)
- numCol: Dimension of mtable
- result: Table to store final result