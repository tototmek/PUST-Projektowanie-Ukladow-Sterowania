clear all;
close all;


% load('./data/step_response_20.mat')
% load('./data/step_response_30.mat')
load('./data/step_response_40.mat')
% load('./data/step_response_50.mat')
% load('./data/step_response_60.mat')
% load('./data/step_response_70.mat')
% load('./data/step_response_80.mat')
% load('./data/step_response_pp.mat')
% load('./data/step_response_for_model.mat')


n = length(y);
U = u*ones(1, n);


hold on;
subplot(2,1,1);
stairs(U, "r");
xlim([0 n])
ylabel('$u$', 'Interpreter','latex');


yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(2,1,2);
stairs(y, "b");
xlim([0 n])
ylabel('$y$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))


set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(gcf,'units','points','position',[100 100 450 300]);
print('plots/zadanie_2_przebieg_40','-depsc','-r400');  % Zapisywanie wykresu


%% Łączny przebieg


data1 = load("./data/step_response_20.mat");
data2 = load("./data/step_response_30.mat");
data3 = load("./data/step_response_40.mat");
data4 = load("./data/step_response_50.mat");
data5 = load("./data/step_response_60.mat");
data6 = load("./data/step_response_70.mat");
data7 = load("./data/step_response_80.mat");


Udata = data1.u*ones(1, length(data1.y));
Ydata = data1.y;
Udata = [Udata data2.u*ones(1, length(data2.y))];
Ydata = [Ydata data2.y];
Udata = [Udata, data3.u*ones(1, length(data3.y))];
Ydata = [Ydata, data3.y];
Udata = [Udata, data4.u*ones(1, length(data4.y))];
Ydata = [Ydata, data4.y];
Udata = [Udata, data5.u*ones(1, length(data5.y))];
Ydata = [Ydata, data5.y];
Udata = [Udata, data6.u*ones(1, length(data6.y))];
Ydata = [Ydata, data6.y];
Udata = [Udata, data7.u*ones(1, length(data7.y))];
Ydata = [Ydata, data7.y];


n = size(Ydata, 2);

hold on;
subplot(2,1,1);
stairs(Udata, "r");
xlim([0 n])
ylabel('$u$', 'Interpreter','latex');


% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(2,1,2);
stairs(Ydata, "b");
xlim([0 n])
ylabel('$y$', 'Interpreter','latex');
xlabel('$k$', 'Interpreter','latex');

% yl = get(gca,'YTickLabel');
% set(gca, 'YTickLabel', strrep(yl(:),'.',','))


set(groot,'defaultAxesTickLabelInterpreter','latex'); 
set(gcf,'units','points','position',[100 100 450 400]);
print('plots/zadanie_2_przebieg_laczny','-depsc','-r400');  % Zapisywanie wykresu