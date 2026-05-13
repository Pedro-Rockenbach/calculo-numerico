clear();clc();

printf("\n APROXIMAÇÃO PELO MÉTODO DA SECANTE\n");

deff('y = f(x)', 'y = 25*x^2 + log(x) - 1.5e-6')

x_antes0 = 0.2
x_antes1 = 0.3

epsilon1 = 1e-06
epsilon2 = 1e-06
k = 0
nMax = 100
x_atual = x_antes1 - f(x_antes1)* (x_antes1-x_antes0) / (f(x_antes1)-f(x_antes0))

printf(" k  |      xk    | abs(xk-x1) |    f(xk)   |\n")
while (k < nMax) & (abs(x_atual - x_antes1) > epsilon1) & (abs(f(x_atual)) > epsilon2)
    x_antes0 = x_antes1
    x_antes1 = x_atual
    x_atual = x_antes1 - f(x_antes1)*(x_antes1-x_antes0) / (f(x_antes1)-f(x_antes0))

    k = k + 1
    printf(" %2.2i | %10.6f | %10.6f | %10.6f |\n", k, x_atual, abs(x_atual - x_antes1), f(x_atual))
end
printf("Aprox. ""%8.6f"" à raíz, com ""%2.2i"" iterações", x_atual, k)

