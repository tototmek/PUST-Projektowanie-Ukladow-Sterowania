clear all;

data1 = load("data/skok_u1_scaled.mat");
data2 = load("data/skok_u2_scaled.mat");

y11 = data1.s1;
y21 = data1.s2;
y12 = data2.s1;
y22 = data2.s2;

s_length = min([length(y11) length(y21) length(y12) length(y22)]);

S = zeros(2, 2, s_length);
for i = 1:s_length
    S(1, 1, i) = y11(i);
    S(1, 2, i) = y12(i);
    S(2, 1, i) = y21(i);
    S(2, 2, i) = y22(i);
end

save("S.mat", "S");