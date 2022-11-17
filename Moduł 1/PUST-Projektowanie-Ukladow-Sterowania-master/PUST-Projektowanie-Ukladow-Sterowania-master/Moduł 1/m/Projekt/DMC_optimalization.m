function [E] = DMC_optimalization(X)
    D = 195;
    [~,~, E] = DMC_function(D, X(1), X(2), X(3));
end