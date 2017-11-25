% Section A - Convolution:

% Useful functions:
% help conv
% help hold on
% help plot
% help meshgrid
% a = zeros(100,100);
% a(1:10,:)=255;

% First we will create a synthetic image:
% [y,x] = meshgrid(-500:500,-500:500);
% z = x.^2 + y.^2;
% figure; imshow(z,[]);

% 1) Convolution Mask 5x5 for black patch
m1 = [0 0 0 0 0; 0 1 1 1 0; 0 -2 -2 -2 0; 0 1 1 1 0; 0 0 0 0 0];
im1 = repmat(255,100,100);
im1(50,:) = 0;
figure; imshow(im1,[]);
c = conv2(im1,m1,'valid');
figure; imshow(c,[]);
im2 = repmat(255,100,100);
im2(50,10:12) = 0;
figure; imshow(im2,[]);
c = conv2(im2,m1,'valid');
figure; imshow(c,[]);

% 2) Convolution Mask 5x5 for white L
m1 = [0 0 4 -5 -5; 0 0 4 -5 -5; 0 0 4 4 4; 0 0 0 0 0; 0 0 0 0 0];
%m1 = [ 0 0 5 0 0; 0 0 5 0 0; 0 0 5 5 5; 0 0 0 0 0; 0 0 0 0 0; ];
m2=m1';
im1 = repmat(0,100,100);
im1(50,10:12) = 255;
im1(49,10) = 255;
im1(48,10) = 255;
figure; imshow(im1,[]);
c = conv2(im1,m2, 'same');
figure; imshow(c,[]);

% 3) Convolution Mask for shifting the image to the left
m1 = [1 0];
%m1 = [ 0 0 5 0 0; 0 0 5 0 0; 0 0 5 5 5; 0 0 0 0 0; 0 0 0 0 0; ];
m2=m1';
im1 = repmat(0,100,100);
im1(:,12) = 255;
figure; imshow(im1,[]);
c = conv2(im1,m1, 'same');
figure; imshow(c,[]);


% Section B - Canny Edge Detector:
% Section C - Evaluation:
% Section D - Comparision: