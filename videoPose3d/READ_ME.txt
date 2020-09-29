https://github.com/facebookresearch/VideoPose3D/issues/62
========================================================================================

INstall detectron2 from this source
https://github.com/facebookresearch/detectron2/blob/master/INSTALL.md
(BUILD detectron2 from source)
python3 -m pip install 'git+https://github.com/facebookresearch/detectron2.git'
# (add --user if you don't have permission)

Download this weight in checkpoint
wget https://dl.fbaipublicfiles.com/video-pose-3d/pretrained_h36m_detectron_coco.bin


CREATE input_directory
CREATE output_directory

python3 inference/infer_video_d2.py --cfg COCO-Keypoints/keypoint_rcnn_R_101_FPN_3x.yaml --output-dir output_directory --image-ext mp4 input_directory


CREATE a CUSTOM dataset 
(RUN THIS SCRIPT FROM data directory)
python3 prepare_data_2d_custom.py -i ../output_directory -o myvideos

python3 run.py -d custom -k myvideos -arc 3,3,3,3,3 -c checkpoint --evaluate pretrained_h36m_detectron_coco.bin --render --viz-subject 1.mp4 --viz-action custom --viz-camera 0 --viz-video 1.mp4 --viz-output 1_output.mp4 --viz-export 1_outputfile --viz-size 6


# #inspect joints export 

# import numpy as np
# data  = np.load('12_buschbeck_prae_outputfile.npy')
# # data  = np.load('positions_2d.npy',allow_pickle=True )
# lst = data
# count = 0
# for item in lst:
#     count= count+1
#     print(item)
# print('>>>>>> KEYPOINT COUNT >>>> ',count)
