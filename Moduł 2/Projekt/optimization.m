%DMC
%Ograniczenia dolne parametrów
lb = [1,1,0.01];
%Ograniczenia górne parametrów
ub = [100,100,Inf];
opts = optimoptions('ga', 'MaxStallGenerations', 100, 'PopulationSize',200); 
[X,fval,exitflag] = ga(@DMC_optimization,3,[-1 1 0],[0],[],[],lb,ub,[],[1 2],opts);
fprintf('DMC: \nN=%f; Nu=%f; lambda=%f;\n', X)