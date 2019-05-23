tic
close all
clear
clc

%% Load Data
[num, text, ~] = xlsread('UpdatedAirlineData - Readable Trimmed.xlsx');

%% Get Relevant Fields
delayCt = num(:,5);
arrivCt = num(:,4);
airports = text(2:end,2);
states = text(2:end, 3);
locations = num(:,7:8);
months = num(:,1);

%% Get Airports Codes
[airportCodes, codeInd] = unique(airports);
numAirports = length(airportCodes);
airportCoords = locations(codeInd,:);

%% Calculate the Proportion of Flights Delayed for each airport every month
delayAirportOverall = zeros(numAirports,1);
delayAirportTime = zeros(numAirports,12);
for i = 1:numAirports
    curAirport = airportCodes{i};        
    airportLoc = strcmpi(curAirport, airports);
    totArriv = 0;
    totDelay = 0;
    for curMonth = 1:12
        monthLoc = months == curMonth;
        dataLoc = airportLoc & monthLoc;
        curDelay = sum(delayCt(dataLoc), 'omitnan');
        curArriv = sum(arrivCt(dataLoc), 'omitnan');
        totArriv = totArriv + curArriv;
        totDelay = totDelay + curDelay;
        delayAirportTime(i, curMonth) = curDelay/curArriv;      %P(delay|Airport & Month);
    end
    delayAirportOverall(i) = totDelay ./ totArriv;              %P(delay|Airport);    
end

%% Remove garbage data and set to zero
delayAirportTime(isnan(delayAirportTime)) = 0;
delayAirportOverall(isnan(delayAirportOverall)) = 0;

% Clean up workspace
clearvars -except delayAirportOverall delayAirportTime airportCoords

% Write Time Invariant data to csv file
output = [-airportCoords(:,2) airportCoords(:,1) delayAirportOverall];
csvwrite('Processed Time-Invariant Data.csv',output)

% Write Time Dependent data to csv file
airportCoords = repmat(airportCoords,12,1);
time = 1:12;
timemat = repmat(time, 342,1);
timemat = timemat(:);
timeData = [timemat -airportCoords(:,2) airportCoords(:,1) delayAirportTime(:)];
csvwrite('Processed Time Dependent Data.csv', timeData);
toc