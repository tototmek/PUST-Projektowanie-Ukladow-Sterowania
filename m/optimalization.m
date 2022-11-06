% lb = [0.01,1,0.01];
lb = [0, 0, 0];
% ub = [7, 7, 7];
% ub = [Inf, Inf, Inf];
ub = [10, 10, 10];
% opts = optimoptions('fmincon', 'MaxStallGenerations', 100, 'PopulationSize', 300);
[X,fval,exitflag] = fmincon(@PID_optimalization,[1,1,1],[],[],[],[],lb,ub);
fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', X)

% regulator = 2;
% 
% if regulator == 1
%     [X,fval,exitflag] = fmincon(@PID_optimalization,[1,1,1],[],[],[],[],lb,ub);
%     fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', X)
% else
%     [X,fval,exitflag] = fmincon(@DMC_optimalization,[1,1,1],[],[],[],[],lb,ub);
%     fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', X)
% end