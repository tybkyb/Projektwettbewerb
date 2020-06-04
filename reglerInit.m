%% Initialisierung des Reglers
close

ml = 1;

s = tf('s');

A = [0, 1, 0, 0;
     -9.81*(1+ml/0.8), 0, 0, .009;
     0, 0, 0, 1;
     12.26*ml, 0, 0, -.009];
B = [0, -30.49, 0, 30.49]';

Guy1 = -s/(.041*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));
Guy2 = (s^2 + 9.81)/(.041*s*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));


load('K.mat');

figure
bode(Kp*Guy1)
figure
nyquist(Kp*Guy1)


