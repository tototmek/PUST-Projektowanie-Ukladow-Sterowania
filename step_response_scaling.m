old_s = load("step_response").step_response;
ypp = 34;
upp = 25;
uk = 40;


du = uk - upp;
Ypp = ypp * ones(size(old_s));

s = (old_s - Ypp) / du;

stairs(s);