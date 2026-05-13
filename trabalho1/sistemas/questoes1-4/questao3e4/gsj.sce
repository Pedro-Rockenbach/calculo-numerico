clear(); clc();

printf("\n********** METODOS ITERATIVOS **********\n");

// IMPORTANTE: Matriz rearranjada para garantir convergência (Critério das Linhas)
// Colocamos os maiores elementos na diagonal principal
A = [ 3,  2, -1,  1;
      1,  1,  1, -1;
      2, -2,  4, -3;
      2,  3,  1,  4];
B = [10; 7; 6; 15];
// B = [9; 11; 8; 21]

n = length(B);
printf("\nDimensão da Matriz A (rearranjada): %d x %d\n", n, n);
T = A;

Nmax = 5000;            
epsilon = 1e-6;         
X0 = [0; 0; 0; 0];   

printf("\nSaida - Matriz A (rearranjada):\n"); disp(A);
printf("Saida - Matriz B (rearranjada):\n"); disp(B);

// ================== GAUSS-JACOBI ==================
printf("\n\n***** Processo Iterativo: Gauss-Jacobi *****:\n");
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
printf("\n Vetor solução (Gauss-Jacobi):\n"); mprintf("  %.6f\n", X_GJ);

// ================== GAUSS-SEIDEL ==================
printf("\n\n***** Processo Iterativo: Gauss-Seidel *****:\n");
X_GS = X0;
X_prev_GS = X0;
convergiu_GS = %f;

for k_GS = 1:Nmax
    X_GS = X_prev_GS;
    for i = 1:n
        S1 = 0;
        for j = 1:i-1
            S1 = S1 + A(i,j) * X_GS(j);
        end
        S2 = 0;
        for j = i+1:n
            S2 = S2 + A(i,j) * X_prev_GS(j); 
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
printf("\n Vetor solução (Gauss-Seidel):\n"); mprintf("  %.6f\n", X_GS);

// ================== VERIFICAÇÃO ==================
printf("\n\n****** Verificação da solução (T*X = B) *******:\n\n");
for i = 1:n
    s = 0;
    for j = 1:n
        s = s + T(i,j) * X_GS(j);
        if j < n then
            printf("(%g*%.3f) + ", T(i, j), X_GS(j));
        end
        if j == n then
            printf("(%g*%.3f) = ", T(i,j), X_GS(j));
            printf("%.3f\n", s);
        end
    end
end
printf("\nFIM\n");
