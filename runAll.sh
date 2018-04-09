nvidia-smi stats -i 0 -d pwrDraw > "$1_device0_pwr.csv"& nvidia-smi stats -i 1 -d pwrDraw > "$1_device1_pwr.csv"&
./face_detector -f -d ../pics_names.txt ../pics/ -o $1
pkill nvidia-smi
