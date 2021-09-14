#!/bin/bash
path_root='iphone12_calibration'
pathImage="${path_root}/both"
# realtime capture params
left_addr='http://165.194.27.184:10003' # can using video dir
right_addr='http://165.194.27.184:10004' # also
image_format='png'

# left camera parameters
prefixImageLeft='left'
pathLeftYML="${path_root}/left.yml"

# right camera parameters
prefixImageRight='right'
pathRightYML="${path_root}/right.yml"

# chessboard parameters
squareSize='0.024'
width='10'
height='7'

# stereo calibration parameters
pathStereoYML="${path_root}/stereo.yml"

# capture chessboard
echo "Launching capture chessboard"
python3 realtime_cap.py --left_source "$left_addr" --right_source "$right_addr" --left_prefix "$prefixImageLeft" --right_prefix "$prefixImageRight"\
 --image_dir "$path_root" --image_format "$image_format"


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
