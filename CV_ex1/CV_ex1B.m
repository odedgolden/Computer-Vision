
% Canny Edge Detector Implementation:

% Reference -   F. J. Canny. A computational approach to edge detection.
%               IEEE Trans. Pattern Analysis and Machine Intelligent (PAMI), 8(6):679-698, 1986.
%
%


%   SCRIPT:

close all;
clear all;
image_name = 'Alicia2.jpg';
C = canny(image_name, 2,1,1)
imshow(C);

%   MAIN FUNCTION:

function E = canny(imagePath, sigma, L_th, H_th)
% I = imread(imagePath);
% ID = im2double(I);
mask_size = 2*sigma;

% Create the Gaussian kernels:
G_dx = Deriv_Gauss_x(sigma, mask_size)
G_dy = Deriv_Gauss_y(sigma, mask_size)

% E = I;
end

%   HELPER FUNCTIONS

function Dx = Deriv_Gauss_x(sigma, mask_size)
[x,y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size)
D = exp(-(x.^2 + y.^2)/(2*sigma^2))
D = D./sum(D(:))
Dx = -x.*D/sigma^2
end

function Dy = Deriv_Gauss_y(sigma, mask_size)
[x,y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size)
D = exp(-(x.^2 + y.^2)/(2*sigma^2))
D = D./sum(D(:))
Dy = -y.*D/sigma^2
end
