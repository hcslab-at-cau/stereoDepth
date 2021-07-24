#!/bin/bash

dir_left="http://165.194.27.184:10001"
dir_right="http://165.194.27.184:10002"
calibration_file="iphone11_calibration/stereo_calib.yml"

echo "run disparity map" 
python3 stereo_depth.py --calibration_file "$calibration_file" --left_source "$dir_left" --right_source "$dir_right"\
 --is_real_time 0