# Stereo calibration and disparity creation



This project is a basis for stereo vision.  After calibration process, you can try to get disparity map and start your own project. You can check [my blog](https://medium.com/@aliyasineser) if you are new to stereo vision. I wrote about what is stereo vision and how it works briefly. 

## Usage

### Calibration 하는 방법

*중요 카메라는 반드시 가로로 놓여있어야 한다.

calibration.sh 파일에 변수들의 값을 우선 수정해야 함.

특히 left_addr과 right_addr은 웹캠 주소가 아니라 비디오 파일일 수 있음

수정한 다음.

```bash
chmod +x calibration.sh
sh calibration.sh
```
적절한 RMSE가 나올때까지 수행하면 된다.

또, 마지막에 나오는 green 라인이 왼쪽과 오른쪽 사진에서 같은 점을 지나면 옳게 캘리브레이션이 된 것

### depth map 확인

run_depth.sh 파일에 변수들의 값을 수정해야 함.

캘리브레이션과 마찬가지로 dir_left와 dir_right는 비디오파일일 수 있음

수정한 다음
```bash
chmod +x run_depth.sh
sh run_depth.sh
```

