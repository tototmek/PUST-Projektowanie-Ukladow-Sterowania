% load("data/poprawny_skok_u1.mat");
% load("data/poprawny_skok_u2.mat");
% load("data/punktpracy.mat");

figure;
subplot(2,1,1);
plot(y1);
hold on;
plot(u1)

xlabel('$k$', 'Interpreter','latex');
legend({'$y1$', '$u1$'}, 'Interpreter','latex');


subplot(2,1,2);
plot(y2);
hold on;
plot(u2)

xlabel('$k$', 'Interpreter','latex');
legend({'$y2$', '$u2$'}, 'Interpreter','latex');


set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 300]);

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

xlabel('$k$', 'Interpreter','latex');
legend({'$y11$', '$y12$', '$y21$', '$y22$'}, 'Interpreter','latex');

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
