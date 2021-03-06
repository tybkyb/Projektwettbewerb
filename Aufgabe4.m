%% Aufgabe 4
clear
close

s = tf('s');
ml = 1;
Tmax = 70;
load('K.mat');

%% Initialisiere Übertragungsfunktionen
Guy1 = -s/(.041*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));
Guy2 = (s^2 + 9.81)/(.041*s*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));

a1 = [0.0328,0.0002952,0.723978,0.002911];
b1 = [0,0,-1,0];
a2 = [0.0328,0.0002952,0.723978,0.002911,0];
b2 = [0,0,1,0,9.81];

[A1, B1, C1, D1] = tf2ss(b1,a1);
[A2, B2, C2, D2] = tf2ss(b2,a2);

A = [0, 1, 0, 0;
     -9.81*(1+ml/0.8), 0, 0, .009;
     0, 0, 0, 1;
     12.26*ml, 0, 0, -.009];
B = [0, -30.49, 0, 30.49]';

C = eye(4);
Cb = [1 0 0 0;
      0 0 1 0];
D = [0;0;0;0];

Kp = zpk(-26.2465990577772, -3429.01569082840, -26129.2191287719);
Ks = zpk(-0.4, -11459, 286474.999999292);

% figure
% bode(Guy1)
% figure
% nyquist(Guy1)

pole_zustand = [-1, -2, -3, -4];
pole_beob = pole_zustand(1) * [4, 4.1, 4.2, 4.3];

Kz = place(A, B, pole_zustand);
Kb = place(A', C', pole_beob)';

V =  -1/(C(3,:)*inv(A-B*Kz)*B); 
