function [E] = DMC_optimization(X)
    D = 100;
    [~,~, E] = DMC_normal(D, X(1), X(2), X(3));
    display(E);
    display(X);
    return 
end