z = [30, 45, 60]';
y = [39.1200, 42.2500, 45.3700]';

x = [z ones(3, 1)];
w = x\y;

fprintf("y = %.4fz + %.4f\n", w(1),  w(2));
