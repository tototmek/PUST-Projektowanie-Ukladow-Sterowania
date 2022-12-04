% Aproksymacja dla toru u -> y
[Xu] = fmincon(@u_y_approx_error, [0.1, 10, 0.5], [], []);
Xu

% Aproksymacja dla toru z -> y
[Xz] = fmincon(@z_y_approx_error, [0.1, 10, 0.5], [], []);
Xz

% Zapisywanie Aproksymowanych odpowiedzi do pliku
T1 = Xu(1);
T2 = Xu(2);
K=Xu(3);
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
T1 = Xz(1);
T2 = Xz(2);
K=Xz(3);
Td=9;
sz(1:1200) = 0;
u(1:1200) = 1;
alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1 * alpha2;
b1 = K*(T1*(1-alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);
for k = Td+3:1200
    sz(k) = b1*u(k - Td - 1) + b2*u(k-Td-2)-a1*sz(k-1)-a2*sz(k-2);
end
save("step_responses_DMC", "s", "sz");
% Rysunki
T1 = Xu(1);
T2 = Xu(2);
K=Xu(3);
Td=9;
y(1:1200) = 0;
u(1:1200) = 1;

[s, sz] = step_response_scaling;
alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1 * alpha2;
b1 = K*(T1*(1-alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:1200
    y(k) = b1*u(k - Td - 1) + b2*u(k-Td-2)-a1*y(k-1)-a2*y(k-2);
end
figure
hold on
stairs(s)
plot(y)
yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))
legend('Wektor \(s\)', 'Aproksymacja', 'Interpreter','latex', Location='southeast');

T1 = Xz(1);
T2 = Xz(2);
K=Xz(3);
Td=9;
y(1:1200) = 0;
u(1:1200) = 1;

alpha1 = exp(-1/T1);
alpha2 = exp(-1/T2);
a1 = -alpha1-alpha2;
a2 = alpha1 * alpha2;
b1 = K*(T1*(1-alpha1)-T2*(1-alpha2))/(T1-T2);
b2 = K*(alpha1*T2*(1-alpha2)-alpha2*T1*(1-alpha1))/(T1-T2);

for k = Td+3:1200
    y(k) = b1*u(k - Td - 1) + b2*u(k-Td-2)-a1*y(k-1)-a2*y(k-2);
end
figure
hold on
stairs(sz)
plot(y)
yl = get(gca,'YTickLabel');
set(gca, 'YTickLabel', strrep(yl(:),'.',','))
legend('Wektor \(s^\mathrm{z}\)', 'Aproksymacja', 'Interpreter','latex', Location='southeast');