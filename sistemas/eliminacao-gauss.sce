clear();clc();

printf("\nEliminacao de Gauds sem pivoteamento\n")
printf("Resolucao direta de sistema de equações lineares \n")

// ex 3.1
printf("\nDados de entredad - matriz A e vetor B:\n")

A = [3,2,4; 1,1,2; 4,3,-2]
B = [1;2;3]
T=A

printf("\n Entrada - Matriz A (original):")
disp(A)

printf("\n Entrada - Vetor B (original):")
disp(B)

// Printf("\n Dimensao da matrriz:")
// disp(n)

printf("\nTriangulacao:\n")
// Algoritmo de triangulacao
n = length(B)
for k = (1:n-1)
  for i = (k+1:n)
    m = A(i,k)/A(k,k)
    A(i,k) = 0
    for j = (k+1:n)
      A(i,j)= A(i,j) - A(k,j) * m
    end
    B(i) = B(i) - B(k) * m
    //printf("Matriz A")
    //disp(A);
    // printf("Matriz B")
    //disp(B);
  end
end

printf("Saida - matriz A (triangulacao)")
disp(A)
printf("Saida - matriz B (triangulacao)")
disp(B)

printf("Retrosubsitituicao\n")
U=A
C=B
n = length(C)
X(n) = C(n)/U(n,n)
for k = (n-1:-1:1)
  soma = 0
  for j = (k+1:n)
    soma = soma + U(k,j) * X(j)
  end

  X(k) = (C(k) - soma)/U(k,k)
end

// Dados de saida - solucao X, do sistema AX=B
printf("Solucao X do sistema\n")
mprintf(" %.6f\n", [X])

printf("\n Verificao da solucao, se AX = B")

for i=(1:n)
  s = 0
  for j=(1:n)
    s = s+(T(i,j)*X(j))
    if(j<n)
      printf("(%d*%.6f) + ", T(i,j), (X(j)))
    end
    if(j==n)
      printf("(%d*%.6f) + ", T(i,j), (X(j)))
      printf("%.6f\n", s)
    end
  end
end
printf("FIM")

