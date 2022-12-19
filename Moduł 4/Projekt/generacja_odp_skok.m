% Skrypt generujący odpowiedzi  skokowe do wykorzystania w DMC

% Symulacja obiektu
s_u1 = odp_skok(1, 0, 0, 0);
s_u2 = odp_skok(0, 1, 0, 0);
s_u3 = odp_skok(0, 0, 1, 0);
s_u4 = odp_skok(0, 0, 0, 1);

% Inicjalizacja macierzy odpowiedzi skokowych
d = length(s_u1{1});
ny = 3;
nu = 4;
s = zeros(d, ny, nu);

% Zapisanie odpowiednich komórek macierzy danymi
s(:, 1, 1) = s_u1{1};
s(:, 2, 1) = s_u1{2};
s(:, 3, 1) = s_u1{3};
s(:, 1, 2) = s_u2{1};
s(:, 2, 2) = s_u2{2};
s(:, 3, 2) = s_u2{3};
s(:, 1, 3) = s_u3{1};
s(:, 2, 3) = s_u3{2};
s(:, 3, 3) = s_u3{3};
s(:, 1, 4) = s_u4{1};
s(:, 2, 4) = s_u4{2};
s(:, 3, 4) = s_u4{3};

% Rysowanie wyniku
figure;
for u = 1:nu
    for y = 1:ny
        subplot(ny, nu, (y-1)*nu+u);
        stairs(s(:, y, u));
        ylim([0 2]);
        title(sprintf("$s^{%d, %d}$", y, u), Interpreter="latex");
        xlabel("$i$", Interpreter="latex");
        ylabel(sprintf("$s^{%d, %d}_{i}$", y, u), Interpreter="latex");
    end
end

function s = odp_skok(u1_p, u2_p, u3_p, u4_p)
    % Funkcja generuje odpowiedź skokową wszystkich wyjść 
    % dla skoku od 0 do zadanych wartości u
    n=150;

    u1(1:4)=0;
    u2(1:4)=0;
    u3(1:4)=0;
    u4(1:4)=0;
    u1(5:n)=u1_p;
    u2(5:n)=u2_p;
    u3(5:n)=u3_p;
    u4(5:n)=u4_p;

    y1(1:n)=0;
    y2(1:n)=0;
    y3(1:n)=0;

    for k=5:n
    [y1(k), y2(k), y3(k)] = symulacja_obiektu5y_p4(...
        u1(k-1), u1(k-2), u1(k-3), u1(k-4), ...
        u2(k-1), u2(k-2), u2(k-3), u2(k-4), ...
        u3(k-1), u3(k-2), u3(k-3), u3(k-4), ...
        u4(k-1), u4(k-2), u4(k-3), u4(k-4), ...
        y1(k-1), y1(k-2), y1(k-3), y1(k-4), ...
        y2(k-1), y2(k-2), y2(k-3), y2(k-4), ...
        y3(k-1), y3(k-2), y3(k-3), y3(k-4));
    end

    s = {y1(5:end), y2(5:end), y3(5:end)};
end