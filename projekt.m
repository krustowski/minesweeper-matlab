% projekt.m      
% inicializacni skript, ktery dava hru dohromady
% staci stisknout F5 (Run)

% Miny (ver 2.5)
% pokus o vlastni verzi kultovni videohry Minesweeper

% hlavni funkce:
%  generujPole()     - vygenerovani pole danych rozmeru s danym poctem bomb
%  oznacPole()       - oznaceni poli okolo bomb
%  nakresliPole()    - graficka funkce, obsahuje dalsi vlastni funkce
%  zkusPole()        - zjistovani hodnot daneho pole podle herni matice
%  novaHra()         - funkce volana z GUI, ktera nastavi novou hru
%  odhalOkoli()      - funkce podobna algoritmu FloodFill na odhaleni
%                      volnych poli

clear all;  % obrana proti interferenci
close all;  % zavre vsechny figury, kdyby nahodou
clc;

% toolbox
addpath('./funx');

% defaultni nastaveni hry
rozmerPole = 5; % ctverec
pocetBomb  = 5;

% vygenerovani poli
[hraciPole] = generujPole(rozmerPole, pocetBomb);
                          
% prirazeni pravdepodobnostnich hodnot okolo bomb
hraciPole = oznacPole(hraciPole);

% spusteni GUI
nakresliPole(hraciPole);

% by krusty at n0p.cz (Krystof Sara), APRG, jaro 2018