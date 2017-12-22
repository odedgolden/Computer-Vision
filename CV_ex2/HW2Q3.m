clc
clear all
close all

im2=readImage('view1.tif');
im1=readImage('view5.tif');

figure; imshow(im1,[]);
figure; imshow(im2,[]);

patchX=3;
patchY=3;

DispOrder=DisparityMapOrder(im1,im2,patchX,patchY);
figure;
imshow(DispOrder,[]);
title('Disparity map - with order assumption');


DepthOrder=160./(DispOrder+100);
figure;
imshow(DepthOrder,[]);
title('Depth map - with order assumption');

DispNoOrder=DisparityMapNoOrder(im1,im2,patchX,patchY);
figure;
imshow(DispNoOrder,[]);
title('Disparity map - without order assumption');

DepthNoOrder=160./(DispOrder+100);
figure;
imshow(DepthNoOrder,[]);
title('Depth map - without order assumption');





