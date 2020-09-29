#for filename in input_directory/*.mp4; do
#    echo $filename
#    cd input_directory
#    for f in *; do
#	echo $f
#	name=$(echo "$f" | cut -f 1 -d '.')
#	python3 -c "print('Hello World!_$name')"
#    done
#    break
#    # ... rest of the loop body
#done
#cd ..

python3 inference/infer_video_d2.py --cfg COCO-Keypoints/keypoint_rcnn_R_101_FPN_3x.yaml --output-dir output_directory --image-ext mp4 input_directory

cd data
python3 prepare_data_2d_custom.py -i ../output_directory -o myvideos
cd ..

for file in input_directory/*.mp4; do
    name=$(echo $(basename "$file") | cut -f 1 -d '.')
    echo $name
    python3 run.py -d custom -k myvideos -arc 3,3,3,3,3 -c checkpoint --evaluate pretrained_h36m_detectron_coco.bin --render --viz-subject $name".mp4" --viz-action custom --viz-camera 0 --viz-video input_directory/$name".mp4" --viz-output output/videos/$name"_output.mp4" --viz-export output/3d_keypoint/$name"_outputfile" --viz-size 6
done
