function Vstr =Classify_vowel( t,x )

E = Spectral_band_energy(t,x); %Create vector of band energy of input
%Start at top of tree, create vector for energy at first graph comparison 
m = Vowel_metrics( E, 1, 1); 
%This section of code iterates through decision tree    
[indx, dmin] = Nearest_neighbor(m,[0.0250 0.0026; 0.0024    0.0009]);
if indx == 1 %its red, black, or blue
    m = Vowel_metrics(E, 2, 1);
    [indx, dmin] = Nearest_neighbor(m, [0.0250    0.0026; 0.0024    0.0009]); 
    if indx == 1 %Final color is Red!!!
        Vstr = 'i';
    else
        m = Vowel_metrics(E, 3, 1)
        [indx, dmin] = Nearest_neighbor(m, [0.0004 0.0021; 0.0005 0.0006])
        
        if indx == 2 %Final color is Black
            Vstr = 'o';
        else %Final color is Blue
            Vstr = 'a';
        end 
    end
else %color is green or cyan
    m = Vowel_metrics(E, 2, 2);
    [indx, dmin] = Nearest_neighbor(m, [0.0018 0.0009; 0.0018 0.0012]);
    if indx == 2 % color is Green  
        Vstr = 'e';
    else %color is cyan!
        Vstr = 'u';
    end
end

end

