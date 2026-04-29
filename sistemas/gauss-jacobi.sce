clear(); clc();

printf("\nMEtodo iterativo de gauss-jacobi");
printf("\n Resolucao iterativa de sistemas lineares\n");

// ex 3.10
// Dados de entrada - matriz dos coeficientes e vetor dos termos independesntes
A = [4.0, 2.0, -0.3, 0.8;
     0.6, 3.2, -1.8, 0.4;
     0.1, 0.2, 1.0, 0.3;
     0.3, -0.8, -0.3, -0.9];
B = [4.4; 10.0; 4.0 7.5];
//*
A = [0.1, 0.2, 1.0, 0.3;
     0.2, -0.8, -0.3, -0.9;
     4.0, 2.0, -0.3, 0.8;
     0.6, 3.2, -1.8, 0.4];
B = [4.0; 7.5; 4.4; 10.0];
*/

printf("Saida - matriz A (original):\n")
disp(A)
printf("Saida - matriz B (original):\n")
disp(B)

n = length(B);
Nmax = 100;
epsilon = 1.0e-6;
X0 = [0; 0; 0; 0];
X = X0;
T = A;

for i = 1:n
  if A(i,i) == 0 then
    error("ERRO: elemento nulo na diagonal principal");
  end
end

printf("\n Processo iterativo");

// foto

for i = 1:n
  if A(i,i) == 0 then
    error("Elemento nulo na diagonal")
  end
end
printf("\nMEtodo iterativo\n");

convergiu = %f;
for k = 1:Nmax
  for i = 1:n
    S = 0;
    for j = 1:n
      if i ~= j then
        S = S + A(i,j) * X0(j);
      end
    end
    erro = max(abs(X - X0));
    if erro < epsilon then
      convergiu = %t
      break
    end
    X0 = X;
  end

printf("\n Numero de interacoes")
disp(k);

printf("\n")
