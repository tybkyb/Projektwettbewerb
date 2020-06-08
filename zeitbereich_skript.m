clear all
close all

ml = 1;
reglerInit


C = eye(4);
D = [0; 0; 0; 0];

poles = [-10, -2, -40, -3];

k = place(A, B, poles);

v = -1/(C(3,:)/(A-B*k)*B);

z0 = [0, 0, 0, 0];