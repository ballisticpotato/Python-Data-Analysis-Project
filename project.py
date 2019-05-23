from sklearn.kernel_ridge import KernelRidge
import numpy as np
import csv

rawData = np.zeros((342,3))

with open('Processed Time-Invariant Data.csv', 'rb') as f:
    reader = csv.reader(f)
    labels = reader.next()

    i = 0
    for row in reader:
        for j in range(3):
            rawData[i,j] = float(row[j])
        i = i+1

kr = KernelRidge(alpha=1, kernel='rbf', gamma=None, degree=3, coef0=1, kernel_params=None)
kr.fit(rawData[:,0:3],rawData[:,2])

samplePoints = np.zeros((6000,3))
with open('Sample Points.csv', 'rb') as dat:
    readDat = csv.reader(dat)
    i = 0
    for row in readDat:
        for j in range(2):
            samplePoints[i,j] = float(row[j])
        i = i+1

predictedPoints = kr.predict(samplePoints)

samplePoints[:,2] = predictedPoints

with open('Output Data.csv', 'wb') as output:
    writer = csv.writer(output, delimiter=',')
    for row in samplePoints:
        writer.writerow(row)
