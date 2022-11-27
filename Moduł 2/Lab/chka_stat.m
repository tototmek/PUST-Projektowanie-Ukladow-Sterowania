% Odpowiedzi skokowe
data1 = load("step_response_z30.mat");
data2 = load("step_response_z45.mat");
data3 = load("step_response_z60.mat");

stairs(data1.step_response);
hold on
stairs(data2.step_response);
stairs(data3.step_response);
axis([0 600 32 49]);
xlabel('k');
ylabel('y');

% Ch-ka statyczna
z = [30, 45, 60];
y = [data1.step_response(end), data2.step_response(end), data3.step_response(end)];
figure;
plot(z, y, "Marker", "o");