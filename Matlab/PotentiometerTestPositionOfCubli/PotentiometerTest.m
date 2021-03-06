%------------------- SETUP FOR FIGURE HOLD & CLEANUP ----------------------
for folding = true
    if exist('a','var') == 1
        if ishandle(a)
            p = get(a, 'Position')
        end
    end
    if exist('b','var') == 1
        if ishandle(b)
        q = get(b, 'Position')
        end
    end

    close all;
    clearvars -except p q
    clc;
end

%% ---------------------- READING DATA FROM FILE --------------------------

data = csvread('PRINT_05.CSV');

time = data(:,1)+5;  %making the time Possitive
voltage = data(:,2);

%% -------------------------- PLOTTING DATA -------------------------------

for folding = true
    if exist('p','var') == 1
        set(0, 'DefaultFigurePosition', p)
    end
end %<--setting figure position

a = figure;
plot(time, voltage, 'linewidth', 1.5);
%%
hold on;

%---------------------- CALCULATING CONSTANT VALUES -----------------------

Vmin =    mean(voltage( 641:1241,1)) %voltage mean from 1.6 to 3.1 in time

Vmax =    mean(voltage(1441:2000,1)) %voltage mean from 3.6 to 10 in time

equVolt = mean(voltage(   2: 441,1)) %voltage mean from 0 to 1.1 in time

middleVolt = ( (Vmax-Vmin)/2 ) +Vmin  %mid-range voltage

%---------------------- PLOTTING REFFERENCE LINES -------------------------

Ymin = zeros(size(voltage))+Vmin;
plot(time, Ymin,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ .2 .2 .2 ]');

Ymax = zeros(size(voltage))+Vmax;
plot(time, Ymax,...
'linestyle', '--', 'linewidth', 1.2, 'color', 'r');

Yequ = zeros(size(voltage))+equVolt;
plot(time, Yequ,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ 0 .6 0 ]');

Ymiddle = zeros(size(voltage))+middleVolt;
plot(time, Ymiddle,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ .6 0 .6 ]');

%% ---------------------------- PLOT SETTINGS -------------------------------

%limmiting the axes
%ylim([-.1 .5])
%xlim([ 0 3 ])

%title and axis labels added
title('Potentiometer Test')
xlabel('Time (s)')
ylabel('Voltage (V)')

%adding legend
legend('Angular movement in volt',...
       'Lower limmit',...
       'Upper limmit',...
       'Equlibrium point',...
       'Mid-range',...
       'Location', 'northwest' )

%setting grid style
grid on, grid minor;
set(gca,'GridLineStyle',':', 'GridColor', 'k', 'GridAlpha', .6)

hold off;

%% ---------------------- FURTHER CALCULATIONS ----------------------------

%Prints out the voltage offset
offsetVolt = middleVolt-equVolt

%Calculating resolution for convertion to rad and deg:
resRad = (1.5769)/(Vmax-Vmin)
resDeg = 90.35/(Vmax-Vmin)

%Calculating 10 deg from equlibrium point on either side:
tenDegFromEquRight = (-10-3.7)/resDeg  +  equVolt  % = 0.1651
tenDegFromEquLeft  = ( 10-3.7)/resDeg  +  equVolt  % = 0.2679

%% ----------------------- GENERAL CONVERTION -----------------------------

%----- TO VOLTAGE ------------------------

%Degrees to Voltage                             % Remember to take the
%Volt = (inputDeg)/resDeg  +  equVolt           % offset (3.7 deg) into
                                                % account (see graphs)
%Radians to Voltage
% Volt = (inputRad)/resRad  +  equVolt


%----- TO ANGLE --------------------------

%Voltage to Degrees
% Deg = (inputVolt - equVolt)*resDeg;

%Voltage to Radians
% Rad = (inputVolt - equVolt)*resRad;


%% -------------------------- EXAMPLE USE ---------------------------------

rad = (data(:,2) - equVolt)*resRad;
deg = (data(:,2) - equVolt)*resDeg;


%% ---------------------- PLOTTING THE EXAMPLE ----------------------------

for folding = true 
    if exist('q','var') == 1
        set(0, 'DefaultFigurePosition', q)
    end
end %<--setting figure position

b = figure;
subplot(1,2,1)
plot(time,deg)
%setting grid style
grid on, grid minor;
set(gca,...
    'GridLineStyle',':',...
    'GridColor', 'k',...
    'GridAlpha', .6,...
    'YTick', (-50:5:50),...
    'YLim', [ -45 55 ],...
    'XLim', [ 0  5 ])
title('Degree Range of Cubli')
xlabel('Time (s)')
ylabel('Degrees (^\circ)')

hold on;%---------- PLOTTING REFFERENCE LINES -----------------------------

YminDeg = (Ymin - equVolt) * resDeg;
plot(time, YminDeg,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ .2 .2 .2 ]');

YmaxDeg = (Ymax - equVolt) * resDeg;
plot(time, YmaxDeg,...
'linestyle', '--', 'linewidth', 1.2, 'color', 'r');

YequDeg = (Yequ - equVolt) * resDeg;
plot(time, YequDeg,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ 0 .6 0 ]');

YmiddleDeg = (Ymiddle - equVolt) * resDeg;
plot(time, YmiddleDeg,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ .6 0 .6 ]');

hold off;%-----------------------------------------------------------------

subplot(1,2,2)
plot(time,rad)
%setting grid style
grid on, grid minor;
set(gca,...
    'GridLineStyle',':',...
    'GridColor', 'k',...
    'GridAlpha', .6,...
    'YTick', (-8:.1:8),...
    'YLim', [ -.79 .95 ],...
    'XLim', [ 0  5 ])
title('Radian Range of Cubli')
xlabel('Time (s)')
ylabel('Radians (rad)')

hold on;%---------- PLOTTING REFFERENCE LINES -----------------------------

YminRad = (Ymin - equVolt) * resRad;
plot(time, YminRad,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ .2 .2 .2 ]');

YmaxRad = (Ymax - equVolt) * resRad;
plot(time, YmaxRad,...
'linestyle', '--', 'linewidth', 1.2, 'color', 'r');

YequRad = (Yequ - equVolt) * resRad;
plot(time, YequRad,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ 0 .6 0 ]');

YmiddleRad = (Ymiddle - equVolt) * resRad;
plot(time, YmiddleRad,...
'linestyle', '--', 'linewidth', 1.2, 'color', '[ .6 0 .6 ]');

hold off;%-----------------------------------------------------------------

set(groot,'DefaultFigurePosition','remove')%<--Resets default fig position