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
% load("pid6-45-0_1.mat");
load("alaZiegler.mat");

figure;
subplot(2,1,1);
plot(y1);
hold on;
plot(y2)
hold on;
plot(yzad1, ':', 'LineWidth', 1.3);
hold on;
plot(yzad2, ':', 'LineWidth', 1.3)

xlabel('$k$', 'Interpreter','latex');
legend({'$y1$', '$y2$', '$yzad1$', '$yzad2$'}, 'Interpreter','latex');


subplot(2,1,2);
plot(u1);
hold on;
plot(u2)

xlabel('$k$', 'Interpreter','latex');
legend({'$u1$', '$u2$'}, 'Interpreter','latex');


set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 300]);


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



