function P=stereo_list(ps1,ps2,ML,MR)
    ClH=null(ML);
    CrH=null(MR);

    Cl=ClH(1:3)./ClH(4);
    Cr=CrH(1:3)./CrH(4);

    MlPsd=pinv(ML);
    MrPsd=pinv(MR);

    pLH=[ps1;ones(size(ps1,2),1)'];
    pRH=[ps2;ones(size(ps2,2),1)'];

    SlH=MlPsd*pLH;
    SrH=MrPsd*pRH;

    Sl=SlH(1:3,:);
    Sr=SrH(1:3,:)./SrH(4,:);

    Ul=Sl-Cl;
    Ur=Sr-Cr;

    for i=1:size(Ul,2)
        A=[Ul(:,i),Ur(:,i)];
        b=Cl-Cr;
        lamda=A\b;
        Pl=Cl+lamda(1)*Ul(:,i);
        Pr=Cr+lamda(2)*Ur(:,i);
        P(:,i)=(Pl-Pr)./2;
    end
end



