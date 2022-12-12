data = load("step_response_for_model.mat");
old_s = data.step_response;
ypp = 34.12;
upp = 25;
uk = 40;


du = uk - upp;
Y_pp = ypp * ones(size(old_s));

s = (old_s - Y_pp) / du;

stairs(s);
