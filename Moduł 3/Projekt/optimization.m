regulator = 1; % 1-DMC, 2-PID
% DMC N=29.000000; Nu=2.000000; lambda=0.010000;

if regulator == 1
    %DMC
    %Ograniczenia dolne parametrów
    lb = [1,1,0.01];
    %Ograniczenia górne parametrów
    ub = [100,100,Inf];
    opts = optimoptions('ga', 'MaxStallGenerations', 100, 'PopulationSize',200); 
    [X,fval,exitflag] = ga(@DMC_optimization,3,[-1 1 0], 0, [], [], lb, ub, [], [1 2] ,opts);
    fprintf('DMC: \nN=%f; Nu=%f; lambda=%f;\n', X)
else
    lb = [0.01, 0.01, 0];
    ub = [50, 1000, 10];
    [X,fval,exitflag] = fmincon(@PID_optimization,[1, 5, 0.01], [], [], [], [], lb, ub);
    fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', X)
end