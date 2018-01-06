%Script HW3
clc
clear all
close all

vid = VideoReader('people.avi');
mov=read(vid);

currAxes = axes;
Sigma_S=1;
Region=2;

%%%% Reading the first image %%%%
im2=rgb2gray(mov(:,:,:,1)); %covert to gray scale
im2=imresize(im2,0.3); %resize the image
figure; imshow(im2,[]);

for i=2:size(mov,4)
   im1=im2;
   im2=rgb2gray(mov(:,:,:,i)); %covert to gray scale
   im2=imresize(im2,0.3); %resize the image
   imshow(im2,[]);
   hold on;
   [U,V,M,O]=OF(im1,im2, Sigma_S, Region);
%    I = seg_OF_orientation(O,0.9);
   I = seg_OF_size(M,0.5);
   imshow(I,[]);
%    [X Y]=meshgrid(1:size(im1,2),1:size(im1,1));
%    nu12=medfilt2(U,[5 5]);
%    nv12=medfilt2(V,[5 5]);
%    figure; imshow(im1,[]);
%    hold on;
%    quiver(X(1:5:end,1:5:end),Y(1:5:end,1:5:end),nu12(1:5:end,1:5:end),nv12(1:5:end,1:5:end),5);
   pause(0.1);
   hold off;
end
    