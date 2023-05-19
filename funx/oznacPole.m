function [hraciPole] = oznacPole(starePole)
%OZNACPOLE Funkce, ktera okolo vygenerovanych bomb vytvori popis
%   pravdepodobnosti, s jakou se v okoli daneho bodu bomba vyskytuje.
%
% Syntax:
%   [hraciPole] = oznacPole(hraciPole)
%       (zvysi hodnoty poli okolo bomb (hodnota nad 66) o jednicku)

[x,y] = size(starePole);

% vytovreni offsetove matice, aby nebylo treba zvlast osetrovat rohy
pomocnaM = zeros(x+2,y+2);
pomocnaM(2:x+1,2:y+1) = starePole;

% priklad po vypoctu, B = 66 v ASCII
% 0  0  0  0  0  0
% 0  1  1  1  0  0
% 0  1  B  2  1  0
% 0  1  2  B  1  0
% 0  0  1  1  1  0
% 0  0  0  0  0  0

for i = 1:x
    for j = 1:y      
        if(starePole(i,j) >= 66)
            for k = 1:3
                for l = 1:3
                   pomocnaM(i+k-1,j+l-1) = pomocnaM(i+k-1,j+l-1) + 1; 
                end
            end
        end
    end
end

hraciPole = pomocnaM(2:x+1,2:y+1);

end
% by krusty at n0p.cz (Krystof Sara), APRG, jaro 2018