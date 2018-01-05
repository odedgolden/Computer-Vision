function [U,V,M,O]=OF(F1,F2, Sigma_S, Region)

%%%% Init varibels %%%%

U=zeros(size(F1));
V=zeros(size(F1));
M=zeros(size(F1));
O=zeros(size(F1));
 
%%%% Spatial smoothing %%%%
F1=imgaussfilt(F1,Sigma_S);
F2=imgaussfilt(F2,Sigma_S);

Ix=conv2(F1,0.25*[-1 1; -1 1],'same');
Iy=conv2(F1,0.25*[-1 -1; 1 1],'same');
It=conv2(F1,0.25*ones(2),'same')+conv2(F2,-0.25*ones(2),'same');

% G_dx=Deriv_Gauss_x(Sigma_S,2*Sigma_S);
% G_dy=Deriv_Gauss_y(Sigma_S,2*Sigma_S);

%Ix=conv2(F1,G_dx,'same');
%Iy=conv2(F1,G_dy,'same');

%%%% Temporal smoothing %%%%
 %TODO
 
%%%% Calculate A and B %%%%
halfReg=round(Region/2);

for row=1+halfReg:size(F1,1)-halfReg
    for col=1+halfReg:size(F1,2)-halfReg
        Ix_t=Ix(row-halfReg:row+halfReg,col-halfReg:col+halfReg);
        Iy_t=Iy(row-halfReg:row+halfReg,col-halfReg:col+halfReg);
        It_t=It(row-halfReg:row+halfReg,col-halfReg:col+halfReg);
        Ix_t=Ix_t(:);
        Iy_t=Iy_t(:);
        It_t=It_t(:);
        A=[Ix_t,Iy_t];
        G=A'*A;
        rankG=rank(G);
        if (rankG<2)
            U(row,col)=0;
            V(row,col)=0;
        else 
            uv=pinv(A'*A)*A'*It_t;
            U(row,col)=uv(1);
            V(row,col)=uv(2);
            M(row,col)=norm(uv);
            O(row,col)=atan(uv(1)./uv(2));
        end
    end
end

end