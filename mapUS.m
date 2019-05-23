close all
clear
clc
load('conus.mat')

latLim = [min(uslat) max(uslat)];
lonLim = [min(uslon) max(uslon)];

numLon = 120;
numLat = 50;

latx = linspace(latLim(1),latLim(2), numLat);
lonx = linspace(lonLim(1),lonLim(2), numLon);

[lonxx, latxx] = meshgrid(lonx, latx);
% graphablePoints = [lonxx(:) latxx(:)];
% csvwrite('Sample Points.csv', graphablePoints)

time = 1:12;
timemat = repmat(time,6000,1);
timemat = timemat(:);

% timeGraphPoints = [timemat repmat(lonxx(:),12,1) repmat(latxx(:),12,1)];

[inside] = inpolygon(lonxx(:),latxx(:),uslon,uslat);

%%
% figure
months = {'Janurary' 'February' 'March' 'April' 'May' 'June' 'July'...
    'August' 'September' 'October' 'November' 'December'};
for i = 1:12
%     figure
    subplot(4,3,i)
    filename = sprintf('C:\\Users\\Jerry\\Google Drive\\GT\\CX 4240\\Project\\Output Data %d.csv', i);
    dat = csvread(filename);
    results = dat(:,4);
    results(~inside) = 0;
    results = reshape(results, 50, 120);
    surf(lonxx, latxx, results,'LineStyle', 'none')
    grid off
    axis equal
    axis off
    title(months{i})
    view(0,90)
end