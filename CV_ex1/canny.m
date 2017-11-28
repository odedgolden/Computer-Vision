function E = canny(imagePath, sigma, L_th, H_th)
I = imread(imagePath);
% ID = im2double(I);
mask_size = 2*sigma;

% Create the Gaussian kernels:
G_dx = Deriv_Gauss_x(sigma, mask_size);
G_dy = Deriv_Gauss_y(sigma, mask_size);

I_x = conv2(I, G_dx, 'same');
I_y = conv2(I, G_dy, 'same');

G_magnitude = I_x.^2+I_y.^2;
G_magnitude = (G_magnitude.^0.5)*2;
G_orientation = radtodeg(atan(I_x./I_y));

G_orientation = G_orientation - mod(G_orientation,45);
% display(G_orientation);
Et = thinning(G_magnitude, G_orientation);

mini = min(Et(:))
maxi = max(Et(:))
E_high = Et > H_th ;
E_high = E_high.*Et;
E_low = Et > L_th;
E_low = E_low.*Et;
E = apply_thresholds(E_high, E_low, G_orientation, L_th);

% figure;
% subplot(3, 3, 1), surf(G_dx); title('G\_dx');
% subplot(3, 3, 2), surf(G_dy); title('G\_dy');
% subplot(3, 3, 4), imshow(I_x,[]); title('I\_x');
% subplot(3, 3, 5), imshow(I_y,[]); title('I\_y');
% subplot(3, 3, 3), imshow(G_magnitude,[]); title('G\_magnitude');
% subplot(3, 3, 6), imshow(Et,[]); title('Et');
% subplot(3, 3, 8), imshow(E_low,[]); title('E\_low');
% subplot(3, 3, 7), imshow(E_high,[]); title('E\_high');
% subplot(3, 3, 9), imshow(E,[]); title('Canny');

end
