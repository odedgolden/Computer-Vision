% Section A - Convolution:

% Useful functions:
% help conv
% help hold on
% help plot
% help meshgrid
a = zeros(100,100);
a(1:10,:)=255;

% First we will create a synthetic image:
[y,x] = meshgrid(-500:500,-500:500);
z = x.^2 + y.^2;
figure; imshow(z,[]);

% 1) Convolution Mask 5x5 for black patch

% 2) Convolution Mask 5x5 for white L

% 3) Convolution Mask for shifting the image to the left

% Section B - Canny Edge Detector:


% Section C - Evaluation:
% Section D - Comparision:
