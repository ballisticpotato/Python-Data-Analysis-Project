# Python-Data-Analysis-Project
School project that used both MATLAB and Python to analyze and visualize flight delays in the contiguous US

CleanData.m - Code used to clean up the data after selecting only the columns we needed. It's used to remove data for outside the contiguous United States.

Project.m - Code used to calculate the proportion of delays at each airport for each month and for the entire year. It works on the data that has only information for the contiguous United States. It outputs two csv files with all of the processed data.

mapsUS.m - Generates test point grid, 6000 points across the United States.

Project.py - Generates the model for the entire year using Kernel Ridge Regression and then predicts the delay at point we don't have data. It then outputs the results in a csv file.

Project2.py - Generates the model for the time dependent data using Kernel Ridge Regression and then outputs 12 different csv files with the predicted delays at points across the US.

mapUS.m - Two part code. It generates the sample grid of points acros the United States and also plots the visualization of the data across all months. It's slighlty modified to be able to graph the data for the entire year.
