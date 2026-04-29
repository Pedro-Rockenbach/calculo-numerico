clear(); clc();

printf("\nMetodo iterativo de Gauss-Jacobi");
printf("\nResolucao iterativa de sistemas lineares\n");

// Dados de entrada - matriz dos coeficientes e vetor dos termos independentes
A = [4.0, 2.0, -0.3, 0.8;
     0.6, 3.2, -1.8, 0.4;
     0.1, 0.2, 1.0, 0.3;
     0.3, -0.8, -0.3, -0.9];
     
// CORRIGIDO: Ponto e vírgula adicionado para formar vetor coluna corretamente
B = [4.4; 10.0; 4.0; 7.5]; 

printf("Saida - matriz A (original):\n")
disp(A)
printf("Saida - matriz B (original):\n")
disp(B)

n = length(B);
Nmax = 100;
epsilon = 1.0e-6;

// OTIMIZAÇÃO: Usar zeros() evita prender o código a um tamanho fixo de matriz de ordem 4
X0 = zeros(n, 1); 
X = zeros(n, 1);

// Verificação da diagonal principal
for i = 1:n
  if A(i,i) == 0 then
    error("ERRO: elemento nulo na diagonal principal");
  end
end

printf("\nProcesso iterativo...\n");

convergiu = %f;

for k = 1:Nmax
  // 1. Calcula o novo vetor X baseado no vetor anterior X0
  for i = 1:n
    S = 0;
    for j = 1:n
      if i ~= j then
        S = S + A(i,j) * X0(j);
      end
    end
    // APLICAÇÃO DA FÓRMULA DE GAUSS-JACOBI (Faltava esta linha)
    X(i) = (B(i) - S) / A(i,i); 
  end
  
  // 2. Calcula o erro máximo apenas APÓS o vetor inteiro X ser atualizado
  erro = max(abs(X - X0));
  
  // 3. Critério de parada
  if erro < epsilon then
    convergiu = %t;
    break;
  end
  
  // 4. Prepara para a próxima iteração
  X0 = X;
end

// Dados de saída
if convergiu then
    printf("\nSistema convergiu com sucesso na iteracao: %d\n", k);
else
    printf("\nSistema NAO convergiu apos %d iteracoes.\n", Nmax);
end

printf("\nVetor solucao X:\n");
mprintf(" %.6f\n", X);


// falta colocar o erro final
