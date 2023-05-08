#! /bin/bash

OnnxModelPath=./pretrained_model/onnx_model
PlanPath=./pretrained_model/plan_model

if [ ! -d $PlanPath ]; then
    mkdir $PlanPath
fi

# all resolution of each yolov8x costs about 1 hour
#yolov8n yolov8s yolov8m 
model_list="yolov8s yolov8m"
w_list="320 640 960 1280 1920"

for model in $model_list
do
    for re in $w_list
    do
    
    echo "==================== $model\_$re.onnx to $model\_$re.plan ===================="
    /usr/src/tensorrt/bin/trtexec --onnx=$OnnxModelPath/$model\_$re.onnx --saveEngine=$PlanPath/$model\_$re.plan --workspace=1024 --inputIOFormats=fp16:chw --outputIOFormats=fp16:chw --fp16
    done
done
