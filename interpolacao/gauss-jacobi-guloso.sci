clear();clc();

printf("\n***** Método Interativo de Gauss-Jacobi(GULOSO) *****\n");
printf(" Resolução interativa de sistemas lineares \n");

// Dados de entrada - Matriz dos coeficientes e vetor dos termos independentes
A = [0.1, 0.2, 1.0, 0.3;
     0.2, -0.8, -0.3, -0.9;
     4.0, 2.0, -0.3, 0.8;
     0.6, 3.2, -1.8, 0.4];
B = [4.0; 7.5; 4.4; 10.0];

printf("\n ***** Dados de Entrada - Matriz A e vetor B *****:\n");
printf("\n Entrada - Matriz A (original):");
disp(A);
printf("\n Entrada - Vetor B (original):");
disp(B);

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

// Funcao gulosa: tenta linhar os mairoes coeficientes com a diagonal
function [A_greedy, B_greedy, sucesso, ordem] = reordenar_greedy(A, B)
  n = size(A,1);
  usados = zeros(n,1);
  ordem = zeros(n,1);
  sucesso = %T;
  for j = 1:n
    maior = -%inf;
    linha_melhor = -1;
    for i = 1:n
      if usados(i) == 0 then
        if abs(A(i,j)) > maior then
          maior = abs(A(i,j));
          linha_melhor = i;
        end
      end
    end
    if linha_melhor == -1 then
      sucesso = %F;
      A_greedy = A;
      B_greedy = B;
      return;
    end
    ordem(j) = linha_melhor;
    usados(linha_melhor) = 1;
  end
  A_greedy = A(ordem, :);
  B_greedy = B(ordem);
endfunction

printf("\n Reordenacao gulosa \n");
[A, B, sucesso, ordem_linhas] = reordenar_greedy(A, B);

if sucesso then
  printf("\n Reordenacao gulosa bem sucedida \n");
  printf(" Ordem das linhas escolhida: ");
  disp(ordem_linhas');
  printf("\n Entrada - Matriz A (original):");
  disp(A);
  printf("\n Entrada - Vetor B (original):");
  disp(B);
else
  error("Erro nao foi possivel fazer a gulosa");
end

// Verificacao de pivos nulos na diagonal principal apos reordenacao
for i = 1:n
  if A(i,i) == 0 then
    error("Erro")
  end
end

printf("\n************** Processo Interativo **************:\n");
// Laço princiapl do met. interativo de Gauss-Jacobi
convergiu = %f;
for k = 1:Nmax
    for i = 1:n
        S = 0;
        for j = 1:n
            if i ~= j then
                S = S + A(i,j) * X0(j);
            end
        end
        X(i) = (B(i) - S) / A(i,i);
    end
    erro = max(abs(X - X0));
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
            printf("(%.3f*%.3f) + ", A(i, j), X(j));
        end
        if j == n then
            printf("(%.3f*%.3f) = ", A(i,j), X(j));
            printf("%.3f\n", s);
        end
    end
end

printf("\n******************** Fim do Gauss-Jacobi guloso ********************\n");
