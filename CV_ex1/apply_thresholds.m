function E = apply_thresholds(E_high, E_low, G_orientation, L_th)
n = length(E_low);
m = length(E_low(:,1));

for i = 2 : m-3
    for j = 2 : n-3
        if (mod(G_orientation(i,j),180)==135)
            maximum =  max(E_high(i-1,j+1),E_high(i+1,j-1));
            if (maximum>L_th)
                E_high(i,j) = E_low(i,j);
            end
            
        elseif (mod(G_orientation(i,j),180)==0)
            maximum =  max(E_high(i+1,j),E_high(i-1,j));
            if (maximum>L_th)
                E_high(i,j) = E_low(i,j);
            end
            
        elseif (mod(G_orientation(i,j),180)==45)
            maximum =  max(E_high(i-1,j-1),E_high(i+1,j+1));   
            if (maximum>L_th)
                E_high(i,j) = E_low(i,j);
            end
            
        else % mod(G_orientation(i,j),180)==0
            maximum =  max(E_high(i,j+1),E_high(i,j-1));    
            if (maximum>L_th)
                E_high(i,j) = E_low(i,j);
            end
        end
    end
end

E = E_high;
end
