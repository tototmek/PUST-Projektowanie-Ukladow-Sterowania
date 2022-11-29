function [E] = DMC_optimization(X)
    D = 140;
    Dz = 80;
    [~,~, E] = DMC_with_error_prediction(D, Dz, X(1), X(2), X(3));
end