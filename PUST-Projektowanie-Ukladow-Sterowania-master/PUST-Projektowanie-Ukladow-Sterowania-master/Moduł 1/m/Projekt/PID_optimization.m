function [E] = PID_optimization(X)
    [~,~, E] = PID_function(X(1), X(2), X(3));
end

