clear(); clc();

printf("\nMetodo iterativo de Gauss-Seidel");
printf("\nResolucao iterativa de sistemas lineares\n");

// Dados de entrada - matriz dos coeficientes e vetor dos termos independentes
A = [ 4.0,  2.0, -0.3,  0.8;
      0.6,  3.2, -1.8,  0.4;
      0.1,  0.2,  1.0,  0.3;
      0.3, -0.8, -0.3, -0.9];
B = [ 4.4;  10.0; 4.0;  7.5];
printf("Saida - matriz A (original):\n")
disp(A)
printf("Saida - matriz B (original):\n")
disp(B)

n = length(B);          // dimensão do sistema quadrado
Nmax = 100;             // número máximo de interações
epsilon = 1.06e-6;      // tolerância
X0 = [0; 0; 0; 0];      // aproximação inicial
X = X0;                 // vetor solução interativa
T = A;                  // cópia para verificação final

// Verificação de pivôs nulos na diagonal principal
for i = 1:n
    if A(i,i) == 0 then
        error("ERRO: elemento nulo na diagonal principal.");
    end
end

printf("\n************** Processo Interativo **************:\n");
// Laço princiapl do met. interativo de Gauss-Jacobi
convergiu = %f;
for k = 1:Nmax
  X = X0;
  for i = 1:n
    S1 = 0;
    for j = 1:i-1
      S1 = S1 + A(i,j) * X(j);
    end
    S2 = 0;
    for j = i+1:n
      S2 = S2 + A(i,j) * X0(j);
    end
    X(i) = (B(i) - S1 - S2) / A(i,i);
  end
  erro = max(abs(X-X0));
  if erro < epsilon then
    convergiu = %t;
    break;
  end
  X0 = X;
end

printf("\n Número de interações:");
disp(k);

printf("\n Erro final: %.6e\n", erro);

if convergiu then
    printf("\n O método convergiu dentro da tolerância estabelecida.\n");
else
    printf("\n ATENÇÂO: o método atingiu o número máximo de interações sem convergir.\n");
end

printf("\n Vetor solução do sistema:\n");
mprintf("  %.6f\n", X);

printf("\n****** Verificação da solução, se AX = b *******:\n\n");

for i = 1:n
    s = 0;
    for j = 1:n
        s = s + T(i,j) * X(j);
        if j < n then
            printf("(%.3f*%.3f) + ", T(i, j), X(j));
        end
        if j == n then
            printf("(%.3f*%.3f) = ", T(i,j), X(j));
            printf("%.3f\n", s);
        end
    end
end
