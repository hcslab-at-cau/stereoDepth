import numpy as np
import cv2
import glob
import argparse
import sys

# Set the values for your cameras


def main():
    i = 0
    if len(sys.argv) < 5:
        print("Usage ./program_name dir start_timestamp leftsource rightsource")
        sys.exit(1)
    
    capL = cv2.VideoCapture(sys.argv[3])
    capR = cv2.VideoCapture(sys.argv[4])

    
    if (capL.grab() and capR.grab()):
        _, leftFrame = capL.retrieve()
        _, rightFrame = capR.retrieve()
        _, rightFrame = capR.retrieve()
    i = int(sys.argv[2])
    f = open(sys.argv[1] + "/timeStamp.txt", 'w')

    while True:
        if not (capL.grab() and capR.grab()):
            print("No more frames")
            break

        _, leftFrame = capL.retrieve()
        _, rightFrame = capR.retrieve()

        cv2.imwrite(sys.argv[1] + "/mav0/cam0/" +str(i)+".png", leftFrame )
        cv2.imwrite(sys.argv[1]+ "/mav0/cam1/" + str(i)+ ".png" , rightFrame)
        f.write(str(i) + "\n")
        i += 1 

    capL.release()
    capR.release()
    f.close()

if __name__ == '__main__':
    main()