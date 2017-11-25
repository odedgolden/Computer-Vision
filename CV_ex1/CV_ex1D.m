% Sobel Edge Detector Implementation:


%   SCRIPT:
close all;
clear all;
image_name = 'Alicia2.jpg';
% image_name = 'lighthouse.bmp';
% image_name = 'Nuns.jpg';
% image_name = 'Church.jpg';
% image_name = 'Golf.jpg';
S = sobel(image_name);
imshow(S);

%   MAIN FUNCTION:

function E = sobel(imagePath)

Gx=[-1 0 1;-2 0 2; -1 0 1];
Gy=[-1 -2 -1;0 0 0; 1 2 1];

I = imread(imagePath);
ID = im2double(I);

I_x = imfilter(ID, Gx);
I_y = imfilter(ID, Gy);
E = sqrt(I_x.^2+I_y.^2);
end