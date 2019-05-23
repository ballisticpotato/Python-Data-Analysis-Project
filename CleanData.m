close all
clear
clc

%%
% This script loads in the main data and processes it to remove locations
% outside the contiguous United States. It then saves this data to an excel
% spreadsheet.

%% Read in main data
[num, text, raw] = xlsread('UpdatedAirlineData - Readable.xlsx');

%% Get Relevant Fields
delayCt = num(:,4);
arrivCt = num(:,5);
airport = text(2:end,2);
states = text(2:end, 3);
lat = num(:,7);
long = -num(:,end);
months = num(:,1);

%% Remove Virgin Islands, Guam, Puerto Rico, and TT, Hawaii, Alaska from Calculation
removeMask = strcmpi('VI',states) | strcmpi('TT',states) | ...
    strcmpi('PR',states) | strcmpi('AK',states) | strcmpi('GU',states);
removeMask = removeMask | strcmpi('HI', states);
removeMask = [false; removeMask];
trimmedData = raw(~removeMask,:);
xlswrite('UpdatedAirlineData - Readable Trimmed.xlsx', trimmedData);
