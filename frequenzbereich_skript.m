%% Aufgabe 4.3.1 %%

clear all
close all

ml = 1;
reglerInit

%% 1)

% figure
% nyquist(G_u_y2)
% figure
% bode(G_u_y2)

% ANTWORT: Laut Nyquist ist der geschlossene Kreis stabil, da eine Phasen-
% drehung von 90° vorhanden ist, und die Sollphasendrehung 90° beträgt.

%% K_x
%sisotool(G_u_y2)
[G_num, G_den] = tfdata(G_u_y2, 'v');

K_x = 1200*(s+7.053)/(s+226.9); % Über sisotool berechnet
[K_x_num, K_x_den] = tfdata(K_x, 'v');

%% K_phi

% nyquist(-1*G_u_y1)

K_phi = -5*(s+1)/(s+100);
[K_phi_num, K_phi_den] = tfdata(K_phi, 'v');