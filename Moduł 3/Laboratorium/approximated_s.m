function [s] = approximated_s(u_id)
    
    function E = simulateResponse(X)
        T1 = X(1);
        T2 = X(2);
        K=X(3);
        Td=9;
        y(1:350) = 0;
        u(1:350) = 1;
        
        s = lokalny_odp_skok(sprintf('step_response_%d.mat', u_id));
        data = load(filename);
        y = data.y;
        u = data.u;
        ypp = y(1) * ones(size(y));
        du = -5;
        s = (y - ypp) / du;
        alpha1 = exp(-1/T1);
        alpha2 = exp(-1/T2);
        a1 = -alpha1-alpha2;
        a2 = alpha1 * alpha2;
        b1 = K*(T1*(1-alpha1)-T2*(1-alpha2))/(T1-T2);
        b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);
        
        for k = Td+3:350
            y(k) = b1*u(k - Td - 1) + b2*u(k-Td-2)-a1*y(k-1)-a2*y(k-2);
        end
        short_s = s(1:350);
        E = sum((short_s - y).^2);
    end


    %options = gaoptimset("StallGenLimit", 100, "PopulationSize", 300);
    [X] = fmincon(@simulateResponse, [0.1, 10, 0.5], [], []);
    display(X)
    T1 = X(1);
    T2 = X(2);
    K=X(3);

    Td=9;
    s(1:1500) = 0;
    u(1:1500) = 1;
    alpha1 = exp(-1/T1);
    alpha2 = exp(-1/T2);
    a1 = -alpha1-alpha2;
    a2 = alpha1 * alpha2;
    b1 = K*(T1*(1-alpha1)-T2*(1-alpha2))/(T1-T2);
    b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);
    
    for k = Td+3:1500
        s(k) = b1*u(k - Td - 1) + b2*u(k-Td-2)-a1*s(k-1)-a2*s(k-2);
    end
    
    save(sprintf('step_response_%d.mat', u_id), "s")

    stairs(s)
    hold on;
    s = lokalny_odp_skok(sprintf('step_response_%d.mat', u_id));
    stairs(s)
end

