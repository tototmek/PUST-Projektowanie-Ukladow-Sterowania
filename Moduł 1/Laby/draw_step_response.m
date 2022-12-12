% Odpowiedzi skokowe
data1 = load("step_response_u30_2.mat");
data2 = load("step_response_u35.mat");
data3 = load("step_response_u40.mat");
data4 = load("step_response_u50.mat");

step1 = data1.step_response - 0.9 * ones(size(data1.step_response));
step4 = data4.step_response - 0.4 * ones(size(data4.step_response));

stairs(step1, 'LineWidth', 1.5);
hold on
stairs(data2.step_response, 'LineWidth', 1.5);
stairs(data3.step_response, 'LineWidth', 1.5);
stairs(step4, 'LineWidth', 1.5);
axis([0 340 32 45]);
xlabel('k');
ylabel('y');

% Ch-ka statyczna
u = [30, 35, 40, 50];
y = [step1(end), data2.step_response(end), data3.step_response(end), step4(end)];
figure;
plot(u, y);