%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The [rameters of the left and right cameras 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
       
% Image 1: Intrinsic parameters: 
    
  %Image center: 
     ox1 = 331.023000, 
     oy1 = 259.386377 
     
  %Scale factor: 
     Sx1 = 1100.504780, 
     Sy1 = 1097.763735
     
%Focal length: 
     f1=1.0
     
% Image 1: extrinsic parameters: 
     %Rotation: 
     R1=[ 1  0 0 
         0 1 0
         0 0 1]
    
%Translation:
    T1=[0 0 0]'% Image 1: Intrinsic parameters: 
    
     
% Image 2: Intrinsic parameters: 
    %Image center: 
    ox2 = 320.798101, 
    oy2 = 236.431326,

    % Scale factor: 
    Sx2 = 1095.671499, 
    Sy2 = 1094.559584 
   
    % Focal length: 
    f2=1.0
     
    T2=-[178.2218
        18.8171
        -13.7744]
    
    R2 =[
         0.9891    0.0602   -0.1346
        -0.0590    0.9982    0.0134
         0.1351   -0.0053    0.9908]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute intrinsic projection matrices: Mint1 and Mint2

    Mint1=[Sx1 0 ox1;0 Sy1 oy1;0 0 1];
    Mint2=[Sx2 0 ox2;0 Sy2 oy2;0 0 1];
      
% Compute the projection matrices

    Mext1=[R1,-R1*T1];
    Mext2=[R2,-R2*T2];
    ML=Mint1*Mext1;
    MR=Mint2*Mext2;
      
 %%%%    stereo    %%%%
 imL=imread('Left.tif');
 imR=imread('Right.tif');
 
 % Get correspondense points from image
 
%  figure
%  imshow('Left.tif');
%  [pLx,pLy]=getpts;
%  pL=[pLx';pLy'];
%  
%  figure
%  imshow('Right.tif');
%  [pRx,pRy]=getpts;
%  pR=[pRx';pRy'];

Pworld=[-140,50,1200,1];
Qworld=[30,100,2000,1];

PLH=ML*Pworld';
PRH=MR*Pworld';
QLH=ML*Qworld';
QRH=MR*Qworld';

PL=round(PLH(1:2)./PLH(3));
PR=round(PRH(1:2)./PRH(3));
QL=round(QLH(1:2)./QLH(3));
QR=round(QRH(1:2)./QRH(3));
 
pL=[PL,QL];
pR=[PR,QR];
 
imLWithPoints = insertMarker(imL,pL);
figure;
imshow(imLWithPoints);
title('original points - left image');

P=stereo_list(pL,pR,ML,MR);

% back projection

PH=[P;ones(size(P,2),1)'];

for i=1:size(PH,2)
    pVerLH(:,i)=ML*PH(:,i);
    pVerRH(:,i)=MR*PH(:,i);
end

pVerL=zeros(2,size(PH,2));
pVerR=zeros(2,size(PH,2));

for i=1:size(PH,2)
    pVerL(:,i)=round(pVerLH(1:2,i)./(pVerLH(3,i)))';
    pVerR(:,i)=round(pVerRH(1:2,i)./(pVerRH(3,i)))';
end

imLVer = insertMarker(imL,pVerL);

figure;
imshow(imLVer);
title('stereo results after back projection - left image');
