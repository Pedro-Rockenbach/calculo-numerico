clear();clc();

printf("\n***** Método Iterativo de Gauss-Jacobi (GULOSO) *****\n");
printf(" Resolução iterativa de sistemas lineares \n");

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
Nmax = 100;             // número máximo de iterações
epsilon = 1.0e-6;       // CORREÇÃO 3: Ajuste de digitação na tolerância (era 1.06e-6)
X0 = [0; 0; 0; 0];      // aproximação inicial
X = X0;                 // vetor solução iterativa
T = A;                  // cópia para verificação final

// Verificação de pivôs nulos na diagonal principal
for i = 1:n
    if A(i,i) == 0 then
        error("ERRO: elemento nulo na diagonal principal.");
    end
end

// Funcao gulosa: tenta alinhar os maiores coeficientes com a diagonal
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
  B_greedy = B(ordem); // CORREÇÃO 1: Usando vetor ordem para indexar os valores corretos de B
endfunction

printf("\n Reordenacao gulosa \n");
[A, B, sucesso, ordem_linhas] = reordenar_greedy(A, B);

if sucesso then
  printf("\n Reordenacao gulosa bem sucedida \n");
  printf(" Ordem das linhas escolhida: ");
  disp(ordem_linhas');
  printf("\n Entrada - Matriz A (reordenada):");
  disp(A);
  printf("\n Entrada - Vetor B (reordenado):");
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

printf("\n************** Processo Iterativo **************:\n");
// Laço principal do met. iterativo de Gauss-Jacobi
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

printf("\n Número de iterações:");
disp(k);

printf("\n Erro final: %.6e\n", erro);

if convergiu then
    printf("\n O método convergiu dentro da tolerância estabelecida.\n");
else
    printf("\n ATENÇÃO: o método atingiu o número máximo de iterações sem convergir.\n");
end

printf("\n Vetor solução do sistema:\n");
mprintf("  %.6f\n", X);

printf("\n****** Verificação da solução, se AX = b *******:\n\n");

for i = 1:n
    s = 0;
    for j = 1:n
        s = s + T(i,j) * X(j);
        if j < n then
            printf("(%.3f*%.3f) + ", T(i, j), X(j)); // CORREÇÃO 2: T(i,j) no lugar de A(i,j)
        end
        if j == n then
            printf("(%.3f*%.3f) = ", T(i,j), X(j));  // CORREÇÃO 2: T(i,j) no lugar de A(i,j)
            printf("%.3f\n", s);
        end
    end
end

printf("\n******************** Fim do Gauss-Jacobi guloso ********************\n");
