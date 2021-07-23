#!/bin/bash
# left camera parameters
pathImageLeft='iphone11_calibration/videoData/both'
prefixImageLeft='left'
pathLeftYML='iphone11_calibration/left.yml'
leftImageFormat='png'

# right camera parameters
pathImageRight='iphone11_calibration/videoData/both'
prefixImageRight='right'
pathRightYML='iphone11_calibration/right.yml'
rightImageFormat='png'

# chessboard parameters
squareSize='0.024'
width='10'
height='7'

# stereo calibration parameters
stereoImageFormat='png'
pathStereoYML='iphone11_calibration/stereo.yml'


# left cam calibration
echo "Launching left single cam calibration"
python3 single_camera_calibration.py --image_dir "$pathImageLeft" --image_format "$leftImageFormat" --prefix "$prefixImageLeft"\
 --square_size "$squareSize" --width "$width" --height "$height" --save_file "$pathLeftYML"

# right cam calibration
echo "Launching right single cam calibration"
python3 single_camera_calibration.py --image_dir "$pathImageRight" --image_format "$rightImageFormat" --prefix "$prefixImageRight"\
 --square_size "$squareSize" --width "$width" --height "$height" --save_file "$pathRightYML"

# stere cam calibration
echo "Launching stereo cam calibration"
python3 stereo_camera_calibration.py --left_file "$pathLeftYML" --right_file "$pathRightYML" --left_prefix "$prefixImageLeft"\
 --right_prefix "$prefixImageRight" --left_dir "$pathImageLeft" --right_dir "$pathImageRight" --image_format "$stereoImageFormat"\
 --width "$width" --height "$height" --square_size "$squareSize" --save_file "$pathStereoYML"