
% Canny Edge Detector Implementation:

% Reference -   F. J. Canny. A computational approach to edge detection.
%               IEEE Trans. Pattern Analysis and Machine Intelligent (PAMI), 8(6):679-698, 1986.
%
%


%   SCRIPT:
close all;
clear all;
image_name = 'Alicia1.jpg';
C = canny(image_name, 4,1,1);
% imshow(C);

%   MAIN FUNCTION:

function E = canny(imagePath, sigma, L_th, H_th)
I = imread(imagePath);
ID = im2double(I);
mask_size = 3*sigma;

% Create the Gaussian kernels:
G_dx = Deriv_Gauss_x(sigma, mask_size);
G_dy = Deriv_Gauss_y(sigma, mask_size);

I_x = imfilter(ID, G_dx);
I_y = imfilter(ID, G_dy);

G_magnitude = I_x.^2+I_y.^2;
G_magnitude = G_magnitude.^0.5;
G_orientation = atan(I_x./I_y);

subplot(3, 2, 1), surf(G_dx); title('G\_dx');
subplot(3, 2, 2), surf(G_dy); title('G\_dy');
subplot(3, 2, 3), imshow(I_x); title('I\_x');
subplot(3, 2, 4), imshow(I_y); title('I\_y');
subplot(3, 2, 5), imshow(G_magnitude); title('G\_magnitude');
subplot(3, 2, 6), imshow(G_orientation); title('G\_orientation');

E = I;
end

%   HELPER FUNCTIONS

function Dx = Deriv_Gauss_x(sigma, mask_size)
[x,y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size);
D = exp(-(x.^2 + y.^2)/(2*sigma^2));
D = D./sum(D(:));
Dx = -x.*D;
end

function Dy = Deriv_Gauss_y(sigma, mask_size)
[x,y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size);
D = exp(-(x.^2 + y.^2)/(2*sigma^2));
D = D./sum(D(:));
Dy = -y.*D;
end
