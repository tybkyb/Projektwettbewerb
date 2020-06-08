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

poles = [-3, -2, -10, -4];
poles_beob = 3*poles;

k = place(A, B, poles);
e = place(A',C',poles_beob).';

v = -1/(C(2,:)/(A-B*k)*B); % Vorfilter
%% Frequenzbereich

s = tf('s');

G_u_y1 = -s/(0.8*s^3+0.0072*s^2+9.81*(0.8+ml)*s+0.071)/0.041;
G_u_y2 = (s^2+9.81)/(s*(0.8*s^3+0.0072*s^2+9.81*(0.8+ml)*s+0.071))/0.041;

K_x = 804.09*(s+7.053)/(s+226.9); % Über sisotool berechnet
[K_x_num, K_x_den] = tfdata(K_x, 'v');

K_phi = -5*(s+1)/(s+100);
[K_phi_num, K_phi_den] = tfdata(K_phi, 'v');