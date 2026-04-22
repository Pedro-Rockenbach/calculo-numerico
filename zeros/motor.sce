clear(); clc(); clf(); 

// ======================================================================
// 1. CONFIGURAÇÕES DO PROBLEMA (Edite APENAS esta seção durante a prova)
// ======================================================================

// Definição da Função e da Derivada
deff('y = f(x)', 'y = x^2 - 3')    // Função objetivo 
deff('y = f1(x)', 'y = 2*x')       // Derivada (necessária apenas para Newton) 

// Tolerâncias e Critérios de Parada
epsilon1 = 1e-05 
epsilon2 = 1e-05 
nMax = 100       

// Intervalos e Chutes Iniciais
a = 1.0; b = 2.0;           // Para Bissecção e Falsa Posição 
x_newton = 2.0;             // Para Newton 
x_sec0 = 1.0; x_sec1 = 2.0; // Para Secante 


// ======================================================================
// 2. MOTORES DE CÁLCULO (Não precisa mexer aqui durante a prova)
// ======================================================================

function [xm, k] = run_bisseccao(ak, bk, ep1, ep2, maxIter)
    printf("\n--- MÉTODO DA BISSECÇÃO ---\n");
    k = 0; xm = 0.5*(ak+bk);
    printf("  k |      xm    | abs(bk-ak) |    f(xm)   |\n") 
    while (k < maxIter) & (abs(bk - ak) > ep1) & (abs(f(xm)) > ep2) 
        xm = 0.5*(ak + bk);
        k = k + 1;
        printf(" %2.2i | %10.6f | %10.6f | %10.6f |\n", k, xm, abs(bk-ak), f(xm));
        if f(ak) * f(xm) < 0 then
            bk = xm;
        else
            ak = xm; 
        end
    end
    printf("Aprox. %8.6f à raíz, com %2.2i iterações\n", xm, k);
endfunction

function [xm, k] = run_falsa_posicao(ak, bk, ep1, ep2, maxIter)
    printf("\n--- MÉTODO DA FALSA POSIÇÃO ---\n");
    k = 0; xm = ak - (f(ak)*(bk-ak))/(f(bk)-f(ak));
    printf("  k |      xm    | abs(bk-ak) |    f(xm)   |\n")
    while (k < maxIter) & (abs(bk - ak) > ep1) & (abs(f(xm)) > ep2)
        xm = ak - (f(ak)*(bk-ak))/(f(bk)-f(ak));
        k = k + 1;
        printf(" %2.2i | %10.6f | %10.6f | %10.6f |\n", k, xm, abs(bk-ak), f(xm));
        if f(ak) * f(xm) < 0 then
            bk = xm;
        else
            ak = xm;
        end
    end
    printf("Aprox. %8.6f à raíz, com %2.2i iterações\n", xm, k);
endfunction

function [x_atual, k] = run_newton(x_antes, ep1, ep2, maxIter)
    printf("\n--- MÉTODO DE NEWTON-RAPHSON ---\n");
    k = 0; x_atual = x_antes - f(x_antes) / f1(x_antes);
    printf("  k |      xk    | abs(xk-xk0)|    f(xk)   |   f1(xk)   \n")
    while (k < maxIter) & (abs(x_atual - x_antes) > ep1) & (abs(f(x_antes)) > ep2)
        x_antes = x_atual;
        x_atual = x_antes - f(x_antes) / f1(x_antes);
        k = k + 1;
        printf(" %2.2i | %10.6f | %10.6f | %10.6f | %10.6f |\n", k, x_atual, abs(x_atual - x_antes), f(x_antes), f1(x_antes));
    end
    printf("Aprox. %8.6f à raíz, com %2.2i iterações\n", x_atual, k);
endfunction

function [x_atual, k] = run_secante(x_antes0, x_antes1, ep1, ep2, maxIter)
    printf("\n--- MÉTODO DA SECANTE ---\n");
    k = 0; x_atual = x_antes1 - f(x_antes1)* (x_antes1-x_antes0) / (f(x_antes1)-f(x_antes0));
    printf("  k |      xk    | abs(xk-x1) |    f(xk)   |\n") 
    while (k < maxIter) & (abs(x_atual - x_antes1) > ep1) & (abs(f(x_atual)) > ep2)
        x_antes0 = x_antes1; 
        x_antes1 = x_atual; 
        x_atual = x_antes1 - f(x_antes1)*(x_antes1-x_antes0) / (f(x_antes1)-f(x_antes0));
        k = k + 1;
        printf(" %2.2i | %10.6f | %10.6f | %10.6f |\n", k, x_atual, abs(x_atual - x_antes1), f(x_atual));
    end
    printf("Aprox. %8.6f à raíz, com %2.2i iterações\n", x_atual, k);
endfunction

// ======================================================================
// 3. EXECUÇÃO (Comente/Descomente o método que o exercício pedir)
// ======================================================================

// run_bisseccao(a, b, epsilon1, epsilon2, nMax);
// run_falsa_posicao(a, b, epsilon1, epsilon2, nMax);
// run_newton(x_newton, epsilon1, epsilon2, nMax);
// run_secante(x_sec0, x_sec1, epsilon1, epsilon2, nMax);

// Dica: Se quiser comparar a velocidade de convergência de todos, 
// deixe todos descomentados de uma vez!
