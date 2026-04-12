clear();clc();

printf("\n APROXIMAÇÃO PELa SECANTE\n");
deff('y = f(x)', 'y=x^2-3')
x_antes0 = 1
x_antes1 = 2

epsilon1 = 1e-05
epsilon2 = 1e-05
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

