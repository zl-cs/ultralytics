# Environment (NX-1)
```
# LOCAL ENVIRONMENT INSTALL
cd ~/code
git clone git@github.com:zl-cs/ultralytics.git
cd ultralytics
pip3 install ultralytics
```
# Some useful command
- default config: 'yolo cfg' or 'ultralytics/yolo/cfg/default.yaml'

# export command
```
# lion-11
yolo export model=yolov8n.pt format=onnx imgsz=(960,640) half=true 
# nx-1
cd 
/usr/src/tensorrt/bin/trtexec --onnx=yolov8n.onnx --saveEngine=yolov8n.plan --workspace=1024 --fp16
# nano-2
cd /home/nvidia/software/otherdisk
/usr/src/tensorrt/bin/trtexec --onnx=yolov8n.onnx --saveEngine=yolov8n.plan --workspace=1024 --fp16 --verbose
``` 

# Val command
```
yolo detect val model=runs/detect/yolov8n_320p_train/weights/best.pt data=coco.yaml device=0
```