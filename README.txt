README soubor k projektu Miny
-------------------------------------------
-------------------------------------------

Nazev projektu:   Miny (ver 2.5)
Autor:            Krystof Sara (ID: 203205)
Predmet:          APRG, jaro 2018
Obor:             A-BTB, 1. rocnik
Odevzdano:        25. 04. 2018

-------------------------------------------

Seznam souboru:

projekt.m
README.txt
vyvojove_diagramy.pdf
funx/generujPole.m
funx/oznacPole.m
funx/nakresliPole.m
funx/zkusPole.m
funx/novaHra.m
funx/odhalOkoli.m

-------------------------------------------

Strucny popis:

Jedna se o vlastni verzi kultovni videohry
Minesweeper. Projekt se sklada z hlavniho
skriptu "projekt.m", kterym se cely program
spousti. Funkce potrebne pro spravny chod
a start programu se nachazeji ve slozce
"funx", ktera je ve stejnem adresari jako
tento soubor.
Popis jednotlivych funkci je uveden v je-
jich zahlavich a lze je zobrazit klasickym
"help funkce" v prostredi MATLAB.

-------------------------------------------

Historie verzi:

1.0 - jednoducha CLI verze
2.0 - pridana GUI verze, vlajkovani poli
2.5 - odebrana verze CLI, optimalizace ko-
      du, podpora praveho tlacitka pro fci
      vlajkovani; zasadni fce odhalOkoli()

-------------------------------------------

Known issues:

Pri kliknuti na prazdne pole vetsich rozme-
ru (typicky u 15x15) dochazi k neocekavane-
mu grafickemu glitchi, ktery zpusobi, ze 
nektera pole zustavaji neodkryta. 
Problem se da zahnat kliknutim mimo okno
projektu.
Tento problem byl zatim pozorovan pouze na
platforme macOS 10.12.6.

-------------------------------------------
-------------------------------------------
krusty at n0p.cz, 2018
(written in VIM 7.4.8056)
