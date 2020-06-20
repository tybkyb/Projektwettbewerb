clear
close
clc

%load('pendulum_model.mat')
lagrange
syms M z1 z2 z3 z4

%dxdt = statespace_model(M,g, ms, l, r,ds,dp, ml,x,dx,phi,dphi, [phi dphi x dx])

% set Parameter
ms = 0.8;
ml = ml;
l = 1;
L = 5;
r = 0.041;
kr = 7.2e-3;
k_phi = 0;
g = 9.81;
alpha_max = pi/6;
M_max = 0.2;
w_max = 17.8;
P_max = 3.56;
u_max = 100;


% 4.2.1 Zustandsraumdarstellung

eqns = subs(eqns,F, M/r); % F durch M/r ersetzen
dz1 = dphi;
dz2 = solve(eqns(1), ddphi); % nach ddphi lösen
dz3 = dx;
dz4 = solve(eqns(2), ddx); % nach ddx lösen

dz2 = solve(subs(eqns(1), ddx, dz4)-ddphi, ddphi); % ddx einsetzen und lösen
dz4 = solve(subs(eqns(2), ddphi, dz2)-ddx, ddx); % ddphi einsetzen und lösen

dz2s = dz2;
dz4s = dz4;

A = jacobian([dz1, dz2, dz3, dz4],[phi, dphi, x, dx]); % Tailor nach x

B = jacobian([dz1, dz2, dz3, dz4], M); % Tailor nach M

phi = 0;
dphi = 0;
x = 0;
dx = 0;
A = simplify(subs(A));
B = simplify(subs(B));


% 4.2.2 Beschränkungen
x_max = L/2;
phi_max = pi/4;

% 4.2.3 relative Leistung bestimmen

M = -100;

P = sign2(M)*(M/2 * 9.434)^2;
u = 100*P/3.56;


%Berechnung des Motormomentes
P = (u)/100*3.56; %Leistung eines Motors
M_max = sqrt(abs(P))/9.434;

M = 2*sign2(u)*M_max; % Gesamtmoment


function u =  sign2(x)
    if(x == 0) 
        u = -1;
    else
        u = sign(x);
    end
end