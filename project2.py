from sklearn.kernel_ridge import KernelRidge
from sklearn.grid_search import GridSearchCV
import numpy as np
import csv

rawData = np.zeros((4104,4))

with open('Processed Time Dependent Data.csv', 'rb') as f:
    reader = csv.reader(f)
    labels = reader.next()

    i = 0
    for row in reader:
        for j in range(4):
            rawData[i,j] = float(row[j])
        i = i+1

kr = KernelRidge(alpha=1, kernel='rbf', gamma=None, degree=3, coef0=1, kernel_params=None)
kr.fit(rawData[:,0:3],rawData[:,3])

samplePoints = np.zeros((6000,4))


with open('Sample Points 2.csv', 'rb') as dat:
    readDat = csv.reader(dat)
    i = 0
    for row in readDat:
        for j in range(3):
            samplePoints[i,j] = float(row[j])
        i = i+1


for iterno in range(1,13):

    samplePoints[:,0] = iterno
    predictedPoints = kr.predict(samplePoints[:,0:3])
    samplePoints[:,3] = predictedPoints

    filename = 'Output Data ' + str(iterno) +'.csv'


    with open(filename, 'wb') as output:
        writer = csv.writer(output, delimiter=',')
        for row in samplePoints:
            writer.writerow(row)
