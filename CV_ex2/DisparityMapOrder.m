function D=DisparityMapOrder(im1,im2,patchX,patchY)
% Input - 2 images with the same size, output - matrix with same size,
% where each pixel holds the disparity

imSizeX=size(im1,1);
imSizeY=size(im1,2);
D=zeros(imSizeX,imSizeY);
halfPatchX=floor(patchX/2);
halfPatchY=floor(patchY/2);
distTmp=0;
disparity=0;

for i=patchX:imSizeX-patchX
    for j=patchY:imSizeY-patchY
        v1=im1(i-halfPatchX:i+halfPatchX,j-halfPatchY:j+halfPatchY);
        v1=v1(:);
        normV1=norm(v1);
        startIdx=max(j+10,D(i,j-1));
        endIdx=min(j+140,imSizeY-patchY);
        for m=startIdx:endIdx
             v2=im2(i-halfPatchX:i+halfPatchX,m-halfPatchY:m+halfPatchY);
             v2=v2(:);
             normV2=norm(v2);
             dist=1-((v1'*v2)/(normV1*normV2));
             if (distTmp==0 || dist<distTmp)
                 distTmp=dist;
                 disparity=m-j;
             end
        end
        D(i,j)=disparity;
        distTmp=0;
    end
end