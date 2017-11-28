%%% Q3 %%%

im1=imread('Church_GT.bmp');
im2=imread('Golf_GT.bmp');
im3=imread('Nuns_GT.bmp');
file_name=['Church.jpg','Golf.jpg','Nuns.jpg'];

L_th = [0.01, 0.1, 0.3];
H_th = [0.05, 0.5, 0.8];
sigma = [2,4,6];
index = 1;

%%% Church
for i=1:3
    for j=1:3
        for k=1:3
            E_ch=canny('Church.jpg',sigma(i),L_th(j),H_th(k));
            E_ch=uint8(E_ch);
            [Pn,Rn,Fn] = evaluate_naive(E_ch,im1);
            [P,R,F] = evaluate(E_ch,im1);
            Pn_tot(index) = Pn;
            Rn_tot(index) = Rn;
            Fn_tot(index) = Fn;
            P_tot(index) = P;
            R_tot(index) = R;
            F_tot(index) = F;
            params(index,1) = sigma(i);
            params(index,2) = L_th(j);
            params(index,3) = H_th(k);
            index = index+1;
        end
    end
end

[maxP_Ch,I] = max(P_tot);
maxP_Ch_params=params(I,:);
[maxR_Ch,I] = max(R_tot);
maxR_Ch_params=params(I,:);
[maxF_Ch,I] = max(F_tot);
maxF_Ch_params=params(I,:);


%%% Golf
for i=1:3
    for j=1:3
        for k=1:3
            E_g=canny('Golf.jpg',sigma(i),L_th(j),H_th(k));
            E_g=uint8(E_g);
            [Pn,Rn,Fn] = evaluate_naive(E_g,im2);
            [P,R,F] = evaluate(E_g,im2);
            Pn_tot(index) = Pn;
            Rn_tot(index) = Rn;
            Fn_tot(index) = Fn;
            P_tot(index) = P;
            R_tot(index) = R;
            F_tot(index) = F;
            params(index,1) = sigma(i);
            params(index,2) = L_th(j);
            params(index,3) = H_th(k);
            index = index+1;
        end
    end
end

[maxP_G,I] = max(P_tot);
maxP_G_params=params(I,:);
[maxR_G,I] = max(R_tot);
maxR_G_params=params(I,:);
[maxF_G,I] = max(F_tot);
maxF_G_params=params(I,:);


%%% Nuns
for i=1:3
    for j=1:3
        for k=1:3
            E_n=canny('Nuns.jpg',sigma(i),L_th(j),H_th(k));
            E_n=uint8(E_n);
            [Pn,Rn,Fn] = evaluate_naive(E_n,im3);
            [P,R,F] = evaluate(E_n,im3);
            Pn_tot(index) = Pn;
            Rn_tot(index) = Rn;
            Fn_tot(index) = Fn;
            P_tot(index) = P;
            R_tot(index) = R;
            F_tot(index) = F;
            params(index,1) = sigma(i);
            params(index,2) = L_th(j);
            params(index,3) = H_th(k);
            index = index+1;
        end
    end
end

[maxP_N,I] = max(P_tot);
maxP_N_params=params(I,:);
[maxR_N,I] = max(R_tot);
maxR_N_params=params(I,:);
[maxF_N,I] = max(F_tot);
maxF_N_params=params(I,:);






    
    
    
    
    