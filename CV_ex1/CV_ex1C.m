
% Section C - Canny Edge Detector Evaluation:

%   SCRIPT:
close all;
clear all;
image_dir = strcat(pwd,'/images/');
official_images = ["Nuns.jpg","Church.jpg","Golf.jpg"];
official_ground_truth = ["Nuns_GT.bmp","Church_GT.bmp","Golf_GT.bmp"];

sigma = [2,4,6];
L_th = [0.01, 0.1, 0.3];
H_th = [0.05, 0.5, 0.8];
index = 1;

for i=1:length(official_images)
    for j=1:length(sigma)
        for k=1:length(L_th)
            for l=1:length(H_th)
                image_path = char(strcat(image_dir,string(official_images(i))));
                E_ch=canny(image_path,sigma(j),L_th(k),H_th(l));
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
                params(index,1) = sigma(j);
                params(index,2) = L_th(k);
                params(index,3) = H_th(l);
                index = index+1;
            end
        end
    end
    
    % Take the maximum values
    [maxP,I] = max(P_tot);
    maxP_params(i,:)=params(I,:);
    [maxR,I] = max(R_tot);
    maxR_params(i,:)=params(I,:);
    [maxF,I] = max(F_tot);
    maxF_params(i,:)=params(I,:);
end

display(maxP_params);
display(maxR_params);
display(maxF_params);
    
    
    
    
    