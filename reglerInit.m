%% Initialisierung des Reglers
close

ml = 1;

s = tf('s');

A = [0, 1, 0, 0;
     -9.81*(1+ml/0.8), 0, 0, .009;
     0, 0, 0, 1;
     12.26*ml, 0, 0, -.009];
B = [0, -30.49, 0, 30.49]';

C = eye(4);
D = [0;0;0;0];

Kp = zpk(-26.2465990577772, -3429.01569082840, -26129.2191287719);
Ks = zpk(-0.4, -11459, 286474.999999292);

% figure
% bode(Guy1)
% figure
% nyquist(Guy1)

pole_zustand = [-20, -1, -10, -2];
pole_beob = pole_zustand(4) * [4, 4.1, 4.2, 4.3];

Kz = place(A, B, pole_zustand);
Kb = place(A', C', pole_beob);

V =  -1/(C(3,:)*inv(A-B*Kz)*B); 


