function Dx = Deriv_Gauss_x(sigma, mask_size)
[x,y] = meshgrid(-mask_size:mask_size, -mask_size:mask_size);
% display([x,y]);
D = exp(-(x.^2 + y.^2)/(2*sigma^2))/(2*pi*sigma^2);
s = sum(D(:));
D = D./s;
Dx = -x.*D/(sigma^2);
end