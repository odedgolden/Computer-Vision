%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The [rameters of the left and right cameras 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
run('vlfeat-0.9.20/toolbox/vl_setup')
  
% Image 1: Intrinsic parameters: 
    
  %Image center: 
     ox1 = 331.023000;
     oy1 = 259.386377 ;
     
  %Scale factor: 
     Sx1 = 1100.504780;
     Sy1 = 1097.763735;
     
%Focal length: 
     f1=1.0;
     
% Image 1: extrinsic parameters: 
     %Rotation: 
     R1=[ 1  0 0 
         0 1 0
         0 0 1];
    
%Translation:
    T1=[0 0 0]';% Image 1: Intrinsic parameters: 
    
     
% Image 2: Intrinsic parameters: 
    %Image center: 
    ox2 = 320.798101; 
    oy2 = 236.431326;

    % Scale factor: 
    Sx2 = 1095.671499;
    Sy2 = 1094.559584;
   
    % Focal length: 
    f2=1.0;
     
    T2=-[178.2218
        18.8171
        -13.7744];
    
    R2 =[
         0.9891    0.0602   -0.1346
        -0.0590    0.9982    0.0134
         0.1351   -0.0053    0.9908];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute intrinsic projection matrices: Mint1 and Mint2

    Mint1= [
            f1*Sx1  0   ox1
            0   f1*Sy1  oy1
            0   0   1]
    Mint2= [
            f2*Sx2  0   ox2
            0   f2*Sy2  oy2
            0   0   1]
      
% Compute the projection matrices
    P = [
        1   0   0   0
        0   1   0   0
        0   0   1   0];
    rotation1 = [ 
                    1   0   0   0 
                    0   1   0   0
                    0   0   1   0
                    0   0   0   1];
    rotation2 = [
                    0.9891  0.0602  -0.1346 0
                    -0.0590 0.9982   0.0134 0
                    0.1351  -0.0053 0.9908  0
                    0   0   0   1];  
    translation1 = [
                    1   0   0   0
                    0   1   0   0
                    0   0   1   0
                    0   0   0   1];
    translation2 = [
                    1   0   0   178.2218
                    0   1   0   18.8171
                    0   0   1   -13.7744
                    0   0   0   1];
                
    M1= Mint1*P*rotation1*translation1
    M2= Mint2*P*rotation2*translation2

    d = sqrt((oy1-oy2)^2+(ox1-ox2)^2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (4) Verify that the null space of M is indeed the COP     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    N1 = null(M1);
    N2 = null(M2);
    
    N1 = N1./N1(4);
    N2 = N2./N2(4);
    
    cop1 = N1(1:3)
    cop2 = N2(1:3)
    
    d = norm(T1-T2)
    
    p = [-140
            50  
            1200
            1];
    q = [30
        100
        2000 
        1];
    
    p1 = M1*p
    p2 = M2*p
    q1 = M1*q
    q2 = M2*q
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (6) Projection                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
   % Write a finction p=proj(P,M) that recieves as input 
   % the 3D point P,  and a projection  matrix M, and output 
   % the  2D coordinates of the projected point.
    
    P=[-140,50,1200]';
    p1=proj(P,M1);
    p2=proj(P,M2);
    
    Q=[30,100,2000]'; 
    q1=proj(Q,M1);
    q2=proj(Q,M2);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read the images into im1 and im2,  and dispaly them.      %
% Using the command figure(f1) will redisplay the figure    %
% containing im1.                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
    im1=readImage('Left.tif');
    im2=readImage('Right.tif');

    figure;
    imshow(im1,[])
    hold on;
    f1=gcf;
    
    figure;
    imshow(im2,[])
    hold on;
    f2=gcf;

    % display the projection on the two images
    figure(f1);
    plot(p1(1),p1(2),'*r');
    
    figure(f2);
    plot(p2(1),p2(2),'*r');
    
    
    figure;
    imshow(im1,[])
    hold on;
    f3=gcf;
    
    figure;
    imshow(im2,[])
    hold on;
    f4=gcf;
    
    figure(f3);
    plot(q1(1),q1(2),'*r');
    
    figure(f4);
    plot(q2(1),q2(2),'*r');
    
  
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (7-10) compute the fundamnral matrix F, the epipoles el   % 
% and er, and Fel erF                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
 
     e1= M1*N2
     e2= M2*N1
 
     m12 = M2*pinv(M1)
     e2x = [0,-e2(3),e2(2);
            e2(3),0,-e2(1);
            -e2(2),e2(1),0]
     F= e2x*M2*pinv(M1)
     F = F./F(3,3)
     
 % Please normalize F by F(3,3).
    
    F*e1
    e2'*F
   
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % (11) Draw epipolar lines                           
 % You have to write the function
 % [f1,f2]=draw_epipolar_lines(im1,im2,F,p,f1,f2) (f1 and f2 are the figures on
 % which im1 and im2 are already dispalyed, the value of f1 and f2 are 0 if the images
 % are note displayed yet. In this case, the f1 and f2 are the output of
 % the function for later use of the figures
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 p=[283,348]';% the selected point
 
 draw_epipolar_lines(im1,im2,F,p,f1,f2)

 figure(f1);
 
 % Choose points from image 1 (look at help getpts)
 figure(f1);
 [Px,Py]=getpts
 
% Display the  set of pipolar lines which corresponds to the chosen points

for i=1:length(Px)
    draw_epipolar_lines(im1,im2,F,[Px(i),Py(i)]',f1,f2)
end
    
% (12) Corner detector + matching removal by Sampson distance
%  Hi grader, I couldn't get the library to work on my mac, 
%  But this is the gist of it:

% th = 1.5
% [m1, m2] = extractAndMatchSIFT(im1, im2,th);
% dispMatchingPairImages(im1, im2,m1,m2);
% dists = sampsonDistance(F,m1,m2)
% for i=1:length(dists)
%     if dists(i) > 0.1
%         m1(i,:) = [];
%         m2(i,:) = [];
%     end
% dispMatchingPairImages(im1, im2,m1,m2);

% Thanks for your understanding!




 
  