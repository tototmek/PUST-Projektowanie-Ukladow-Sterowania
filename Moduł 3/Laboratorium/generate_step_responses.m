prev_u = 25;
u_values = [20, 30, 40, 50, 60, 70, 80];
% u_values = [20];

for i = 1:length(u_values)
    data = load(sprintf("step_response_%d.mat", u_values(i)));
    y = data.y;
    y(end:end+1000) = sum(y(end-32:end-1)) / 32;
    ypp = y(1) * ones(size(y));
    du = u_values(i) - prev_u;
    prev_u = u_values(i);
    s = (y - ypp) / du;

    figure;
    hold on;
    plot(s);


    %options = gaoptimset("StallGenLimit", 100, "PopulationSize", 300);
    [X] = fmincon(getFunctionForMinimizing(s), [0.1, 10, 0.5], [], []);
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

    plot(s);
    save(sprintf("s_%d.mat", u_values(i)), "s");
    title(sprintf("u = %d", u_values(i)));
end

function fun = getFunctionForMinimizing(s)
    function E = simulateResponse(X)
        T1 = X(1);
        T2 = X(2);
        K=X(3);
        Td=9;
        y(1:1350) = 0;
        u(1:1350) = 1;
        alpha1 = exp(-1/T1);
        alpha2 = exp(-1/T2);
        a1 = -alpha1-alpha2;
        a2 = alpha1 * alpha2;
        b1 = K*(T1*(1-alpha1)-T2*(1-alpha2))/(T1-T2);
        b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);
        
        for k = Td+3:1350
            y(k) = b1*u(k - Td - 1) + b2*u(k-Td-2)-a1*y(k-1)-a2*y(k-2);
        end
        short_s = s(1:1350);
        E = sum((short_s - y).^2);
    end

    fun = @simulateResponse;
end