
% Canny Edge Detector Implementation:

% Reference -   F. J. Canny. A computational approach to edge detection.
%               IEEE Trans. Pattern Analysis and Machine Intelligent (PAMI), 8(6):679-698, 1986.
%
%


%   SCRIPT:

close all;
clear all;
imageName = 'Alicia2.jpg';
C = canny(imageName, 1,1,1)
imshow(C);

%   FUNCTIONS:

function E = canny(imagePath, sigma, L_th, H_th)
I = imread(imagePath);
ID = im2double(I);

% G_dx = Deriv_Gauss_x(sigma, mask_size)
% G_dy = Deriv_Gauss_y(sigma, mask_size)

E = I;
end

