
% Section D - Sobel Edge Detector Implementation:


%   SCRIPT:
close all;
clear all;
image_dir = strcat(pwd,'/images/');
images = ['Alicia1.jpg',"Alicia2.jpg","lighthouse.bmp"];
official_images = ["Nuns.jpg","Church.jpg","Golf.jpg"];
official_ground_truth = ["Nuns_GT.bmp","Church_GT.bmp","Golf_GT.bmp"];

for i = 1 : length(official_images)
    path = char(strcat(image_dir,string(official_images(i))));
    S = sobel(path);
    gt = imread(char(strcat(image_dir,string(official_ground_truth(i)))));
    figure, subplot(1, 2, 1), imshow(S); title('Our Sobel');
    subplot(1, 2, 2), imshow(gt,[]); title('Ground Truth');
end


sigma = [2,4,6];
L_th = [0.01, 0.1, 0.3];
H_th = [0.05, 0.5, 0.8];
index = 1;

for i=1:length(official_images)

                image_path = char(strcat(image_dir,string(official_images(i))));
                E_ch=sobel(image_path);
                E_ch=uint8(E_ch);
                gt_path = char(strcat(image_dir,string(official_ground_truth(i))));
                gt = imread(gt_path);
                [Pn,Rn,Fn] = evaluate_naive(E_ch,gt);
                [P,R,F] = evaluate(E_ch,gt);
                Pn_tot(index) = Pn;
                Rn_tot(index) = Rn;
                Fn_tot(index) = Fn;
                P_tot(index) = P;
                R_tot(index) = R;
                F_tot(index) = F;

                index = index+1;

end

display(max(P_tot));
display(max(R_tot));
display(max(F_tot));
    
    