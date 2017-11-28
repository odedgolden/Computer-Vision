function Et = thinning(G_magnitude, G_orientation)
n = length(G_magnitude);
m = length(G_magnitude(:,1));
zero = min(G_magnitude(:));
Et = G_magnitude - G_magnitude;
for i = 2 : m-3
    for j = 2 : n-3
        if (abs(mod(G_orientation(i,j),180))==45)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i-1,j+1),G_magnitude(i+1,j-1)));
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
            
        elseif (abs(mod(G_orientation(i,j),180))==90)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i+1,j),G_magnitude(i-1,j)));
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
            
        elseif (abs(mod(G_orientation(i,j),180))==135)
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i-1,j-1),G_magnitude(i+1,j+1)));   
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
            
        else % mod(G_orientation(i,j),180)==90
            maximum =  max(G_magnitude(i,j),max(G_magnitude(i,j+1),G_magnitude(i,j-1)));    
            if (maximum<=G_magnitude(i,j))
                Et(i,j) = G_magnitude(i,j);
            end
        end
    end
end
end
