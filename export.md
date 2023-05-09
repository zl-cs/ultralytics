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

# export onnx model from pt model
- Download .pt models to pretrained_model folder
- Export
    - batch export (onnx models are saved in pretrained_model/onnx_model)
    ```
    bash export.sh
    ```
    - single export
    ```
    # lion-11
    yolo export model=yolov8n.pt format=onnx imgsz=(960,640) half=true 
    yolo export model=pretrained_model/yolov8n.pt format=onnx imgsz=640 half=true 

    ### other config params and their default value
    #  imgsz	640	    image size as scalar or (h, w) list, i.e. (640, 480)
    #  half	    False	FP16 quantization
    #  dynamic	False	ONNX/TensorRT: dynamic axes
    #  simplify	False	ONNX/TensorRT: simplify model
    #  opset	None	ONNX: opset version (optional, defaults to latest) 
    ```
- Note: Next, we export onnx to plan at Jetson Nx or Nano device (refer to branch [nx-1](https://github.com/zl-cs/ultralytics/blob/nx-1/export.md) and [nano-2](https://github.com/zl-cs/ultralytics/blob/nano-2/export.md))
    ```
    # nx-1, --minShapes=images:1x3x640x640 --maxShapes=images:10x3x640x640 --optShapes=images:3x3x640x640
    cd 
    /usr/src/tensorrt/bin/trtexec --onnx=yolov8n.onnx --saveEngine=yolov8n.plan --workspace=1024 --inputIOFormats=fp16:chw --outputIOFormats=fp16:chw --fp16
    # nano-2
    cd /home/nvidia/software/otherdisk
    /usr/src/tensorrt/bin/trtexec --onnx=yolov8n.onnx --saveEngine=yolov8n.plan --workspace=1024 --inputIOFormats=fp16:chw --outputIOFormats=fp16:chw --fp16 
    ``` 

