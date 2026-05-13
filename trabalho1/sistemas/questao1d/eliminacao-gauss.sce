clear(); clc();

printf("\nEliminacao de Gauss sem pivoteamento\n")
printf("Resolução direta de sistema de equações lineares \n")

// Dados de entrada - matriz A e vetor B
printf("\nDados de entrada - matriz A e vetor B:\n")

A = [ 3, -1,  0,  0;
     -1,  3, -1,  0;
      0, -1,  3, -1;
      0,  0, -1,  3]
B = [2; 1; 1; 2]

T = A // Salva a matriz original para verificacao

printf("\nEntrada - Matriz A (original):\n")
disp(A)

printf("\nEntrada - Vetor B (original):\n")
disp(B)

n = length(B);
printf("\nDimensao da Matriz A: %d x %d\n", n, n);

printf("\nTriangulação:\n")

// Algoritmo de triangulacao
for k = 1:(n-1)
    // Trava de segurança contra divisão por zero
    if A(k,k) == 0 then
        error("Pivô nulo encontrado. O método sem pivoteamento falhou.");
    end
    
    for i = (k+1):n
        m = A(i,k) / A(k,k)
        A(i,k) = 0 // Zera o elemento abaixo do pivô
        
        // OTIMIZAÇÃO: Operação vetorial substituindo o laço 'for j'
        A(i, (k+1):n) = A(i, (k+1):n) - A(k, (k+1):n) * m
        
        B(i) = B(i) - B(k) * m
    end
end

printf("Saida - matriz A (triangulada superior):\n")
disp(A)
printf("Saida - vetor B (escalonado):\n")
disp(B)

printf("\nRetrosubstituição:\n")
U = A
C = B
X = zeros(n, 1) // Pre-alocando o vetor X para melhor performance

X(n) = C(n) / U(n,n)
for k = (n-1):-1:1
    soma = 0
    for j = (k+1):n
        soma = soma + U(k,j) * X(j)
    end
    X(k) = (C(k) - soma) / U(k,k)
end

// Dados de saida - solucao X
printf("\nSolucao X do sistema:\n")
mprintf(" %.6f\n", X)

printf("\nVerificação da solução (T*X = B):\n")
for i = 1:n
    s = 0
    for j = 1:n
        s = s + (T(i,j) * X(j))
        if (j < n) then
            // AJUSTE: %d trocado por %.3f para evitar conflito de tipo de dado
            printf("(%g * %.6f) + ", T(i,j), X(j))
        else
            // AJUSTE: %d trocado por %.3f
            printf("(%g * %.6f) = %.6f\n", T(i,j), X(j), s)
        end
    end
end
printf("\nFIM\n")
