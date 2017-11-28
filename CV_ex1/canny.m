function E = canny(imagePath, sigma, L_th, H_th)
I = imread(imagePath);
ID = im2double(I);
mask_size = 1.9*sigma;

% Create the Gaussian kernels:
G_dx = Deriv_Gauss_x(sigma, mask_size);
G_dy = Deriv_Gauss_y(sigma, mask_size);

I_x = conv2(ID, G_dx, 'same');
I_y = conv2(ID, G_dy, 'same');

G_magnitude = I_x.^2+I_y.^2;
G_magnitude = (G_magnitude.^0.5)*2;
G_orientation = radtodeg(atan(I_x./I_y));

G_orientation = G_orientation - mod(G_orientation,45);
Et = thinning(G_magnitude, G_orientation);

% mini = min(Et(:))
% maxi = max(Et(:))
E_high = Et > H_th ;
E_high = E_high.*Et;
E_low = Et > L_th;
E_low = E_low.*Et;
E = apply_thresholds(E_high, E_low, G_orientation, L_th);

% subplot(3, 3, 1), surf(G_dx); title('G\_dx');
% subplot(3, 3, 2), surf(G_dy); title('G\_dy');
% subplot(3, 3, 4), imshow(I_x); title('I\_x');
% subplot(3, 3, 5), imshow(I_y); title('I\_y');
% subplot(3, 3, 3), imshow(G_magnitude); title('G\_magnitude');
% subplot(3, 3, 6), imshow(Et); title('Et');
% subplot(3, 3, 8), imshow(E_low); title('E\_low');
% subplot(3, 3, 7), imshow(E_high); title('E\_high');
% subplot(3, 3, 9), imshow(E); title('Canny');

end

%   HELPER FUNCTIONS

function Dx = Deriv_Gauss_x(sigma, mask_size)
[x,y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size);
% display([x,y]);
D = exp(-(x.^2 + y.^2)/(2*sigma^2))/(2*pi*sigma^2);
s = sum(D(:));
D = D./s;
Dx = -x.*D/(sigma^2);
end

function Dy = Deriv_Gauss_y(sigma, mask_size)
[x,y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size);
D = exp(-(x.^2 + y.^2)/(2*sigma^2))/(2*pi*sigma^2);
s = sum(D(:));
D = D./s;
Dy = -y.*D/(sigma^2);
end

function Et = thinning(G_magnitude, G_orientation)
n = length(G_magnitude);
m = length(G_magnitude(:,1));
zero = min(G_magnitude(:));
Et = G_magnitude - G_magnitude;
for i = 2 : m-3
    for j = 2 : n-3
        if (mod(G_orientation(i,j),180)==45)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i-1,j+1),G_magnitude(i+1,j-1)));
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
            
        elseif (mod(G_orientation(i,j),180)==90)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i+1,j),G_magnitude(i-1,j)));
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
            
        elseif (mod(G_orientation(i,j),180)==135)
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
