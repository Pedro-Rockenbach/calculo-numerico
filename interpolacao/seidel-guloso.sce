clear(); clc();

printf("\n***** Metodo iterativo de Gauss-Seidel (GULOSO) *****\n");
printf(" Resolucao iterativa de sistemas lineares\n");

// Dados de entrada - matriz dos coeficientes e vetor dos termos independentes
A = [ 4.0,  2.0, -0.3,  0.8;
      0.6,  3.2, -1.8,  0.4;
      0.1,  0.2,  1.0,  0.3;
      0.3, -0.8, -0.3, -0.9];
B = [ 4.4;  10.0; 4.0;  7.5];

printf("\n ***** Dados de Entrada - Matriz A e vetor B *****:\n");
printf("\n Entrada - Matriz A (original):\n");
disp(A)
printf("\n Entrada - Vetor B (original):\n");
disp(B)

n = length(B);          // dimensão do sistema quadrado
Nmax = 100;             // número máximo de interações
epsilon = 1.0e-6;       // tolerância (corrigido pequeno typo de 1.06e-6)
X0 = zeros(n,1);        // aproximação inicial (otimizado para aceitar qualquer tamanho de N)
X = X0;                 // vetor solução interativa
T = A;                  // cópia da matriz original para verificação final (ANTES de reordenar)

// Funcao gulosa: tenta alinhar os maiores coeficientes com a diagonal principal
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
  B_greedy = B(ordem); // Reordena o vetor B acompanhando a matriz A
endfunction

printf("\n Reordenacao gulosa \n");
[A, B, sucesso, ordem_linhas] = reordenar_greedy(A, B);

if sucesso then
  printf("\n Reordenacao gulosa bem sucedida \n");
  printf(" Ordem das linhas escolhida: ");
  disp(ordem_linhas');
  printf("\n Entrada - Matriz A (reordenada):\n");
  disp(A);
  printf("\n Entrada - Vetor B (reordenado):\n");
  disp(B);
else
  error("Erro: nao foi possivel fazer a reordenacao gulosa");
end

// Verificação de pivôs nulos na diagonal principal APÓS a reordenação
for i = 1:n
    if A(i,i) == 0 then
        error("ERRO: elemento nulo na diagonal principal.");
    end
end

printf("\n************** Processo Iterativo **************:\n");
// Laço principal do met. iterativo de Gauss-Seidel
convergiu = %f;
for k = 1:Nmax
  X = X0; // Necessário no Seidel para garantir que o resto do vetor não se perca
  for i = 1:n
    S1 = 0;
    for j = 1:i-1
      S1 = S1 + A(i,j) * X(j); // Valores já atualizados na iteração atual
    end
    S2 = 0;
    for j = i+1:n
      S2 = S2 + A(i,j) * X0(j); // Valores da iteração anterior
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

printf("\n Número de interações: ");
disp(k);

printf("\n Erro final: %.6e\n", erro);

if convergiu then
    printf("\n O método convergiu dentro da tolerância estabelecida.\n");
else
    printf("\n ATENÇÃO: o método atingiu o número máximo de interações sem convergir.\n");
end

printf("\n Vetor solução do sistema:\n");
mprintf("  %.6f\n", X);

printf("\n****** Verificação da solução, se AX = b *******:\n\n");

// A prova real precisa sempre ser com a matriz original (T)
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

printf("\n******************** Fim do Gauss-Seidel guloso ********************\n");
