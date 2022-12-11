clear all;
%options = gaoptimset("StallGenLimit", 100, "PopulationSize", 300);

[X] = fmincon(@aproximation_optimization, [0.1, 10, 0.5], [], []);
X
T1 = X(1);
T2 = X(2);
K=X(3);

Td=9;
s(1:1200) = 0;
u(1:1200) = 1;
alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1 * alpha2;
b1 = K*(T1*(1-alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);
for k = Td+3:1200
    s(k) = b1*u(k - Td - 1) + b2*u(k-Td-2)-a1*s(k-1)-a2*s(k-2);
end

stairs(s)