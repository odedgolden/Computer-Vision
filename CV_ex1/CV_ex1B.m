
% Section B - Canny Edge Detector Implementation:

% Reference -   F. J. Canny. A computational approach to edge detection.
%               IEEE Trans. Pattern Analysis and Machine Intelligent (PAMI), 8(6):679-698, 1986.
%

%   SCRIPT:
close all;
clear all;

im_test = checkerboard(8);
imwrite(im_test,'./images/im_test.jpg')

image_dir = strcat(pwd,'/images/');
images = ['Alicia1.jpg',"Alicia2.jpg","lighthouse.bmp"];
official_images = ["Nuns.jpg","Church.jpg","Golf.jpg","im_test.jpg"];
official_ground_truth = ["Nuns_GT.bmp","Church_GT.bmp","Golf_GT.bmp","im_test.jpg"];
low_thresholds = [0.2,0.02];
high_thresholds = [1,0.1];
sigmas = [2,4];


for i = 1 : length(official_images)
    for j = 1 : length(sigmas)-1
        for k = 1 : length(low_thresholds)-1
            for l = 1 : length(high_thresholds)-1
            path = char(strcat(image_dir,string(official_images(i))));
            C = canny(path, sigmas(j), low_thresholds(k),high_thresholds(l));
            gt = imread(char(strcat(image_dir,string(official_ground_truth(i)))));
            official_image = imread(path);
            figure, %subplot(1, 3, 1), imshow(official_image,[]); title('Original Image');
            subplot(1, 2, 1), imshow(C); title('Our Canny');
            subplot(1, 2, 2), imshow(gt); title('Ground Truth');
            end
        end
    end
end

