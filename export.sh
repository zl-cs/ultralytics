#! /bin/bash
# conda activate yolov8

ModelPath=./pretrained_model
OnnxModelPath=$ModelPath/onnx_model

if [ ! -d $OnnxModelPath ]; then
    mkdir $OnnxModelPath
fi

model_list="yolov8n yolov8s yolov8m"
# 16_9_re_list="(320,180) (640,360) (960,540) (1280,736) (1920,1088)"
w_list="320 640 960 1280 1920"
h_list="192 384 544 736 1088"

# 1260 5040 10710 19320 42840
# input shape: (1,3,h,w)
# output shape: (1,84, (h/32)*(w/32)+(h/16)*(w/16)+(h/8)*(w/8) )
# 84 = 80 classes + 4 position coordinates
for model in $model_list
do
    for re in $w_list
    do
        # 计算(re/16*9)/32
        h=$[((($re/16)*9+32-1)/32)*32]

        echo "==================== $model.pt with $re*$h to $model.onnx ===================="
        yolo export model=$ModelPath/$model.pt format=onnx imgsz=$h,$re half=true 
        mv $ModelPath/$model.onnx $OnnxModelPath/$model\_$re.onnx
    done
done
