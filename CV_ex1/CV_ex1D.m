
% Section D - Sobel Edge Detector Implementation:


%   SCRIPT:
close all;
clear all;
image_dir = strcat(pwd,'/images/');
images = ['Alicia1.jpg',"Alicia2.jpg","lighthouse.bmp"];
official_images = ["Nuns.jpg","Church.jpg","Golf.jpg"];
official_ground_truth = ["Nuns_GT.bmp","Church_GT.bmp","Golf_GT.bmp"];

for i = 1 : length(official_images)
    path = char(strcat(image_dir,string(official_images(i))));
    S = sobel(path);
    gt = imread(char(strcat(image_dir,string(official_ground_truth(i)))));
    figure, subplot(1, 2, 1), imshow(S); title('Our Sobel');
    subplot(1, 2, 2), imshow(gt,[]); title('Ground Truth');
end

%   MAIN FUNCTION:

function E = sobel(imagePath)

Gx=[-1 0 1;-2 0 2; -1 0 1];
Gy=[-1 -2 -1;0 0 0; 1 2 1];

% im_test = checkerboard(8);
% I = im_test;
I = imread(imagePath);

ID = im2double(I);

I_x = imfilter(ID, Gx);
I_y = imfilter(ID, Gy);
E = sqrt(I_x.^2+I_y.^2);
end