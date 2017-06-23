README - Human Activity Recognition Using Smartphones Dataset

A Human Activity Recognition experiments were carried out with a group
of 30 volunteers within an age bracket of 19-48 years. Each person
performed six activities (WALKING, WALKING\_UPSTAIRS,
WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone
(Samsung Galaxy S II) on the waist.

1.  There was a group of group of 30 volunteers known in this context
    as Subjects.

2.  Each person performed six activities (WALKING, WALKING\_UPSTAIRS,
    WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING). Hence there will
    6 \* 30 rows for a total combination of SUBJECT and ACTIVITY = (180)

3.  In preparing the original raw data to be a tidy dataset, I defined
    Tidy Data as a data which has, each attribute or variable in one
    column and each observation on one row. Therefore in this Human
    Activity Recognition I prepared a Tidy Dataset where each SUBJECT
    will go into one column, ACTIVITY into one column.

4.  I subsequently put each measurement in one distinct column with
    their vector values going to the rows under each of them.

5.  From the original README file, the 'activity\_labels.txt' links the
    class labels with their activity name. Hence, “Y\_test.txt” and
    “Y\_train.txt” will be named with respect to the to the activity
    labels which are found in the 'activity\_labels.txt'.

6.  I extracted the feature names from the features.txt file and
    re-named the “X\_train.txt” and “Y\_train.txt” variables with
    descriptive variable names which are much clearer than the original
    raw variables names. These new variable names are found in the
    “CodeBook.md” file with a short description of what each variable
    denotes and how they were calculated as well as their unit of
    measurement in applicable

7.  I merged the “X\_train.txt” and “Y\_train.txt” with rbind(row bind).
    The dimension of the resulting data.frame = 10299 rows and 563
    columns

8.  In Extracts only the measurements on the mean and standard deviation
    for each measurement, I extracted all the column names that included
    the word “mean” or “std” – (std denotes standard deviation). I left
    out columns that had “meanFreq” in their names as “mean frequency”
    is the weighted average as mentioned in features\_info and not
    actually a base mean as the others.

9.  I further removed the “dots” in the variable names as well as
    the parentheses. In effect, the original variable names have been
    appropriately labelled with descriptive variable names.

10. All this transformations are done with “run\_analysis.R” script

11. A tidy data set was created with write.table() using row.name=FALSE
    and it is called “tidy\_data.txt”

How the “run\_analysis.R” script works

1.  Assuming in you are in your working directory.

2.  Put all the Samsung data including all its file structures in your
    current working directory

3.  Hence you should have something like this: WorkingDirectory -&gt;
    UCI HAR Dataset

4.  And the UCI HAR Dataset will have all its original subdirectories
    and files .eg UCI HAR Dataset -&gt;test or UCI HAR Dataset
    -&gt;train , etc

5.  Put the “run\_analysis.R” script also in your working directory, at
    the same level as the UCI HAR Dataset. Hence you should have
    something like WorkingDirectory -&gt; run\_analysis.R

6.  Using R-Studio open a new editor and source the run\_analysis.R
    script using the code source('run\_analysis.R').

7.  This will run the run\_analysis.R script and create a tidy data into
    your current working directory as a result.

8.  To read the data set which is created by the script, use this code:

    read\_data &lt;- read.table(file\_path, header = TRUE)

    View(read\_data)

9.  This should read and display the tidy dataset


