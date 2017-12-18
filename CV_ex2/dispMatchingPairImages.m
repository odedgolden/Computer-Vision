
function dispMatchingPairImages(im1, im2, p1_m, p2_m)
p1_m=p1_m';
p2_m=p2_m';
    figure;
    [rows cols colors] = size(im1);
    newIm = uint8(zeros(rows,2*cols,colors));
    newIm(:,1:cols,:) = im1;
    newIm(:,(cols+1):end,:) = im2;
    imshow(newIm);
    hold on;
    plot(p1_m(1,:),p1_m(2,:),'ro');
    plot(p2_m(1,:)+cols,p2_m(2,:),'ro');
    for i = 1:length(p1_m(1,:))
        line([p1_m(1,i) p2_m(1,i)+cols],[p1_m(2,i) p2_m(2,i)],'Color','b');
    end
end