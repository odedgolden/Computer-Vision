function p=proj(P,M)
    hom = [P; 1];
    p_h = M*hom;  
    p = round(p_h(1:2)./p_h(3))
