%% Initialisierung des Reglers
clc
close
clear

% run lagrange.m
lagrange

% set Parameter
ms = 0.8;
ml = ml;
l = 1;
L = 5;
r = 0.041;
kr = 7.2e-3;
g = 9.81;
alpha_max = pi/6;
M_max = 0.2;
w_max = 17.8;
P_max = 3.56;
u_max = 100;


% 4.2.1 Zustandsraumdarstellung
dz = [dphi; solve(eqns(1), ddphi); dx; solve(eqns(2), ddx)];


% 4.2.2 Beschränkungen
x_max = L/2;
phi_max = pi/4;

% 4.2.3 relative Leistung bestimmen

function u = calc_u(Mm, wm)

if nargin == 1
    P = (Mm * 9.434)^2;
    u = 100*P/P_max;
else
    u = 0;
end
end






