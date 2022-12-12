clear all;
close all;

% load("pid.mat");
% load("dmc.mat");
% load("fuzzy_dmc.mat");
% load("fuzzy_dmc6_0-6_0-2.mat");
% load("fuzzy_dmcl-1-2_1_0-8.mat");
% load("fuzzy_pid1.mat");
load("fuzzy_pid2.mat");
% load("fuzzy_pid3.mat");
% load("fuzzy_pid4.mat");



%% pid.mat

u = u.';
y = y.';

n_old = length(u);

u = u(100:n_old);
y = y(100:n_old);
y_zad = y_zad(100:n_old);

n_new = length(u);


%% dmc.mat

u = u.';
y = y.';

n_old = length(u);

u = u(250:n_old);
y = y(250:n_old);
y_zad = y_zad(250:n_old);
y(1:65) = y(1:65) + 0.3; % dla dmc.mat

n_new = length(u);


%% fuzzy dmc

u = U;
y = Y;
y_zad = Y_zad;

u = u.';
y = y.';

n_old = length(u);

u = u(250:n_old);
y = y(250:n_old);
y_zad = y_zad(250:n_old);
% y(1:65) = y(1:65) + 0.3; % dla dmc.mat

n_new = length(u);


%% fuzzy pid

u = u.';
y = y.';

n_old = length(u);

u = u(250:n_old);
y = y(250:n_old);
y_zad = y_zad(250:n_old);

n_new = length(u);


%% wykres


E = sum((y_zad - y).^2);
display(E);

subplot(2,1,1);
stairs(y);
hold on;
stairs(y_zad,':');
xlabel('$k$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
title(strrep(sprintf("$E=%f$", E),'.',','), 'Interpreter','latex')
legend({'$y$', '$y^{zad}$'}, 'Interpreter','latex');
xlim([0 n_new])


subplot(2,1,2);
stairs(u, "r");
xlabel('$k$', 'Interpreter','latex');
ylabel('$u$', 'Interpreter','latex');
legend('$u$', 'Interpreter','latex');
xlim([0 n_new])


set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 400]);
% print('plots/zadanie_4/zad_4_wersja_D140_N10_Nu2_L0001','-depsc','-r400');  % Zapisywanie wykresu