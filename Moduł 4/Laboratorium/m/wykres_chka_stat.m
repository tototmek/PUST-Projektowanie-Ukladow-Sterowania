load("data/chka-stat.mat");

y = y(1:880);
u = u(1:880);

figure;
subplot(2,1,1);
plot(y);
xlim([1 length(y)])
xlabel('$k$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
legend({'$y$'}, 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))


subplot(2,1,2);
plot(u, 'r');
ylim([-1.1 1.1])
xlim([1 length(u)])
xlabel('$k$', 'Interpreter','latex');
ylabel('$u$', 'Interpreter','latex');
legend({'$u$'}, 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 400]);
print('plots/odp_skok_servo','-depsc','-r400');  % Zapisywanie wykresu


U = [];
Y = [];
Y_period = [];
counter = 1;

for i=1:length(u)-1
    if (counter > 10)
        Y_period(end+1) = y(i);
    end

    if u(i+1) ~= u(i)
        U(end+1) = u(i);
        Y(end+1) = mean(Y_period);
        Y_period = [];
        counter = 0;
    end

    counter = counter + 1;
end

U(end+1) = u(end);
Y(end+1) = mean(Y_period);

U(12) = [];
Y(12) = [];

U = sort(U);
Y = sort(Y);

display(U);
display(Y);


figure;
plot(U, Y)
hold on;
plot(U, Y, 'o')
xlabel('$u$', 'Interpreter','latex');
ylabel('$y$', 'Interpreter','latex');
% legend({'$y$'}, 'Interpreter','latex');

yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))

xl = get(gca,'XTickLabel');
set(gca, 'XTickLabel', strrep(xl(:),'.',','))

set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(gcf,'units','points','position',[100 100 450 350]);
print('plots/chka_stat','-depsc','-r400');  % Zapisywanie wykresu






