S = load("S.mat", "S");
S = S.S;
ny = 2;
nu = 2;
figure;
for u = 1:nu
    for y = 1:ny
        subplot(ny, nu, (y-1)*nu+u);
        s = zeros(size(S, 3), 1);
        for k = 1:size(S, 3)
            s(k) = S(y, u, k);
        end
        stairs(s);
        ylim([0 0.5]);
        title(sprintf("$s^{%d, %d}$", y, u), "Interpreter", "latex");
        xlabel("$i$", "Interpreter", "latex");
        ylabel(sprintf("$s^{%d, %d}_{i}$", y, u), "Interpreter", "latex");
    end
end