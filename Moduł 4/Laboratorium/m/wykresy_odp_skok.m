% load("data/poprawny_skok_u1.mat");
load("data/poprawny_skok_u2.mat");
% load("data/punktpracy.mat");

% punkt pracy
% y1 = y1(6:75);
% y2 = y2(6:75);
% u1 = u1(6:75);
% u2 = u2(6:75);

% skok u2
u1 = u1 - 20;
y1 = y1 - 6.2;
y2 = y2 - 3; 


figure;
subplot(2,1,1);
plot(y1);
hold on;
plot(y2)
xlabel('$k$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
% ylim([25, 40]);
ylim([30, 45]);
xlim([1, length(y1)]);

set(gca, 'YTickLabel', strrep(yl(:),'.',','))

% legend({'$y_{1}$', '$y_{2}$'}, 'Interpreter','latex');
legend({'$y_{1}$', '$y_{2}$'}, 'Interpreter','latex', 'Location', 'east');


subplot(2,1,2);
plot(u1);
hold on;
plot(u2)
xlabel('$k$', 'Interpreter','latex');
ylabel('$u$', 'Interpreter','latex');
% ylim([20, 40]);
ylim([20, 55]);
xlim([1, length(y2)]);

set(gca, 'YTickLabel', strrep(yl(:),'.',','))

% legend({'$u_{1}$', '$u_{2}$'}, 'Interpreter','latex');
legend({'$u_{1}$', '$u_{2}$'}, 'Interpreter','latex', 'Location', 'east');



set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 400]);
% print('plots/punkt_pracy','-depsc','-r400');  % Zapisywanie wykresu
% print('plots/odp_skok_u1','-depsc','-r400');  % Zapisywanie wykresu
% print('plots/odp_skok_u2','-depsc','-r400');  % Zapisywanie wykresu

%%

data1 = load("data/poprawny_skok_u1.mat");
data2 = load("data/poprawny_skok_u2.mat");

y11 = data1.y1; % skok u1
y12 = data1.y2; % skok u1
y21 = data2.y1 - 6.2; % skok u2
y22 = data2.y2 - 3; % skok u2

figure;
plot(y11);
hold on;
plot(y12)
hold on;
plot(y21);
hold on;
plot(y22)

xlim([1, length(y21)]);

xlabel('$k$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');

xlabel('$k$', 'Interpreter','latex');
legend({'$y_{11}$', '$y_{12}$', '$y_{21}$', '$y_{22}$'}, 'Interpreter','latex', 'Location', 'northwest');

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 400]);
% print('plots/odp_skok_total','-depsc','-r400');  % Zapisywanie wykresu

%%
clear;

% load("pid3-55-0_1.mat");
load("pid6-45-0_1.mat");

% y1 = y1(281:881);
% y2 = y2(281:881);
% u1 = u1(281:881);
% u2 = u2(281:881);
% yzad1 = yzad1(281:881);
% yzad2 = yzad2(281:881);

figure;
subplot(2,1,1);
plot(y1);
hold on;
plot(y2)
hold on;
plot(yzad1, ':', 'LineWidth', 1.3);
hold on;
plot(yzad2, ':', 'LineWidth', 1.3)
xlim([0 length(y1)])

xlabel('$k$', 'Interpreter','latex');
% legend({'$y1$', '$y2$', '$yzad1$', '$yzad2$'}, 'Interpreter','latex');
legend({'$y_{1}$', '$y_{2}$', '$y_{1}^{zad}$', '$y_{2}^{zad}$'}, 'Interpreter','latex', 'Location', 'southeast');


subplot(2,1,2);
plot(u1);
hold on;
plot(u2)
xlim([0 length(u1)])

xlabel('$k$', 'Interpreter','latex');
legend({'$u_{1}$', '$u_{2}$'}, 'Interpreter','latex', 'Location', 'southeast');


set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 400]);
% print('plots/pid6-45-0_1','-depsc','-r400');  % Zapisywanie wykresu

%% odpowiedzi skokowe s
clear;
% load("data/skok_u1_scaled.mat");
load("data/skok_u2_scaled.mat");

s1 = s1(1:420);
s2 = s2(1:420);

figure;
plot(s1);
hold on;
plot(s2)
xlim([1 length(s1)])
xlabel('$k$', 'Interpreter','latex');
legend({'$s_{21}$', '$s_{22}$'}, 'Interpreter','latex', 'Location', 'northwest');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 300]);
% print('plots/s_u2','-depsc','-r400');  % Zapisywanie wykresu

%%
clear;

% load("pid_chujowy.mat");

load("pid_k7ti1-5td01.mat");
i = 12;

% load("pid_k7ti1td01.mat");
% i = 27;

% load("pid_k8ti1-5td01.mat");
% i = 18;

% load("pid_zaczaldzialack7ti1td01.mat");
% load("pid-pozycyjny-K1.mat");


len = 25;

y = y(i-4:i+len);
u = u(i-4:i+len);
y_zad = y_zad(i-4:i+len);

E = sum((y_zad - y).^2);
display(E);

figure;
subplot(2,1,1);
plot(y);
hold on;
plot(y_zad, ':', 'LineWidth', 1.3);
xlim([1 length(y)])

title(strrep(sprintf("$E=%f$", E),'.',','), 'Interpreter','latex')
xlabel('$k$', 'Interpreter','latex');
legend({'$y$', '$y^{zad}$'}, 'Interpreter','latex', 'Location', 'east');

% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(2,1,2);
plot(u, 'r');
xlim([1 length(u)])

xlabel('$k$', 'Interpreter','latex');
legend({'$u$'}, 'Interpreter','latex', 'Location', 'east');

% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 400]);
print('plots/pid_k7ti1-5td01','-depsc','-r400');  % Zapisywanie wykresu
