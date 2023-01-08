data = load("data/skok_u2.mat");
up = data.u2(1);
uk = data.u2(end);
t_skok = 0;
for i = 1:length(data.u2)-1
    if data.u2(i) < data.u2(i+1)
        t_skok = i;
    end
end
du = uk - up;
y1pp = data.y1(t_skok);
y2pp = data.y2(t_skok);

s1 = (data.y1(t_skok:end) - y1pp) / du;
s2 = (data.y2(t_skok:end) - y2pp) / du;

save("data/skok_u2_scaled.mat", "s1", "s2");