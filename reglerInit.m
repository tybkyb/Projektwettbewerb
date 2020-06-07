%% Initialisierung des Reglers


%% Zeitbereich

A = [0,                1, 0, 0; ...
     -9.81*(1+ml/0.8), 0, 0, 0.009; ...
     0,                0, 0, 1; ...
     12.26*ml,         0, 0, -0.009];
 
B = [0; -30.49; 0; 30.49];

C = [1, 0, 0, 0; ...
     0, 0, 1, 0];

D = [0; 0];

%% Frequenzbereich

s = tf('s');

G_u_y1 = -s/(0.8*s^3+0.0072*s^2+9.81*(0.8+ml)*s+0.071)/0.041;
G_u_y2 = (s^2+9.81)/(s*(0.8*s^3+0.0072*s^2+9.81*(0.8+ml)*s+0.071))/0.041;