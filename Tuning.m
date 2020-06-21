%% Initialisierung des Reglers
close


ml = 1;
tmax = 100;

s = tf('s');

Guy1 = -s/(.041*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));
Guy2 = (s^2 + 9.81)/(.041*s*(0.8*s^3 + 0.0072*s^2 + 9.81*(0.8 + ml)*s + 0.071));

mdl = 'roboTemplate';
st0 = slTuner(mdl,'MIMO');