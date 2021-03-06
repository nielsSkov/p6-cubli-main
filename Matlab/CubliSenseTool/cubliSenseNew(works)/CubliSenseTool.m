clear all
close all
clc

%% Cubli model parameters
T_m=0.005;
K=0.5;
J_w=0.601e-3;
J_f=(2.8e-3);
B_w=17.03e-6;
B_f=6.08e-3;
m_w=0.222;
m_f=0.354;
g=9.82;
l_w=0.093;
l_f=0.076;

%%
%for the last part of the signal:
pendulumData = csvread('pendulum.CSV', 709, 0, [ 709 0 1300 1 ]); %row 709 to 1300
%simulation time: 5.91
%initial condition: 0.1487

%for whole signal:
%pendulumData = csvread('pendulum.CSV', 72, 0, [ 72 0 1072 1 ]); %row 72 to 1072
%simulation time: 10
%initial condition: -pi/4

%for the last part of the signal:
t = pendulumData(:,1)'+2.91;

%for whole signal:
%t = pendulumData(:,1)'+10-.72;


Yvolt = pendulumData(:,2);

u = zeros(size(Yvolt));
uin = [ t' u ];

% Data from Volt to rads
Vmin=0.004316370106762;
Vmax=0.466679601990048;
equVolt=0.215324792013310;  
middleVolt=0.235497986048405;

offsetVolt = middleVolt-equVolt+.004;
resRad = (pi/2)/(Vmax-Vmin);
y = (Yvolt - middleVolt + offsetVolt)*resRad;

scatter(t',y)

%%
par0 = [ B_f J_f ];% m_f l_f ];

Ynew = simCubli(u,t,par0);

%hold on;
%plot(t, Ynew);
%hold off;

save measCubli t u y %creating measTestName

process = 'Cubli';


%%

run mainest.m


%% PLOTTING IT PRETTILY :)

a = get(findall(gcf, 'Type', 'line', 'color', '[0.8500 0.3250 0.0980]'));
Ynew = a.YData;

figure;
scatter(t', y, 'r')
hold on
plot(t', Ynew, 'b', 'LineWidth', 1.4)
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)

title('Parameter Estimation using Sense Tool')
xlabel('Time (s)')
ylabel('Angle (rad)')

hold off




