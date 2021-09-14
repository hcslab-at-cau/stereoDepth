import numpy as np
import cv2
import glob
import argparse
import sys

# Set the values for your cameras


def main():
    i = 0
    if len(sys.argv) < 6:
        print("Usage ./program_name dir leftsource rightsource leftFrameFile rightFrameFile")
        sys.exit(1)
    
    capL = cv2.VideoCapture(sys.argv[2])
    capR = cv2.VideoCapture(sys.argv[3])

    if (capL.grab() and capR.grab()):
        _, leftFrame = capL.retrieve()
    

    left_time = []
    with open(sys.argv[4], 'r') as f:
        f.readline()
        f.readline()
        while True:
            data = f.readline()
            if not data : break
            data = data.split(',')
            time = float(data[0].strip())
            left_time.append(time)
    
    right_time = []
    with open(sys.argv[5], 'r') as f:
        f.readline()
        while True:
            data = f.readline()
            if not data : break
            data = data.split(',')
            time = float(data[0].strip())
            right_time.append(time)

    total_timestamp = []
    for i in range (0, len(left_time)):
        time = (left_time[i] + right_time[i]) / 2.0
        total_timestamp.append(time)
    f = open(sys.argv[1] + "/timeStamp.txt", 'w')
    for i in range(0, len(total_timestamp)):
        if not (capL.grab() and capR.grab()):
            print("No more frames")
            break

        _, leftFrame = capL.retrieve()
        _, rightFrame = capR.retrieve()

        leftFrame = cv2.cvtColor(leftFrame, cv2.COLOR_BGR2GRAY)
        rightFrame = cv2.cvtColor(rightFrame, cv2.COLOR_BGR2GRAY)

        cv2.imwrite(sys.argv[1] + "/mav0/cam0/data/" +str(total_timestamp[i])+".png", leftFrame )
        cv2.imwrite(sys.argv[1]+ "/mav0/cam1/data/" + str(total_timestamp[i])+ ".png" , rightFrame)
        f.write(str(total_timestamp[i]) + "\n")

    capL.release()
    capR.release()
    f.close()

if __name__ == '__main__':
    main()