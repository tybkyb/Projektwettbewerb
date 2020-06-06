%% Initialisierung des Reglers
close


ml = 1;
tmax = 100;

s = tf('s');

Guy1 = -s/(.041*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));
Guy2 = (s^2 + 9.81)/(.041*s*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));


A = [0, 1, 0, 0;
     -9.81*(1+ml/0.8), 0, 0, .009;
     0, 0, 0, 1;
     12.26*ml, 0, 0, -.009];
B = [0, -30.49, 0, 30.49]';

C = eye(4);
Cb = [1 0 0 0;
      0 0 0 0;
      0 0 1 0;
      0 0 0 0];
D = [0,0,0,0]';

Kp = zpk(-26, -3429, -26129);
Ks = zpk(-0.4, -11459, 286474);

pole_zustand = [-10, -3, -15, -5];
pole_beob = 5*pole_zustand(3) * [4, 4.1, 4.3, 4.2];

Kz = acker(A, B, pole_zustand);
Kb = place(A', Cb', pole_beob);

V =  -1/(C(3,:)*inv(A-B*Kz)*B); 



