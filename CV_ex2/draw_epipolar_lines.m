function [f1,f2]=draw_epipolar_lines(im1,im2,F,p,f1,f2)
    epipolar_line = F*[p; 1]
%     epipolar_line = epipolar_line./epipolar_line(3)
%     epipolar_line = epipolar_line(1:2)
    
    x_q = 1
    y_q = round(-(epipolar_line(3)+epipolar_line(1))/epipolar_line(2))
    
    x_p = size(im2,2)
    y_p = round(-(epipolar_line(3)+epipolar_line(1)*x_p)/epipolar_line(2))
    hold on
    plot([x_q,x_p],[y_q,y_p])