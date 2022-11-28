function [s, sz] = step_response_scaling()
    data = load("z_step_response_for_model.mat");
    old_sz = data.step_response;
    ypp = 33.67;
    zpp = 0;
    zk = 60;
    dz = zk - zpp;
    Y_pp = ypp * ones(size(old_sz));
    sz = (old_sz - Y_pp) / dz;

    data = load("step_response_for_model.mat");
    old_s = data.step_response;
    ypp = 34.12;
    upp = 25;
    uk = 50;
    du = uk - upp;
    Y_pp = ypp * ones(size(old_s));
    s = (old_s - Y_pp) / du;
end