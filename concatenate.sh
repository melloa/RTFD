#!/bin/bash

echo "Timing for image in milliseconds" > ./output.txt
find output/ -name *_output.txt | xargs grep -oh "Without Setup Time    :  [0-9\.]* " |  grep -oh "[0-9\.]* " | sed '/^\s*$/d' >> ./output.txt

echo "" >> ./output.txt
echo "Landmarks" >> ./output.txt
sed '3q;d' output/img_387_2018_04_27_-_10_31_59_landmarks.txt | tr " " "\n" >> ./output.txt

