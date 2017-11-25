
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
G_orientation = radtodeg(atan(I_x./I_y));

G_orientation = G_orientation - mod(G_orientation,45);
% display(G_orientation(80:100,80:100));
Et = thinning(G_magnitude, G_orientation);

subplot(3, 3, 1), surf(G_dx); title('G\_dx');
subplot(3, 3, 2), surf(G_dy); title('G\_dy');
subplot(3, 3, 4), imshow(I_x); title('I\_x');
subplot(3, 3, 5), imshow(I_y); title('I\_y');
subplot(3, 3, 3), imshow(G_magnitude); title('G\_magnitude');
subplot(3, 3, 6), imshow(G_orientation); title('G\_orientation');
subplot(3, 3, 7), imshow(Et); title('Et');
subplot(3, 3, 8), imshow(G_orientation); title('G\_orientation');
subplot(3, 3, 9), imshow(G_orientation); title('G\_orientation');

E = G_orientation;
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

zero = min(G_magnitude(:));
for i = 2 : 509
    for j = 2 : 509
        if (mod(G_orientation(i,j),180)==45)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i-1,j+1),G_magnitude(i+1,j-1)));
            if (maximum>G_magnitude(i,j))
                G_magnitude(i,j) = zero;
            end
            
        elseif (mod(G_orientation(i,j),180)==90)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i+1,j),G_magnitude(i-1,j)));
            if (maximum>G_magnitude(i,j))
                G_magnitude(i,j) = zero;
            end
            
        elseif (mod(G_orientation(i,j),180)==135)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i-1,j-1),G_magnitude(i+1,j+1)));   
            if (maximum>G_magnitude(i,j))
                G_magnitude(i,j) = zero;
            end
            
        else % mod(G_orientation(i,j),180)==0
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i,j+1),G_magnitude(i,j-1)));    
            if (maximum>G_magnitude(i,j))
                G_magnitude(i,j) = zero;
            end
        end
    end
end

Et = G_magnitude;

end

