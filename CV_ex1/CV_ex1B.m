
% Section B - Canny Edge Detector Implementation:

% Reference -   F. J. Canny. A computational approach to edge detection.
%               IEEE Trans. Pattern Analysis and Machine Intelligent (PAMI), 8(6):679-698, 1986.
%

%   SCRIPT:
close all;
clear all;
image_dir = strcat(pwd,'/images/');
images = ['Alicia1.jpg',"Alicia2.jpg","lighthouse.bmp"];
official_images = ["Nuns.jpg","Church.jpg","Golf.jpg"];
official_ground_truth = ["Nuns_GT.bmp","Church_GT.bmp","Golf_GT.bmp"];
low_thresholds = [0.01,0.02];
high_thresholds = [0.05,0.1];
sigmas = [4,6];

for i = 1 : length(official_images)
    for j = 1 : length(sigmas)
        for k = 1 : length(low_thresholds)
            for l = 1 : length(high_thresholds)
            path = char(strcat(image_dir,string(official_images(i))));
            C = canny(path, sigmas(j), low_thresholds(k),high_thresholds(l));
            gt = imread(char(strcat(image_dir,string(official_ground_truth(i)))));
            official_image = imread(path);
            figure, subplot(1, 3, 1), imshow(official_image); title('Original Image');
            subplot(1, 3, 2), imshow(C); title('Our Canny');
            subplot(1, 3, 3), imshow(gt,[]); title('Ground Truth');
            end
        end
    end
end

