#! /bin/bash
# conda activate yolov8

ModelPath=./pretrained_model
OnnxModelPath=$ModelPath/onnx_model_seg

if [ ! -d $OnnxModelPath ]; then
    mkdir $OnnxModelPath
fi

model_list="yolov8n-seg yolov8s-seg yolov8m-seg"
# 16_9_re_list="(320,180) (640,360) (960,540) (1280,736) (1920,1088)"
w_list="288 576 864"
h_list="160 320 480"

# 1260 5040 10710 19320 42840
# input shape: (1,3,h,w)
# ((1, 116, 945), (1, 32, 40, 72))
# ((1, 116, 3780), (1, 32, 80, 144)) 
# output shape: ((1, 116, 8505), (1, 32, 120, 216))
# 84 = 80 classes + 4 position coordinates
for model in $model_list
do
    for h in $h_list
    do
        # 计算(re/16*9)/32
        re=$[((($h/9)*16+32-1)/32)*32]

        echo $re,$h

        echo "==================== $model.pt with $re*$h to $model.onnx ===================="
        yolo export model=$ModelPath/$model.pt format=onnx imgsz=$h,$re half=true 
        mv $ModelPath/$model.onnx $OnnxModelPath/$model\_$h.onnx
    done
done
