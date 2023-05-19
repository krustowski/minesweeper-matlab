function odhalOkoli(hraciPole, pX, pY, gui)
%ODHALOKOLI Funkce inspirovana algoritmem Flood-Fill, ktera zajistuje, ze 
%   po kliknuti na prazdne pole o souradnicich X a Y se odhali vsechna 
%   pole okolo, kde nejsou bomby. Funkce nema vystup.
%
% Syntax:
%   odhalOkoli(herniPole, X, Y, grafickyHandle)

% rozmerove parametry pro kontrolu, zda se cykly nachazi uvnitr matice
[a,b] = size(hraciPole);

% Flood-Fill-like funkce
for i = -1:1
    for j = -1:1
        
        % pocatecni souradnice vlevo nahore od vstupniho prvku
        x = pX+i;
        y = pY+j;
        
        if(x > 0 && y > 0 && x <= a && y <= b)
            
            % nutne overeni, zda je pole jeste nekliknute a nulove, jinak 
            % zpusobi zacykleni
            if hraciPole(x, y) == 0 && strcmp(gui.tlacPole(x, y).Enable, 'on') && ~strcmp(gui.tlacPole(x, y).String, 'F')
                set(gui.tlacPole(x, y), 'String', '', 'Enable', 'off', 'Value', 1);
                hraciPole(x, y) = 9;
                
                % rekurzivni volani
                odhalOkoli(hraciPole, x, y, gui);
                continue;
                
            elseif(hraciPole(x, y) < 66 && hraciPole(x, y) ~= 9 && ...
                    strcmp(gui.tlacPole(x, y).String, '') &&...
                    strcmp(gui.tlacPole(x, y).Enable, 'on'))
                set(gui.tlacPole(x, y), 'String', hraciPole(x, y), 'Enable', 'off', 'Value', 1); 
                continue;
            end
        end
    end
end

end
% by krusty at n0p.cz (Krystof Sara), APRG, jaro 2018