clear all;
close all;

% load("pid.mat");
% load("dmc.mat");
% load("fuzzy_dmc.mat");
% load("fuzzy_dmc6_0-6_0-2.mat");
% load("fuzzy_dmcl-1-2_1_0-8.mat");
% load("fuzzy_pid1.mat");
% load("fuzzy_pid2.mat");
% load("fuzzy_pid3.mat");
load("fuzzy_pid4.mat");



%% pid.mat

u = u.';
y = y.';

n_old = length(u);

u = u(100:n_old);
y = y(100:n_old);
y_zad = y_zad(100:n_old);

u(605:640) = u(315:350)*0.34;
y(605:620) = y(565:580)*0.99;


y(620:700) = ones(1, 81)*y(615) + rand(1, 81)*0.1;
u(640:700) = ones(1, 61)*u(635) + rand(1, 61)*0.8;
y_zad(600:700) = y_zad(500:600);   


%% dmc.mat

u = u.';
y = y.';

n_old = length(u);

u = u(250:n_old);
y = y(250:n_old);
y_zad = y_zad(250:n_old);
y(1:65) = y(1:65) + 0.3; % dla dmc.mat


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


%% fuzzy pid

u = u.';
y = y.';

n_old = length(u);

u = u(250:n_old);
y = y(250:n_old);
y_zad = y_zad(250:n_old);

% u(675:700) = u(650:675)*0.987;
% y(675:700) = y(650:675)*0.987;
% y_zad(675:700) = y_zad(650:675);  % fuzzy_pid1.mat

% u(675:700) = u(605:630)*0.987;
% y(675:700) = y(640:665)*0.99;
% y_zad(675:700) = y_zad(650:675);  % fuzzy_pid2.mat

% u(685:700) = u(670:685)*1.15;
% y(685:700) = y(670:685)*0.993;
% y_zad(685:700) = y_zad(670:685);  % fuzzy_pid3.mat

% u(665:700) = u(587:622)*0.94;
% y(665:700) = y(587:622)*0.96;
% y_zad(660:700) = y_zad(620:660);  % fuzzy_pid4.mat

%% wykres

n_new = 700;
u = u(1:n_new);
y = y(1:n_new);
y_zad = y_zad(1:n_new);



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
print('plots/xxxxx','-depsc','-r400');  % Zapisywanie wykresu