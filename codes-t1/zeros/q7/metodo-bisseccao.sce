clear();clc();clf();

printf("\n APROXIMAÇÃO PELO MÉTODO DA BISSECÇÃO\n");
deff('y = f(x)', 'y = 25*x^2 + log(x) - 1.5e-6')
ak = 0.2
bk = 0.3

epsilon1 = 1e-06
epsilon2 = 1e-06
k = 0
nMax = 100
xm = 0.5*(ak+bk)

printf(" k  |      xm    | abs(bk-ak) |    f(xm)   |      \n")
while (k < nMax) & (abs(bk - ak) > epsilon1) & (abs(f(xm)) > epsilon2)
    xm = 0.5*(ak + bk)
    k = k + 1
    printf(" %2.2i | %10.6f | %10.6f | %10.6f |\n", k, xm, abs(bk-ak), f(xm))
    if f(ak) * f(xm) < 0 then
        bk = xm
    else
        ak = xm
    end
end
printf("Aprox. ""%8.6f"" à raíz, com ""%2.2i"" iterações", xm, k)
