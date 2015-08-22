# Getting and Cleaning Data Project
In this repo, three files are included: run_analysis.R (the main code), README.md (overview of all the files in this repo), CodeBook.md (data background,  all the variable meanings and data transformation)

In the R code, I frequently call setwd() to change working directory because the data are stored in different folders, when you run the code please change all the setwd() to your exact directory

The code is flowing in the following procedure:
============
1.download and unzip the raw data
2.read in all the data tables
3.merge training data an test data
4.extract data variables we need
5.assign descriptive names to variables
6.futher data aggregation

further description of what does the code mean, please see the last session in CodeBook.md and the comment in run_analysis.R

