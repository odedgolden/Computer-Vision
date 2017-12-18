
function [m1, m2] = extractAndMatchSIFT(Ia, Ib,th)

    [rows, cols, colors] = size(Ia);
    
    if (colors > 1)
        Ia = rgb2gray(Ia);
        Ib = rgb2gray(Ib);
    end
    
    [fa, da] = vl_sift(single(Ia)) ;
    [fb, db] = vl_sift(single(Ib)) ;
    if exist('th')
        [matches, scores] = vl_ubcmatch(da, db, th);
    else
        [matches, scores] = vl_ubcmatch(da, db);
    end
    xVec = fa(1,matches(1,:));
    yVec = fa(2,matches(1,:));
    xTagVec = fb(1,matches(2,:));
    yTagVec = fb(2,matches(2,:));
    m1=[xVec ; yVec]';
    m2=[xTagVec; yTagVec]';
end


