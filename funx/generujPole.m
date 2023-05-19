function [hraciPole] = generujPole(rozmerPole, pocetBomb)
%GENERUJPOLE Vygeneruje ctvercove hraci pole s bombami. Maximalni mozny 
%   pocet bomb je dan aritmeticky jako ctverec rozmeru.
%
% Syntax:
%   [hraciPole] = generujPole(5, 5)
%       vygeneruje pole 5x5 s 5 bombami (max. 25 pro tento priklad)

% pri nadmernych vstupech nastavi defaultni hodnoty
if(pocetBomb > (rozmerPole^2) || rozmerPole > 15) 
    rozmerPole = 5;
    pocetBomb  = 5;
end

hraciPole = zeros(rozmerPole, rozmerPole);

% nahodne vygenerovani bomb
for i = 1:pocetBomb
    while(true)
        posX = randi(rozmerPole);
        posY = randi(rozmerPole);
        
        % zajisteni umisteni bomby na unikatni misto
        if(hraciPole(posX, posY) ~= 66)
            hraciPole(posX, posY) = 66; % B v ASCII
            break;
        end
    end
end

end
% by krusty at n0p.cz (Krystof Sara), APRG, jaro 2018