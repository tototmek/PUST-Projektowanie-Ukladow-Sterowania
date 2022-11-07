options = gaoptimset("StallGenLimit", 100, "PopulationSize", 300);
[X] = fmincon(@aproximation_optimization, [3, 2, 1], [], []);
X

