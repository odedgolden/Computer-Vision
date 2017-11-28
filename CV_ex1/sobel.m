function E = sobel(imagePath)

Gx=[-1 0 1;-2 0 2; -1 0 1];
Gy=[-1 -2 -1;0 0 0; 1 2 1];

% im_test = checkerboard(8);
% I = im_test;
I = imread(imagePath);

ID = im2double(I);

I_x = imfilter(ID, Gx);
I_y = imfilter(ID, Gy);
E = sqrt(I_x.^2+I_y.^2);
end