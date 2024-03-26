s = tf('s');  % Define 's' como uma variável de transferência
G_open_loop = (s + 10) / (s + 8) * ((0.01) / (0.005 * s^2 + 0.06 * s + 0.1001));  % Função de transferência de malha aberta sem Kc

% Ponto específico onde a magnitude deve ser avaliada
s_point = -5 + 4.88*j;

% Calcula a resposta da função de transferência no ponto especificado
magnitude = abs(evalfr(G_open_loop, s_point));
fprintf('Magnitude: %.4f%\n', magnitude);

% Resolve para Kc para que a magnitude seja igual a 1
Kc = 1 / magnitude;
fprintf('Kc: %.4f%\n', Kc);
