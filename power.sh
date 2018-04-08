nvidia-smi stats -i 0 -d pwrDraw > device0_pwr.csv& nvidia-smi stats -i 1 -d pwrDraw > device1_pwr.csv&
./face_detector -f -d ../pics_names.txt ../pics/ -o output
pkill nvidia-smi
