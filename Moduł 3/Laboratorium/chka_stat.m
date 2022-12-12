clear all;

data1 = load("./data/step_response_20.mat");
data2 = load("./data/step_response_30.mat");
data3 = load("./data/step_response_40.mat");
data4 = load("./data/step_response_50.mat");
data5 = load("./data/step_response_60.mat");
data6 = load("./data/step_response_70.mat");
data7 = load("./data/step_response_80.mat");

u(1) = data1.u;
y(1) = data1.y(end);
u(2) = data2.u;
y(2) = data2.y(end);
u(3) = data3.u;
y(3) = data3.y(end);
u(4) = data4.u;
y(4) = data4.y(end);
u(5) = data5.u;
y(5) = data5.y(end);
u(6) = data6.u;
y(6) = data6.y(end);
u(7) = data7.u;
y(7) = data7.y(end);

figure;
plot(u, y);
hold on;
plot(u, y, 'o');
ylabel('$y$', 'Interpreter','latex');
xlabel('$u$', 'Interpreter','latex');

% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))


set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(gcf,'units','points','position',[100 100 450 300]);
% print('plots/zad_2_chka_stat','-depsc','-r400');  % Zapisywanie wykresu

