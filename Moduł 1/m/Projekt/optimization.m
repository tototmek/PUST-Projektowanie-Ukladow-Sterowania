regulator = 2; % 1-DMC, 2-PID



if regulator == 1
    %DMC
    %Ograniczenia dolne parametrów
    lb = [1,1,0.01];
    %Ograniczenia górne parametrów
    ub = [192,192,Inf];
    opts = optimoptions('ga', 'MaxStallGenerations', 80, 'PopulationSize',250); 
    [X,fval,exitflag] = ga(@DMC_optimization,3,[-1 1 0],[0],[],[],lb,ub,[],[1 2],opts);
    fprintf('DMC: \nN=%f; Nu=%f; lambda=%f;\n', X)
else
    lb = [0, 15, 0];
    ub = [5, 100, 0.5];
    opts = optimoptions('ga', 'MaxStallGenerations', 80, 'PopulationSize',250); 
    [X,fval,exitflag] = ga(@PID_optimization,3,[],[],[],[],lb,ub,[],[1 2],opts);
    fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', X)
end