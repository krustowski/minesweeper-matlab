function novaHra(ctverec, bomby)
%NOVAHRA Funkce volana z GUI, ktera zajisti spusteni nove hry s novym
%   nastavenim. Na vstup prichazi hodnoty z dynamickych prvku GUI, proto
%   se museji transformovat pomoci switche. Funkce nema zadny vystup. 
%
% Syntax:
%   novaHra(ctverec, bomby)

% zavre figuru s predchozi hrou
close all;

% urceni spravneho rozmeru ctverce pole ze vstupu
switch(ctverec)
    case 1
        ctverec = 5;
    case 2
        ctverec = 10;
    case 3
        ctverec = 15;
end

% analogie predchoziho switche
switch(bomby)
    case 1
        bomby = 5;
    case 2
        bomby = 10;
    case 3
        bomby = 15;
    case 4
        bomby = 20;
end

% kondenzace tri hlavnich funkci v jedno volani, ktere nastavi novou hru
nakresliPole(oznacPole(generujPole(ctverec, bomby)));

end
% by krusty at n0p.cz (Krystof Sara), APRG, jaro 2018