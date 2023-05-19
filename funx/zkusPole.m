function zkusPole(posX, posY, hraciPole, gui)
%ZKUSPOLE Funkce pro praci s polem. Zjistuje, co se nachazi na dane pozici
%   herni matice a podle zadanych parametru (poloha X a Y) provede dle 
%   hodnoty v matici danou akci s figurou a handles. Funkce nema vystup.
%
% Syntax: 
%   zkusPole(posX, posY, herniMatice, grafickyHandle)

    tah = hraciPole(posX, posY);

    % na poli se nachazi bomba, zpusobi konec hry
    if(tah >= 66) % B v ASCII
        % deaktivace vsech tlacitek
        [x,y] = size(hraciPole);
        
        for i = 1:y
            for j = 1:x
                set(gui.tlacPole(i,j), 'Enable', 'off', 'Value', 1);
            end
        end
        
        % vypnuti tlacitka pro vlajkovani
        gui.vlajkyTlac.Enable = 'off';
        
        % miniefekt problikani pro game over
        set(gui.fig, 'Color', 'Red');
        set(gui.texty(1), 'ForegroundColor', 'Black');
        set(gui.texty(1), 'BackgroundColor', 'Red');
        pause(0.1);
        set(gui.fig, 'Color', 'Black');
        set(gui.texty(1), 'ForegroundColor', 'Red');
        set(gui.texty(1), 'BackgroundColor', 'Black');
        pause(0.1);
        set(gui.fig, 'Color', 'Red');
        set(gui.texty(1), 'ForegroundColor', 'Black');
        set(gui.texty(1), 'BackgroundColor', 'Red');
        pause(0.1);
        
        % puvodni barva pozadi figury po blikani
        set(gui.fig, 'Color', [0.95 0.95 0.95]); 
        set(gui.texty(1), 'BackgroundColor', [0.95 0.95 0.95]);

        % odkryti vsech bomb a upozorneni hrace na konec hry
        set(gui.tlacPole(hraciPole >= 66), 'String', '*', 'FontSize', 15,...
            'ForegroundColor', [1 0 0], 'Value', 1);
        set(gui.texty(4), 'Visible', 'on', 'String', 'Bomba!');
        
    elseif(tah == 0)
        % kdyz je pole prazdne a v okoli nejsou zadne bomby, odhali okoli
        odhalOkoli(hraciPole, posX, posY, gui);
    else
        % jinak napise na tlacitko pocet bomb v okoli
        set(gui.tlacPole(posX, posY), 'String', tah, 'Enable', 'off', 'Value', 1);
    end
end
% by krusty at n0p.cz (Krystof Sara), APRG, jaro 2018