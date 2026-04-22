clear(); clc();

printf("\n Metodo da decomposicao - LU e crout\n")
printf("Resolucao direta de sistema de equacoes lineares \n")

// Dados de entrada - matriz A e vetor B
printf("\nDados de entrada - matriz A e vetor B:\n")
A = [3,2,4; 1,1,2; 4,3,-2]
B = [1;2;3]
T = A // Salva a matriz original para verificacao

printf("\nEntrada - Matriz A (original):\n")
disp(A)

printf("\nEntrada - Vetor B (original):\n")
disp(B)

printf("\nFatoração:\n")
n = length(B);
L = zeros(n,n);
U = zeros(n,n);

// A diagonal de U é unitaria por Crout
for j = 1:n
  U(j,j) = 1;
end
for j = 1:n
  for i = j:n
    SomaLu = 0;
    for k = 1:j-1
      SomaLu = SomaLu + L(i,k)*U(k,j);
    end
    L(i,j) = A(i,j) - SomaLu;
  end
  // Trava de segurança contra divisão por zero
  if L(j,j) == 0 then
      error("Pivô nulo encontrado. O método sem pivoteamento falhou.");
  end
    
  for i = (j+1):n
    SomaLu = 0;
    for k = 1:j-1
      SomaLu = SomaLu + L(i,k)*U(k,j);
    end
    U(j, i) = (A(j, i) - SomaLu) / L(j,j);
  end
end
        
printf("Saida - Fator L:")
disp(L)
printf("Saida - Fator U:")
disp(U)

printf("\n ----------- substituicao progressiva ------------:\n")
Y = zeros(n, 1) // Pre-alocando o vetor X para melhor performance
if L(1,1) == 0 then
  error("Erro: pivo nulo durante a subst progressiva")
end
Y(1) = B(1) / L(1,1)
for i = 2:n
  SomaLY = 0;
    for j = 1:i-1
      SomaLu = SomaLu + L(i,k)*Y(j);
    end
    if L(i,i) == 0 then
      error("Erro: pivo nulo durante a subst progressiva")
    end
    Y(i) = (B(i) - SomaLY) / L(i,i)
end

// Dados de saida - solucao X
printf("\nSolucao y (LY = B) do sistema:\n")
disp(Y);

printf("\nSubstituicao retroativa:\n")
X = zeros(n,1);

X(n) = Y(n);
for i = (n-1:-1:1)
  
  SomaUX = 0;
    for j = (i+1:n)
      SomaUX = SomaUX + U(i,j)*X(j);
    end
    X(i) = Y(i) - SomaUX;
end
printf("\nSolucao X (UX = Y) do sistema:\n")
mprintf(" %.6f\n", X);


printf("\nVerificacao da solucao :\n")
for i = 1:n
    s = 0
    for j = 1:n
        s = s + (T(i,j) * X(j))
        if (j < n) then
            printf("(%d * %.6f) + ", T(i,j), X(j))
        else
        // if (j == n)
            // CORREÇÃO: Substituído o '+' por '=' na última iteração
            printf("(%d * %.6f) = %.6f\n", T(i,j), X(j), s)
        end
    end
end
printf("\nFIM\n")
