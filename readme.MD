# Stereo calibration and disparity creation



This project is a basis for stereo vision.  After calibration process, you can try to get disparity map and start your own project. You can check [my blog](https://medium.com/@aliyasineser) if you are new to stereo vision. I wrote about what is stereo vision and how it works briefly. 

## Usage

### Calibration 쉬운방법 추가

calibration.sh 파일에 변수들의 값을 적절하게 수정한 다음

```bash
chmod +x calibration.sh
sh calibration.sh
```

### Get images from single camera

Don't forget to create directory with mkdir and set your cameras in the code. Example usage:

```bash
python get_images.py directory 0
```

### Get stereo images

Don't forget to set your cameras. Check if the right is right and left is left. Example usage:

```bash
python getStereoImages.py directory 0
```

### Split concat images

This code is for fixed stereo set. There are some cameras that give you the most possible sync. They are taking the images and concat with hardware. You see that you have only one camera but actually you are getting two images as one. So we need seperation before proceed. Get images as single camera and run this code. Example usage:

```bash
python grabSeperate.py directory savedDirectory prefixOfImages
```

### Disparity map

Example usage:

```bash
python stereo_depth.py --calibration_file data\stereo_cam.yml --left_source data\left_1541067450.avi --right_source data\right_1541067450.avi --is_real_time 0

```


