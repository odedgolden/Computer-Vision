% Section C - Canny Edge Detector Evaluation:

%   SCRIPT:
close all;
clear all;
image_dir = strcat(pwd,'/images/');
official_images = ["Nuns.jpg","Church.jpg","Golf.jpg"];
official_ground_truth = ["Nuns_GT.bmp","Church_GT.bmp","Golf_GT.bmp"];

sigma = [2,4,6];
L_th = [0.01, 0.1, 0.3];
H_th = [0.05, 0.5, 1];
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
    
    % Take the maximum values - naive
    [maxP,I] = max(Pn_tot);
    maxPVal(i) = maxP;
    maxP_params(i,:)=params(I,:);
    [maxR,I] = max(Rn_tot);
    maxRVal(i) = maxR;
    maxR_params(i,:)=params(I,:);
    [maxF,I] = max(Fn_tot);
    maxFVal(i) = maxF;
    maxF_params(i,:)=params(I,:);
    
    %%%% for shift evaluation %%%%
    [SmaxP,I] = max(P_tot);
    SmaxPVal(i) = SmaxP;
    SmaxP_params(i,:)=params(I,:);
    [SmaxR,I] = max(R_tot);
    SmaxRVal(i) = SmaxR;
    SmaxR_params(i,:)=params(I,:);
    [SmaxF,I] = max(F_tot);
    SmaxFVal(i) = SmaxF;
    SmaxF_params(i,:)=params(I,:);
    
    Pn_tot = Pn_tot - Pn_tot;
    Rn_tot = Rn_tot - Rn_tot;
    Fn_tot = Fn_tot - Fn_tot;
    P_tot = P_tot - P_tot;
    R_tot = R_tot - R_tot;
    F_tot = F_tot - F_tot;
end

%%%% Naive evaluation results %%%%
display('Naive evaluation - best results');
display(maxPVal);
display(maxRVal);
display(maxFVal);

display(maxP_params);
display(maxR_params);
display(maxF_params);

%%%% evaluation results %%%%
display('Evaluation - best results');
display(SmaxPVal);
display(SmaxRVal);
display(SmaxFVal);
    
display(SmaxP_params);
display(SmaxR_params);
display(SmaxF_params);

