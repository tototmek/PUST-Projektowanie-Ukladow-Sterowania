function [E] = DMC_optimization(X)
    D = 230;
    Dz = 110;
    [~,~, E] = DMC(D, Dz, X(1), X(2), X(3));
end