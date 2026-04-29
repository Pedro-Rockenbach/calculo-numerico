clear(); clc();

printf("\nMetodo de Thomas -TDMA\n");
printf("REsolucao de sistemas de eq tridiagonais");

a = [0; -1; -1];
b = [2; 2; 2];
c = [-1; -1; 0];
d = [1; 1; 1];


ta = a; tb =b; tc = c; td = d;

printf("\n Entrada - valores colunas a, b, c, d\n");

printf("\n VEtor a:\n");
for i = 1:length(a)
  mprintf("%10.6f\n", a(i));
end

printf("\n VEtor b:\n");
for i = 1:length(b)
  mprintf("%10.6f\n", b(i));
end

printf("\n VEtor c:\n");
for i = 1:length(c)
  mprintf("%10.6f\n", c(i));
end

printf("\n VEtor d:\n");
for i = 1:length(d)
  mprintf("%10.6f\n", d(i));
end

printf("\n Triangularizacao\n");

// Algoritmo de thomas

n = length(b);

if b(1) == 0 then
  error("ERRO: pivo nulo na primeira etapa do met de thomas");
end

c(1) = c(1) / b(1);
d(1) = d(1) / b(1);

for i = 2:n-1
  temp = b(i) - a(i) * c(i-1);
  if temp == 0 then
    error("ERRO: pivo nulo durante a triangulacao do met de thomas");
  end
  c(i) = c(i) / temp;
  d(i) = (d(i) - a(i) * d(i-1)) / temp;
end

temp = b(n) - a(n) * c(n-1);
if temp == 0 then
    error("ERRO: pivo nulo durante a ultima etapa de triangulacao do met de thomas");
end

d(n) = (d(n) - a(n) * d(n-1)) / temp;

printf("\n Saida - VEtor c modificado: \n");
for i = 1:n
    mprintf("%10.6f\n", c(i));
end

printf("\n Saida - VEtor d modificado: \n");
for i = 1:n
    mprintf("%10.6f\n", d(i));
end

printf("\n Retrosubstituicao \n");
X = zeros(n,1);
X(n) = d(n);
for i = (n-1:-1:1)
  X(i) = d(i) - c(i) *X(i + 1);
end

printf("\n Verificacao da solucao, se TX = d :\n\n");

for i = 1:n
  s = 0;
  if i > 1 then
    s = s + ta(i) * X(i-1);
    printf("(%.3f*%.3f) + ", ta(i), X(i-1));
  end
  s = s + tb(i) * X(i);
  if i < n then
    printf("(%.3f*%.3f) = ", tb(i), X(i));
    s = s + tc(i) * X(i+1);
    printf("(%.3f*%.3f) = ", tc(i), X(i+1));
  else
    printf("(%.3f*%.3f) = ", tb(i), X(i));
  end
  printf("%.3f\n", s);
end

printf("\n FIM \n");
