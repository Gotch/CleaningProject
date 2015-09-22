How run_analysis.R Works
========================

run_analysis is a function of the input 'dir'
* the input directory should end in "/UCI HAR Dataset"


1. The function reads all the necessary tables
2. The function filters out any measurement that is not for mean or standard deviation 
3. The function renames the columns in the result dataset to be more descriptive
4. The function adds descriptive columns for activity performed and subject id to the results datasets
5. The function merges 'test' and 'training' data sets.
6. The funciton summarizes the means of the data measurements by activity performed and subject id.
7. The function writes the summarized results data set to the working directory.
