%% Aufgabe 4.3.1

clear all
close all

ml = 1;
reglerInit

% 1)

figure
nyquist(G_u_y2)
figure
bode(G_u_y2)

% ANTWORT: Laut Nyquist stabil, da eine Phasendrehung von 90° vorhanden
% ist, und die Sollphasendrehung 90° beträgt

% 2)
%sisotool(G_u_y2)