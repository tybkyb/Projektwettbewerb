% Simulationen fuer Projektwettbewerb ERT SS2020
% 
% Diese Datei dient als Template fuer die Wettbewerbsaufgabe.
% 
% Bitte Verwenden Sie in Ihrer Simulink-Datei keine Umlaute oder 
% Sonderzeichen. Ansonsten kann es bei der Abgabe Probleme mit dem
% Zeichencode geben.

clear 
close all

%% Parameter 
g = 9.81; %Erdanziehung in m/s^2


%Schlitten
ms = 0.8; % Masse Schlittenin kg
Mmax=0.2; % Maximales Motordrehmoment in Nm
wMmax=17.8; % Maximale Motorumdrehungszahl in rad/s
Pmax=wMmax*Mmax; % Maximale elektrische Motor-Leistung (Watt)
umax=100; % Maximale Leistungsstufe des Motors in Prozent (gross)

%Pendel 
l = 1; %L�nge des Pendels in m
dp = 0; %Reibung des Pendels
phi_max = pi/4; %maximale Auslenkung Pendel



%Rad
ds = 7.2e-3; %Rollwiderstandskoeffizient
r = 0.041; %Radradius in m

%Kran
L = 5; %L�nge des Kranauslegers in m

% Stoerung
Stoerung1 = .1; % .1 = Stoerung ein, 0 = aus
stoerungNoisePower = 1;
rng('shuffle');
stoerungSeed_1 = round((1e4-1)*rand(1));

% Anfangsbedingungen

xStart = 0; % Startposition des Roboters
x_dotStart = 0; % Startgeschwindigkeit des Roboters
phiStart = 0; %Anfaenglicher Pendelwinkel
phi_dotStart = 0; %Startgeschwindigkeit Pendel


%% Initialisierung des Reglers
tic
reglerInit 

IC = [phiStart, phi_dotStart, xStart x_dotStart]; %Vektor mit Anfangsbedingungen 
%% Simulation
tmax = 600; %Maximal erlaubte Zeit in s
tSim = [0 tmax]; % Zeitintervall

sim('roboTemplate',tSim);
disp('Simulation beendet')
toc
disp('Endzeit:')
tout(end,1)
disp('constraint verletzt?')
constraint_violation(1,2)


%% ss
close all

phiSim = yout(:,1);
phidotSim = yout(:,2);
xSim = yout(:,3);
xdotSim = yout(:,4);
xsollSim = yout(:,5); 
xdiffSim = yout(:,6); 

figure('Name','Zustaende')
subplot(2,2,1)
hold all
plot(tout,180/pi*phiSim)
plot([tout(1),tout(end)],[phi_max*180/pi,phi_max*180/pi],'Color','r');
plot([tout(1),tout(end)],[-phi_max*180/pi,-phi_max*180/pi],'Color','r');
title('Pendelwinkel in Grad')
xlabel('time in s')
subplot(2,2,2)
hold all
plot(tout,phidotSim)
title('Drehgeschwindigkeit Pendel in rad/s');
xlabel('time in s')
subplot(2,2,3)
hold all
plot(tout,xSim)
title('Position Schlitten in m');
plot([tout(1),tout(end)],[L/2,L/2],'Color','r');
plot([tout(1),tout(end)],[-L/2,-L/2],'Color','r');
xlabel('time in s')
subplot(2,2,4)
hold all
plot(tout,xdotSim)
title('Geschwindigkeit Schlitten in m/s');
xlabel('time in s')

figure('Name','Referenzposition')
hold all
grid on
plot(tout,xSim)
plot(tout,xsollSim)
legend({'Position', 'Referenzposition'})
title('Position Schlitten und Refernzpositions')
xlabel('time in s')
ylabel('in m')

figure('Name','Abweichung Position')
hold all
grid on
plot(tout,xdiffSim)
title('Differenz zur Referenzposition')
xlabel('time in s')
ylabel('Differenz in m')

