
% Canny Edge Detector Implementation:

% Reference -   F. J. Canny. A computational approach to edge detection.
%               IEEE Trans. Pattern Analysis and Machine Intelligent (PAMI), 8(6):679-698, 1986.
%
%


%   SCRIPT:
close all;
clear all;
image_dir = strcat(pwd,'/images/');
images = ['Alicia1.jpg',"Alicia2.jpg","lighthouse.bmp"];
official_images = ["Nuns.jpg","Church.jpg","Golf.jpg"];
official_ground_truth = ["Nuns_GT.bmp","Church_GT.bmp","Golf_GT.bmp"];
low_thresholds = [-1.5,-0.5,0,0.5];
high_thresholds = [-11,0,0.5,1];
sigmas = [0.1,0.2,0.4,2.5];
i =2;
% for i = 1 : length(official_images)
j = 4;
%     for j = 1 : length(sigmas)
k = 1;
%         for k = 1 : length(low_thresholds)
l = 3;
%             for l = 1 : length(high_thresholds)
            path = char(strcat(image_dir,string(official_images(i))));
            C = canny(path, sigmas(j), low_thresholds(k),high_thresholds(l));
            gt = imread(char(strcat(image_dir,string(official_ground_truth(i)))));
            figure, subplot(1, 2, 1), imshow(C); title('Our Canny');
            subplot(1, 2, 2), imshow(gt,[]); title('Ground Truth');
%             end
%         end
%     end
% end

%   MAIN FUNCTION:

function E = canny(imagePath, sigma, L_th, H_th)
I = imread(imagePath);

% im_test = checkerboard(8);
% I = im_test;

ID = im2double(I);
mask_size = 2*sigma;

% Create the Gaussian kernels:
G_dx = Deriv_Gauss_x(sigma, mask_size);
G_dy = Deriv_Gauss_y(sigma, mask_size);

I_x = imfilter(ID, G_dx);
I_y = imfilter(ID, G_dy);

G_magnitude = I_x.^2+I_y.^2;
G_magnitude = G_magnitude.^0.5;
G_orientation = radtodeg(atan(I_x./I_y));

G_orientation = G_orientation - mod(G_orientation,45);
Et = thinning(G_magnitude, G_orientation);

mini = min(Et(:))
maxi = max(Et(:))
E_high = Et > H_th ;
E_high = E_high.*Et;
E_low = Et > L_th;
E_low = E_low.*Et;
E = apply_thresholds(E_high, E_low, G_orientation, L_th);

subplot(3, 3, 1), surf(G_dx); title('G\_dx');
subplot(3, 3, 2), surf(G_dy); title('G\_dy');
subplot(3, 3, 4), imshow(I_x); title('I\_x');
subplot(3, 3, 5), imshow(I_y); title('I\_y');
subplot(3, 3, 3), imshow(G_magnitude); title('G\_magnitude');
subplot(3, 3, 6), imshow(G_orientation); title('G\_orientation');
subplot(3, 3, 8), imshow(Et); title('E\_low');
subplot(3, 3, 7), imshow(E_high); title('E\_high');
subplot(3, 3, 9), imshow(E); title('Canny');

% subplot(1, 3, 1), imshow(E_high); title('E\_high');
% subplot(1, 3, 2), imshow(E_low); title('E\_low');
% subplot(1, 3, 3), imshow(E-E_low); title('Canny');

% imshow(E);
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

function Et = thinning(G_magnitude, G_orientation)
n = length(G_magnitude);
m = length(G_magnitude(:,1));
zero = min(G_magnitude(:));
Et = G_magnitude - G_magnitude;
for i = 2 : m-3
    for j = 2 : n-3
        if (mod(G_orientation(i,j),180)==135)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i-1,j+1),G_magnitude(i+1,j-1)));
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
            
        elseif (mod(G_orientation(i,j),180)==0)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i+1,j),G_magnitude(i-1,j)));
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
            
        elseif (mod(G_orientation(i,j),180)==45)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i-1,j-1),G_magnitude(i+1,j+1)));   
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
            
        else % mod(G_orientation(i,j),180)==90
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i,j+1),G_magnitude(i,j-1)));    
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
        end
    end
end
end

function E = apply_thresholds(E_high, E_low, G_orientation, L_th)
n = length(E_low);
m = length(E_low(:,1));

for i = 2 : m-3
    for j = 2 : n-3
        if (mod(G_orientation(i,j),180)==45)
            maximum =  max(E_high(i-1,j+1),E_high(i+1,j-1));
            if (maximum>L_th)
                E_high(i,j) = E_low(i,j);
            end
            
        elseif (mod(G_orientation(i,j),180)==90)
            maximum =  max(E_high(i+1,j),E_high(i-1,j));
            if (maximum>L_th)
                E_high(i,j) = E_low(i,j);
            end
            
        elseif (mod(G_orientation(i,j),180)==135)
            maximum =  max(E_high(i-1,j-1),E_high(i+1,j+1));   
            if (maximum>L_th)
                E_high(i,j) = E_low(i,j);
            end
            
        else % mod(G_orientation(i,j),180)==0
            maximum =  max(E_high(i,j+1),E_high(i,j-1));    
            if (maximum>L_th)
                E_high(i,j) = E_low(i,j);
            end
        end
    end
end

E = E_high;
end
