function Dy = Deriv_Gauss_y(sigma, mask_size)
[x,y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size);
D = exp(-(x.^2 + y.^2)/(2*sigma^2))/(2*pi*sigma^2);
s = sum(D(:));
D = D./s;
Dy = -y.*D/(sigma^2);
end