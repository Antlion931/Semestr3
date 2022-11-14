import numpy
import matplotlib.pyplot as plt
import random
import sys
import math
from scipy.integrate import quad
from scipy.optimize import minimize_scalar
from datetime import datetime, timedelta

a = float(sys.argv[1])
b = float(sys.argv[2])

def function(x):
    return eval(sys.argv[3])

M = -minimize_scalar(lambda x: -function(x), bounds=[a,b], method='bounded').fun + 1
steps = 0
previousTime = datetime.now()
lastePercent = round(steps/126250)

for n in range(50, 5050, 50):
    sum = 0

    for _ in range(50):
        
        counter = 0

        for _ in range(n):
            if(round(steps/126250) > lastePercent):
                lastePercent = round(steps/126250)
                timeNow = datetime.now()
                difference = timeNow - previousTime
                previousTime = timeNow
                print(lastePercent,"%, estimated time: " ,(difference * (100 - lastePercent)).seconds," seconds" , end="     \r")
            x = a + (b-a) * random.random()
            steps += 1
            if(M * random.random() <= function(x)):
                counter = counter + 1
        plt.plot(n, (counter/n)*(b-a)*M, 'o', color = 'blue', markersize=2)
        sum += (counter/n)*(b-a)*M
    plt.plot(n, sum/50,'o', color = 'red', markersize = 4)
xpoints = numpy.array([50, 5000])
answer, error = quad(function, a, b)
ypoints = numpy.array([answer, answer])
plt.plot(xpoints, ypoints, color = 'green', linewidth = 4)

plt.show()




