#!/bin/bash
path_root='iphone12_calibration'
pathImage="${path_root}/both"

# video capture parameter
left_addr='' # can using video dir
right_addr='' # also
image_format='png'

# frame timestamp info
left_timestamp_file=''
right_timestamp_file=''

# left camera parameters
prefixImageLeft='left'
pathLeftYML="${path_root}/left.yml"

# right camera parameters
prefixImageRight='right'
pathRightYML="${path_root}/right.yml"

# chessboard parameters
squareSize='' # m
width='' # number of column corner 
height='' # number of row corner

# stereo calibration parameters
pathStereoYML="${path_root}/stereo.yml"

# capture chessboard
echo "Launching capture chessboard"
python3 splitter.py "$path_root" "$left_addr" "$right_addr" "$left_timestamp_file" "$right_timestamp_file"


# left cam calibration
echo "Launching left single cam calibration"
python3 single_camera_calibration.py --image_dir "$pathImage" --image_format "$image_format" --prefix "$prefixImageLeft"\
 --square_size "$squareSize" --width "$width" --height "$height" --save_file "$pathLeftYML"

# right cam calibration
echo "Launching right single cam calibration"
python3 single_camera_calibration.py --image_dir "$pathImage" --image_format "$image_format" --prefix "$prefixImageRight"\
 --square_size "$squareSize" --width "$width" --height "$height" --save_file "$pathRightYML"

# stere cam calibration
echo "Launching stereo cam calibration"
python3 stereo_camera_calibration.py --left_file "$pathLeftYML" --right_file "$pathRightYML" --left_prefix "$prefixImageLeft"\
 --right_prefix "$prefixImageRight" --left_dir "$pathImage" --right_dir "$pathImage" --image_format "$image_format"\
 --width "$width" --height "$height" --square_size "$squareSize" --save_file "$pathStereoYML"
