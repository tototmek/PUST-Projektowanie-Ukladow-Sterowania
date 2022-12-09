function [K, Ti, Td] = get_pid_params(U, Y)
global Upp Ypp;
Upp = U;
Ypp = Y;
lb = [0.01, 0.01, 0];
ub = [50, 1000, 10];
[X] = fmincon(@PID_normal,[1, 5, 0.01], [], [], [], [], lb, ub);
K = X(1);
Ti = X(2);
Td = X(3);
end