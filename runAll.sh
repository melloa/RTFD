nvidia-smi stats -i 0 -d pwrDraw > "$1_device0_pwr.csv"& nvidia-smi stats -i 1 -d pwrDraw > "$1_device1_pwr.csv"&
#!/bin/bash
for FILE in pics/*.jpg
do
        FILENAME_EXT=${FILE##*/}
        NAME=${FILENAME_EXT%%.*}
        ./face_detector -f -i $FILE -o output 2> /dev/null 1> output/${NAME}_output.txt
done
pkill nvidia-smi
