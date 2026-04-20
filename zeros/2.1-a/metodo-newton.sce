clear();clc();
// https://www.wolframalpha.com/input?i=derivative
printf("\n APROXIMAÇÃO PELO MÉTODO NEWTON\n");
deff('y = f(x)', 'y=x^2-3')
deff('y = f1(x)', 'y=2*x')
x_antes = 2.0

epsilon1 = 1e-05
epsilon2 = 1e-05
k = 0
nMax = 100
x_atual = x_antes - f(x_antes) / f1(x_antes) 

printf(" k  |      xk    | abs(xk-xk0) |    f(xk)   |   fl (xk)   \n")
while (k < nMax) & (abs(x_atual - x_antes) > epsilon1) & (abs(f(x_antes)) > epsilon2)
    x_antes = x_atual
    x_atual = x_antes - f(x_antes) / f1(x_antes)
    k = k + 1
    printf(" %2.2i | %10.6f | %10.6f | %10.6f |  %10.6f |\n", k, x_atual, abs(x_atual - x_antes), f(x_antes), f1(x_antes))
end
printf("Aprox. ""%8.6f"" à raíz, com ""%2.2i"" iterações", x_atual, k)


