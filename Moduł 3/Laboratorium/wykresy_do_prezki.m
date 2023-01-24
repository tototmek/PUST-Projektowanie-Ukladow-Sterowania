
clear all
data1 = load("fuzzy_pid1.mat");
data2 = load("fuzzy_pid2.mat");
data3 = load("fuzzy_pid3.mat");
data4 = load("fuzzy_pid4.mat");

% Plot the data
% figure(1)
% stairs(data1.y, 'r')
% hold on
% stairs(data2.y, 'g')
% stairs(data3.y, 'b')
% stairs(data4.y, 'k')

% stairs(data1.y_zad, ':', 'Color', [1 0 0])
% stairs(data2.y_zad, ':', 'Color', [0 1 0])
% stairs(data3.y_zad, ':', 'Color', [0 0 1])
% stairs(data4.y_zad, ':', 'Color', [0 0 0])

% stairs(data1.u, '.', 'MarkerSize', 0.2, 'Color', [1 0 0])
% stairs(data2.u, '.', 'MarkerSize', 0.2, 'Color', [0 1 0])
% stairs(data3.u, '.', 'MarkerSize', 0.2, 'Color', [0 0 1])
% stairs(data4.u, '.', 'MarkerSize', 0.2, 'Color', [0 0 0])

% legend('y - nastawy pierwsze', 'y - nastawy drugie', 'y - nastawy trzecie', 'y - nastawy czwarte', 'y zadane - nastawy pierwsze', 'y zadane - nastawy drugie', 'y zadane - nastawy trzecie', 'y zadane - nastawy czwarte', 'u - nastawy pierwsze', 'u - nastawy drugie', 'u - nastawy trzecie', 'u - nastawy czwarte')
% title('Regulator pid rozmyty, strojenie parametrów na laboratorium')




% figure(1)
% subplot(2, 1, 1);
% stairs(data3.y(10:end), 'r')
% hold on

% stairs(data3.y_zad(10:end), ":", 'Color', [0 1 0])
% legend('y', 'y zadane')
% title('E=2139.0')

% subplot(2, 1, 2);
% stairs(data3.u(10:end), 'Color', [0 0 1])
% legend('u')


% set(groot, 'defaultAxesTickLabelInterpreter','latex');

% length = length(data3.y(10:end));

% figure(1)
% subplot(2, 1, 1);
% stairs(data3.y_zad(10:end), ":")
% hold on

% stairs(data3.y(10:end))
% legend('$y^{zad}$', '$y$', location='northwest', interpreter='latex')
% title('$E=3.10\cdot 10^5$', interpreter='latex')
% xlabel('$k$', interpreter='latex');
% ylabel('$y$', interpreter='latex')
% xlim([0 length])

% subplot(2, 1, 2);
% stairs(data3.u(10:end))
% xlim([0 length])
% xlabel('$k$', interpreter='latex')
% ylabel('$u$', interpreter='latex')

% LOSS
close all
pinsize = 4;
pinamplitude = 20;
panelsize = 60;
positions = [
    floor(panelsize/ 6)
    floor(3 * panelsize / 6)
];

y1_0 = 50;
y2_0 = 20;

figure(1)

y1(1:2*panelsize) = 0;
y1(positions(1):positions(1)+pinsize) = pinamplitude;
y1(panelsize+positions(1): panelsize+positions(1)+pinsize) = pinamplitude;
y1(panelsize+positions(2): panelsize+positions(2)+pinsize) = 0.8 * pinamplitude;

y2(1:2*panelsize) = 0;
y2(positions(1): positions(1)+pinsize) = pinamplitude;
y2(positions(2): positions(2)+pinsize) = pinamplitude;

y2(panelsize+positions(1): panelsize+positions(1)+pinsize) = pinamplitude;
y2(panelsize+positions(1)+3*pinsize: end- 4 * pinsize) = pinsize;

for k=1:length(y1)
    y1(k) = y1(k) + 0.3 * randn();
    y2(k) = y2(k) + 0.3 * randn();
end

sys = tf(0.3, [1 0.6 0.3]);
y1_p = lsim(sys, y1, 1:length(y1)) + y1_0;
y2_p = lsim(sys, y2, 1:length(y2)) + y2_0;

for k=1:length(y1_p)
    y1_p(k) = y1_p(k) + 0.3 * randn();
    y2_p(k) = y2_p(k) + 0.3 * randn();
end

stairs(y1_p)
hold on
stairs(y2_p)


