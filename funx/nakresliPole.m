function nakresliPole(hraciPole)
% NAKRESLIPOLE Komplexni funkce, ktera obstarava veskerou grafiku hry 
%   a praci s ni. Vstupni promennou je pouze maticove pole vygenerovane 
%   pomoci funkce generujPole a oznacene funkci oznacPole. Vystupem je GUI.
%
% Syntax:
%   nakresliPole(herniMatice)
%   (Optimalizovano pro MacBook Pro 13" bez Retiny s macOS 10.12.6).

% nacteni zakladnich hodnot pro spravne vygenerovani a umisteni figury
[x,y] = size(hraciPole);
obrazovka = get(0);
obrazovka = obrazovka.ScreenSize;

% deklarace statickeho poctu bomb a dynamickeho poctu vlajek
pocetBomb = sum(sum(hraciPole >= 66));
pocetVlajek = 0;

% vyska = odsazeni od vrchu + velikost pole + misto pod polem
% sirka = odsazeni vlevo + pole + misto pro tlacitka vpravo
vyska = 40*x + 80;
sirka = 40*y + 230;

% hlavni okno hry
fig = figure('NumberTitle', 'off', 'Name', 'Miny',...
    'Position', [obrazovka(3)/2-(sirka/2) (obrazovka(4)/2)-vyska/2 sirka vyska],...
    'Color', [0.95 0.95 0.95], 'MenuBar', 'None', 'ToolBar', 'None', 'Resize', 'off');

tlacitka = gobjects(x,y);     % handle pro tlacitka pole
texty    = gobjects(4,1);     % handle pro texty

% ramecek okolo tlacitek napravo
uicontrol('Style', 'Frame', 'Position', [40*y+35 (vyska-210) 180 200],...
    'BackgroundColor', [0.85 0.85 0.85]);

% textova pole
texty(1) = uicontrol('Style', 'Text',...
    'String', ['Zbyvajici: ' num2str(pocetBomb)], ...
    'Position', [10 (vyska-55)-(x*40) 120 30],...
    'BackgroundColor', [0.95 0.95 0.95],...
    'FontSize', 15);
texty(2) = uicontrol('Style', 'Text',...
    'String', 'Rozmer:', ...
    'Position', [40*y+40 vyska-40 70 20],...
    'BackgroundColor', [0.85 0.85 0.85],...
    'FontSize', 12);
texty(3) = uicontrol('Style', 'Text',...
    'String', 'Bomby: ', ...
    'Position', [40*y+40 vyska-70 70 20],...
    'BackgroundColor', [0.85 0.85 0.85],...
    'FontSize', 12);
texty(4) = uicontrol('Style', 'Text',...
    'String', '',...
    'Visible', 'off', ...           % behem hry je schovano
    'Position', [40*y+72 vyska-260 100 45],...
    'BackgroundColor', [0.95 0.95 0.95],...
    'FontSize', 20, ...
    'ForegroundColor', [1 0 0]);

% tlacitka a rolety
% nastaveni rozmeru roletkou, vyber je zjistovan pomoci Value (1-3)
% nastveni hodnoty vychazi z defaultniho nastaveni hry, kdy jsou samotne
% hodnoty poctu bomb a rozmer nasobky cisla 5
rozmerTlac = uicontrol('Style', 'Popupmenu',...
    'String', {'5x5','10x10','15x15'}, ...
    'Position', [40*y+80+20 (vyska-40) 100 20],...
    'Value', round(x/5));

% nastaveni poctu bomb roletkou
bombyTlac = uicontrol('Style', 'Popupmenu',...
    'String', {'5','10','15','20'}, ...
    'Position', [40*y+80+20 (vyska-65) 100 15],...
    'Value', round(pocetBomb/5));

% tlacitko pro novou hru, nemusi byt oznaceno
uicontrol('Style', 'pushbutton',...
    'String', 'Nova hra',...
    'Position', [40*y+80+5 (vyska-100) 80 20],...
    'Callback', @zacniNovouHru);

% oznaceni pole vlajkou, Value = 1 (zamacknuto) znamena rezim vlajkovani
vlajkyTlac = uicontrol('Style', 'Togglebutton',...
    'String', 'Vlajka', ...
    'Position', [40*y+80+5 (vyska-160) 80 20]);

% tlacitko pro ukonceni hry, neni treba jej pojmenovavat
uicontrol('Style', 'pushbutton',...
    'String', 'Konec',...
    'Position', [40*y+80+5 (vyska-190) 80 20],...
    'Callback', @zavriOkno);

% vygenerovani grafickeho pole tlacitek
for i = 1:y
    for j = 1:x
        % tlacitka jsou tesne u sebe, lisi se vzdy o svou velikost 40x40 px
        souradX = 20 + 40*(j-1);
        souradY = (vyska-50) - 40*(i-1);
        
        tlacitka(i,j) = uicontrol('Style', 'Togglebutton',... 
            'String', '',...
            'Position', [souradX souradY 40 40],...
            'BackgroundColor', [1 1 1],...
            'ForegroundColor', [0 180/255 0],...
            'FontSize', 15,...
            'UserData', [i j],...
            'Callback', @odezvaTlacitek,...
            'ButtonDownFcn', @vlajkobrani);
    end
end

% sdruzujici struktura vsech grafickych objektu pro snadnejsi manipulaci
gui.fig             = fig;
gui.tlacPole        = tlacitka;
gui.texty           = texty;
gui.vlajkyTlac      = vlajkyTlac;
gui.rozmerRolo      = rozmerTlac;
gui.bombyRolo       = bombyTlac;

    % hlavni funkce pro praci s tlacitky pole
    function odezvaTlacitek(src, ~)
        % ziskani hodnot souradnic z parametru tlacitka
        posX = src.UserData(1);
        posY = src.UserData(2);
        
        % zjisteni, jestli je zapnut rezim vlajkovani
        switch(gui.vlajkyTlac.Value)
            case 0
                % rezim vlajkovani je vypnut
                % zjisti hodnotu na miste kliku v herni matici hraciPole
                % pokud je na poli vlajka, pole se po kliknuti neodkryje,
                % nejprve musi byt vlajka odstranena
                if(get(src, 'String') == 'F')
                    set(src, 'Value', 0);
                else
                    zkusPole(posX, posY, hraciPole, gui);
                end
            case 1
                % rezim vlajkovani je zapnut
                if(get(src, 'String') == 'F')
                    pocetVlajek = pocetVlajek - 1;
                    set(src, 'String', '', 'Value', 0);
                    set(gui.texty(1), 'String', ['Zbyvajici: ' num2str(pocetBomb-pocetVlajek)]);
                else
                    % vlajek musi byt mene nez bomb, jinak vlajkovat dal nejde
                    if(pocetVlajek < pocetBomb)
                        pocetVlajek = pocetVlajek + 1;
                        set(src, 'String', 'F', 'Value', 0);
                        set(gui.texty(1), 'String', ['Zbyvajici: ' num2str(pocetBomb-pocetVlajek)]);
                        
                        if(pocetVlajek == pocetBomb)
                            % pokud uz je vlajek stejne jako bomb, dalsi pridat
                            % nejde a tlacitko vlajkovani se samo vypne
                            set(gui.vlajkyTlac, 'Value', 0);
                        end
                    end
                end
        end
        
        % overeni pruchodu hrou pomoci poctu jiz klikanych tlacitek
        if(sum([gui.tlacPole.Value]) == x*y-pocetBomb)
            set(gui.texty(4), 'Visible', 'on', 'String', 'Vyhra!');
            
            % vypnuti tlacitka pro vlajkovani
            gui.vlajkyTlac.Enable = 'off';
            
            % pro efekt odhali vsechny bomby
            set(gui.tlacPole(hraciPole >= 66), 'String', '*', 'FontSize', 15,...
                'ForegroundColor', [1 0 0], 'Value', 1);
                
            % vypnuti vsech tlacitek
            for k = 1:y
                for l = 1:x
                    set(gui.tlacPole(k,l), 'Enable', 'off');
                end
            end
        end
    end

    % dodatkova funkce pro vlajkovani pravym tlacitkem mysi
    function vlajkobrani(src, ~)
        if(strcmp(get(gui.fig, 'SelectionType'), 'alt') && src.Value == 0)
            if(get(src, 'String') == 'F')
                pocetVlajek = pocetVlajek - 1;
                set(src, 'String', '', 'Value', 0);
                set(gui.texty(1), 'String', ['Zbyvajici: ' num2str(pocetBomb-pocetVlajek)]);
            else
                if(pocetVlajek < pocetBomb)
                    pocetVlajek = pocetVlajek + 1;
                    set(src, 'String', 'F', 'Value', 0);
                    set(gui.texty(1), 'String', ['Zbyvajici: ' num2str(pocetBomb-pocetVlajek)]);
                end
            end
        end
    end

    % funkce pro ukonceni hry
    function zavriOkno(~, ~)
        close all;
    end

    % funkce pro nastaveni nove hry
    function zacniNovouHru(~, ~)
        novaHra(gui.rozmerRolo.Value, gui.bombyRolo.Value);
    end

end
% by krusty at n0p.cz (Krystof Sara), APRG, jaro 2018