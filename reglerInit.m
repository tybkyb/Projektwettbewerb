%% Initialisierung des Reglers
close


ml = 1;
tmax = 100;

s = tf('s');

Guy1 = -s/(.041*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));
Guy2 = (s^2 + 9.81)/(.041*s*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));
Kb = [];
for ml = 1:5
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
    
    Q = [780 0 0 0;
         0 0 0 0;
         0 0 120 0;
         0 0 0 42];
    Q_s =[975 0 0 0;
          0 10 0 0;
          0 0 98 0;
          0 0 0 70];
    Q_r =[1 0 0 0;
         0 1 0 0;
         0 0 10000 0;
         0 0 0 1];
    R = 0.00001;

    Kp = zpk(-26, -3429, -26129);
    Ks = zpk(-0.4, -11459, 286474);
    
    
    pole_zustand = [-3, -2.5, -200, -2.6];
    pole_beob = pole_zustand(3) * [3.1, 3.3, 3.5, 3.7];
    
    Kz(ml,:) = acker(A, B, pole_zustand);
    Kb = [Kb ;place(A', Cb', pole_beob)'];
    
    
    Kz(ml,:) = lqr(A, B, Q, R);
    Kz_s(ml,:) = lqr(A, B, Q_s, R);
    Kz_r(ml,:) = lqr(A, B, Q_r, R);
     %Kz(ml,:) = acker(A, B, pole_zustand);
     %Kz_s(ml,:) = acker(A, B, pole_zustand);
     %Kz_r(ml,:) = acker(A, B, pole_zustand);
    
    V(ml) =  -1/(C(3,:)*((A-B*Kz(ml,:))\B));
    V_s(ml) =  -1/(C(3,:)*((A-B*Kz_s(ml,:))\B));
    V_r(ml) =  -1/(C(3,:)*((A-B*Kz_r(ml,:))\B));

end

% A = [0, 1, 0, 0;
%          -9.81*(1+ml/0.8), 0, 0, .009;
%          0, 0, 0, 1;
%          12.26*ml, 0, 0, -.009];
%     B = [0, -30.49, 0, 30.49]';
% 
%     C = eye(4);
%     Cb = [1 0 0 0;
%           0 0 0 0;
%           0 0 1 0;
%           0 0 0 0];
%       D = [0,0,0,0]';
% pole_zustand = [-3, -2.5, -200, -3];
% pole_beob = pole_zustand(3) * [3.1, 3.3, 3.5, 3.7];
% Kz = acker(A, B, pole_zustand);
%  Kb = place(A', Cb', pole_beob)';
%  V =  -1/(C*((A-B*Kz)\B));
%  Kp = zpk(-26, -3429, -26129);
%  Ks = zpk(-0.4, -11459, 286474);