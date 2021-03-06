%% Cubli model parameters
T_m=0.005;
K=0.5;
J_w=0.601e-3;
J_f=4.8e-3;
B_w=17.03e-6;
B_f=7.7e-3;
m_w=0.222;
m_f=0.354;
g=9.82;
l_w=0.093;
l_f=0.076;

%% Transfer function of the system
s=tf('s');
G=(-J_w*s^2)/((J_w*s^2+B_w*s)*((J_f+m_w*l_w^2)*s^2+B_f*s-(m_w*l_w+m_f*l_f)*g+((B_w*J_w*s^3)/(J_w*s^2+B_w*s))));
%figure(1);
%rlocus(G);
G_reduced=minreal(G);   % Equal poles and zeros cancelled each other
%sisotool(G_reduced);

%%
clc;
close all;
% % Time domain response
% figure(2);
% impulse(G,0.5);
% figure(3);
% % Comparison beteen G and the model in Simulink (must be the same if we
% % didn't do anything wrong)
% [step_response, t]=step(G,0.2);
% plot(t,step_response);
% hold on;
% plot(StepResponseData.time,StepResponseData.signals.values,'.k');
% title('Step Response');
% xlabel('Time (s)');
% ylabel('Angular Position of the Frame (rad)');
% grid on;
% %set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6);
% legend('Transfer Function Response','Simulation Response','Location','Northeast');
% hold off;

%%
% Frequency domain analysis
figure(4);
bode(G_reduced);

% Analysis in the s-domain
figure(5);
rlocus(-G_reduced);

% Analysis in the z-domain
figure(6);
nyqlog(G_reduced);

%% Nonlinearized model
warning('off');
sim('Model.slx');
figure(7);
plot(init2);
title('Comparison of Linear and Nonlinear Models')
xlabel('Time (s)');
ylabel('Angular position (rad)');
grid on;
legend('Linearized','Nonlinear','Location','Northeast');
axis([0 6 0 6]);
warning('on');

%% Response of the closed loop system
close all;
D=1;
T=D*G_reduced/(1-D*G_reduced);
impulse(T,2);
hold on;
T2=-D*G_reduced/(1-D*G_reduced);
impulse(T2,2);
hold off;

sisotool(G_reduced);
