function [f1,f2]=draw_epipolar_lines(im1,im2,F,p,f1,f2)
    epipolar_line = F*[p; 1]
    epipolar_line = epipolar_line./epipolar_line(3)
    epipolar_line = epipolar_line(1:2)

    q=[1,epipolar_line(1)]
    p=[size(im1,2),epipolar_line(2)]
    plot([q(1), p(1)],[q(2),p(2)])