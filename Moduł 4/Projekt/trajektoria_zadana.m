function yzad = trajektoria_zadana()
    % Funkcja zwracająca zadany przebieg wyjść obiektu

    period = 200;
    old_k = 1;
    k = 50;
    yzad1(old_k:k) = 0;
    yzad2(old_k:k) = 0;
    yzad3(old_k:k) = 0;
    old_k = k;
    k = k + period;
    yzad1(old_k:k) = 1;
    yzad2(old_k:k) = 0;
    yzad3(old_k:k) = 0;
    old_k = k;
    k = k + period;
    yzad1(old_k:k) = 1;
    yzad2(old_k:k) = 1;
    yzad3(old_k:k) = 0;
    old_k = k;
    k = k + period;
    yzad1(old_k:k) = 1;
    yzad2(old_k:k) = 1;
    yzad3(old_k:k) = 1;
    old_k = k;
    k = k + period;
    yzad1(old_k:k) = 1;
    yzad2(old_k:k) = 0;
    yzad3(old_k:k) = 1;
    old_k = k;
    k = k + period;
    yzad1(old_k:k) = 0;
    yzad2(old_k:k) = 0;
    yzad3(old_k:k) = 1;
    old_k = k;
    k = k + period;
    yzad1(old_k:k) = 0;
    yzad2(old_k:k) = 0;
    yzad3(old_k:k) = 0;

    yzad = zeros(3, length(yzad1));

    yzad(1, :) = yzad1;
    yzad(2, :) = yzad2;
    yzad(3, :) = yzad3;

end