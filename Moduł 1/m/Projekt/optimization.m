regulator = 2; % 1-DMC, 2-PID



if regulator == 1
    %DMC
    %Ograniczenia dolne parametrów
    lb = [1,1,0.01];
    %Ograniczenia górne parametrów
    ub = [192,192,Inf];
    options = optimoptions('ga', 'MaxStallGenerations', 100, 'PopulationSize',200); 
    [X,fval,exitflag] = ga(@DMC_optimization,3,[-1 1 0],[0],[],[],lb,ub,[],[1 2],options);
    fprintf('DMC: \nN=%f; Nu=%f; lambda=%f;\n', X)
else
    lb = [0, 15, 0];
    ub = [5, 100, 0.5];
    options = optimoptions('ga', 'MaxStallGenerations', 100, 'PopulationSize',200); 
    [X,fval,exitflag] = ga(@PID_optimization,3,[],[],[],[],lb,ub,[],[1 2],options);
    fprintf('PID: \nK=%f; Ti=%f; Td=%f; Ts=0.5;\n', X)
end