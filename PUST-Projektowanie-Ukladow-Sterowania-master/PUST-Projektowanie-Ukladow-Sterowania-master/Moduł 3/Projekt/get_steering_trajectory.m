function y_zad = get_steering_trajectory()
    y_zad(1:50) = 0;
    y_zad(50:250) = 1;
    y_zad(250:450) = 3;
    y_zad(450:650) = 2;
    y_zad(650:850) = -0.15;
    y_zad(850:1000) = 0;
end