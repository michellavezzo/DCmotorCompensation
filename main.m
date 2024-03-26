%% 
% Funcao para calcular o zeta e wn a partir dos requisitos de overshhot e
% tempo de acomodacao
function [zeta, omega_n] = calcular_zeta_omega_n(OS, t_s)
    zeta = -log(OS/100) / sqrt(pi^2 + (log(OS/100))^2);
    omega_n = 4 / (zeta * t_s);
end

OS = 4; % 8% de overshoot
t_s = 0.8; % tempo de acomodação de 5 segundos

[zeta, wn] = calcular_zeta_omega_n(OS, t_s);

disp(['O valor de zeta é: ', num2str(zeta)]);
disp(['O valor de omega_n é: ', num2str(wn)]);

% Agora resolvemos a equacao característica substituindo os valores de Zeta e Wn
function calcular_s(zeta, omega_n)
    % Escrever a equação característica
    disp('Equação característica:');
    fprintf('s^2 + %.2fs + %.2f\n', 2*zeta*omega_n, power(omega_n, 2));

    % Coeficientes da equação característica
    coeficientes = [1, 2*zeta*omega_n, omega_n^2];

    % Calcular as raízes da equação característica
    raizes = roots(coeficientes);

    % Mostrar as raízes
    disp('Raízes:');
    disp(raizes);
end

calcular_s(zeta, wn);

% Definição da função de transferência de malha aberta
num = [0.01];  % Numerador da função de transferência
den = [0.005, 0.06, 0.1001];  % Denominador da função de transferência
G = tf(num, den);  % Criar função de transferência de malha aberta

% Polo desejado
desired_pole = -2 + 2i;  % Defina o polo desejado

% Polos e zeros da função de transferência
p = pole(G);  % Polos
%z = zero(G);  % Zeros
disp('Polos:')
disp(p)
%disp('Zeros:')
%disp(z)

% Plotar o LGR da função de transferência original
figure;
rlocus(ftma_sys_original); % Plote o LGR da função de transferência original
hold on;
% Adicionar legenda e título ao LGR
title('Lugar das Raízes da Função de Transferência Original');
xlabel('Parte Real');
ylabel('Parte Imaginária');


%%
% Identificar os polos e zeros do sistema original no LGR
polos_original = pole(ftma_sys_original); % Obtenha os polos do sistema original

% Calcule os polos do compensador de atraso
polos_compensador = roots([1 2]);

% Adicionar os polos do compensador de atraso no LGR
rlocus(ftma_sys_original); % Plote novamente o LGR da função de transferência original
plot(polos_compensador, 'rx', 'MarkerSize', 10, 'LineWidth', 2); % Plote os polos do compensador de atraso
% Adicionar legenda e título ao LGR com os polos do compensador
legend('Original', 'Compensador de Atraso');
title('Lugar das Raízes com Compensador de Atraso');
xlabel('Parte Real');
ylabel('Parte Imaginária');