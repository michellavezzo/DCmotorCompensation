num_original = [0.01];  % Coeficientes do numerador da função de transferência original
den_original = [0.005, 0.06, 0.1001];  % Coeficientes do denominador da função de transferência original
ftma_sys_original = tf(num_original, den_original); % função de transferência de malha aberta original

num_lead = [1, 10];  % Coeficientes do numerador da função de transferência original
den_lead = [1, 8];  % Coeficientes do denominador da função de transferência original
ftma_sys_original_lead = tf(num_lead, den_lead); % função de transferência de malha aberta original

num_lag = [1, 1.93373538];  % Coeficientes do numerador da função de transferência original
den_lag = [1, 0.04];  % Coeficientes do denominador da função de transferência original
ftma_sys_original_lag = tf(num_lag, den_lag); % função de transferência de malha aberta original

gain = 16.3992;

ftma_sys_multiplicated = gain * ftma_sys_original_lead * ftma_sys_original_lag * ftma_sys_original;
ftmf_sys_final = feedback(ftma_sys_multiplicated, 1); % função de transferência de malha fechada original

ftmf_sys_original = feedback(ftma_sys_original, 1); % função de transferência de malha fechada original
ftmf_sys_after_lead = feedback(gain * ftma_sys_original_lead * ftma_sys_original, 1); % função de transferência de malha fechada original

% Características do sistema
info = stepinfo(ftmf_sys_original); % Obtém informações sobre a resposta ao degrau do sistema
fprintf('Original: Tempo de acomodação: %.4f segundos\n', info.SettlingTime); % critério de 2%
fprintf('Original: Overshoot: %.4f%%\n', info.Overshoot);
% Calcule o ganho estático (ou seja, o valor final do sistema para uma entrada constante)
steady_state_error = abs(1 - dcgain(ftmf_sys_original)) * 100;
fprintf('Original: Percentual do erro em regime permanente: %.4f%%\n', steady_state_error);

% Características do sistema
info = stepinfo(ftmf_sys_after_lead); % Obtém informações sobre a resposta ao degrau do sistema
fprintf('After lead: Tempo de acomodação: %.4f segundos\n', info.SettlingTime); % critério de 2%
fprintf('After lead: Overshoot: %.4f%%\n', info.Overshoot);
% Calcule o ganho estático (ou seja, o valor final do sistema para uma entrada constante)
steady_state_error = abs(1 - dcgain(ftmf_sys_after_lead)) * 100;
fprintf('After lead: Percentual do erro em regime permanente: %.4f%%\n', steady_state_error);

% Características do sistema
info = stepinfo(ftmf_sys_final); % Obtém informações sobre a resposta ao degrau do sistema
fprintf('Tempo de acomodação: %.4f segundos\n', info.SettlingTime); % critério de 2%
fprintf('Overshoot: %.4f%%\n', info.Overshoot);
% Calcule o ganho estático (ou seja, o valor final do sistema para uma entrada constante)
steady_state_error = abs(1 - dcgain(ftmf_sys_final)) * 100;
fprintf('Percentual do erro em regime permanente: %.4f%%\n', steady_state_error);
