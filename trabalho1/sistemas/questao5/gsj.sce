clear(); clc();

printf("\n********** METODOS ITERATIVOS **********\n");
// Dados de entrada
A = [ 2, -1,  0,  0,  0;
     -1,  2, -1,  0,  0;
      0, -1,  2, -1,  0;
      0,  0, -1,  2, -1;
      0,  0,  0, -1,  2];
B = [100; 0; 0; 0; 200];
n = length(B);
T = A;

// Parâmetros do problema
Nmax = 1000;            // Limite superior aumentado conforme restrição
epsilon = 1e-6;         // Precisão de 10e-6
X0 = [0; 0; 0; 0; 0];   // Aproximação inicial (vetor nulo)

printf("\nSaida - Matriz A (original):\n"); disp(A);
printf("Saida - Matriz B (original):\n"); disp(B);

// ==========================================
// MÉTODOS GAUSS-JACOBI
// ==========================================
printf("\n\n***** 4.1) Processo Iterativo: Gauss-Jacobi *****:\n");
X_GJ = X0;
X_prev = X0;
convergiu_GJ = %f;

for k_GJ = 1:Nmax
    for i = 1:n
        S = 0;
        for j = 1:n
            if i ~= j then
                S = S + A(i,j) * X_prev(j);
            end
        end
        X_GJ(i) = (B(i) - S) / A(i,i);
    end
    
    erro_GJ = max(abs(X_GJ - X_prev));
    if erro_GJ < epsilon then
        convergiu_GJ = %t;
        break;
    end
    X_prev = X_GJ;
end

printf("\n Número de iterações (Gauss-Jacobi):"); disp(k_GJ);
printf("\n Erro final: %.6e\n", erro_GJ);
if convergiu_GJ then
    printf(" O método convergiu dentro da tolerância.\n");
else
    printf(" ATENÇÃO: o método atingiu o máximo de iterações.\n");
end
printf("\n Vetor solução (Gauss-Jacobi):\n"); mprintf("  %.6f\n", X_GJ);

// ==========================================
// MÉTODOS GAUSS-SEIDEL
// ==========================================
printf("\n\n***** 4.2) Processo Iterativo: Gauss-Seidel *****:\n");
X_GS = X0;
X_prev_GS = X0;
convergiu_GS = %f;

for k_GS = 1:Nmax
    X_GS = X_prev_GS;
    for i = 1:n
        S1 = 0;
        for j = 1:i-1
            S1 = S1 + A(i,j) * X_GS(j); // Usa o X já atualizado nesta iteração
        end
        S2 = 0;
        for j = i+1:n
            S2 = S2 + A(i,j) * X_prev_GS(j); // Usa o X da iteração anterior
        end
        X_GS(i) = (B(i) - S1 - S2) / A(i,i);
    end
    
    erro_GS = max(abs(X_GS - X_prev_GS));
    if erro_GS < epsilon then
        convergiu_GS = %t;
        break;
    end
    X_prev_GS = X_GS;
end

printf("\n Número de iterações (Gauss-Seidel):"); disp(k_GS);
printf("\n Erro final: %.6e\n", erro_GS);
if convergiu_GS then
    printf(" O método convergiu dentro da tolerância.\n");
else
    printf(" ATENÇÃO: o método atingiu o máximo de iterações.\n");
end
printf("\n Vetor solução (Gauss-Seidel):\n"); mprintf("  %.6f\n", X_GS);

// ==========================================
// VERIFICAÇÃO FINAL (Usando resultado do G-S)
// ==========================================
printf("\n\n****** Verificação da solução (T*X = B) *******:\n\n");
for i = 1:n
    s = 0;
    for j = 1:n
        s = s + T(i,j) * X_GS(j);
        if j < n then
            printf("(%.3f*%.3f) + ", T(i, j), X_GS(j));
        end
        if j == n then
            printf("(%.3f*%.3f) = ", T(i,j), X_GS(j));
            printf("%.3f\n", s);
        end
    end
end
printf("\nFIM\n");
