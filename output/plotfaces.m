
fileID = fopen('5pics_names_2018_04_08_-_06_08_33_landmarks.txt','r');

filename = fgetl(fileID);
while ischar(filename)
    figure()
    hold on
    imshow(strcat(filename,'.jpg'));
    face_count = str2num(fgetl(fileID));
    for i = 1:face_count
        landmarks = str2num(fgetl(fileID));
        
        
        for j = 1:2:10
            rect(landmarks(j), landmarks(j+1));
        end
        
    end
    hold off
    
    disp(filename);
    disp(face_count);
    filename = fgetl(fileID);
end
