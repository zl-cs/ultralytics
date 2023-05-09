# Train command
```
yolo detect train data=coco.yaml model=yolov8n.yaml imgsz=320 device=0,1,2,3 save_dir=runs/detect/yolov8x_320p_train #lion-11
yolo detect train data=coco.yaml model=yolov8n.yaml pretrained=yolov8n.pt epochs=20 imgsz=320 device=0,1,2,3 save_dir='runs/detect/yolov8n_320p_train_pretrained'  #lion-10
``` 


# Val command
```
yolo detect val model=runs/detect/yolov8n_320p_train/weights/best.pt data=coco.yaml device=0
yolo detect val model=runs/detect/yolov8m.pt data=coco.yaml device=0 imgsz=320
```

mAP 50-95 results:

| model   | size   | mAP (50-95) |
| :--     |:--     |:--          |
| yolov8m | 320     | 42.4       |
| yolov8m | 480     | 47.7       |
| yolov8m | 640     | 50.2       |
| yolov8s | 320     | 35.9       |
| yolov8s | 480     | 41.9       |
| yolov8s | 640     | 44.9       |
| yolov8n | 320     | 28.4       |
| yolov8n | 480     | 34.7       |
| yolov8n | 640     | 37.3       |


Models with different input size exported by pretrained model (640p) show that: the accuracy of one small model with a larger input size can equal to or more than one large model with a smaller input size.

# Predict
```
yolo detect predict model=pretrained_model/yolov8n.pt source='datasets/coco/images/val2017/000000298251.jpg'  
```