% =======================
% exercicio1.m
% Método: Newton
% Saída: tempos t para v* = 1, 5 e 12.5 m/s
% Critério: erro relativo < 1% ; máx 20 iterações
% =======================

clear all; clc;

% ---- PARAMETROS ----
g = 9.81;     % [m/s^2]
H = 2.0;      % [m]  
L = 3.0;      % [m]  

A = sqrt(2*g*H);
B = sqrt(2*g*H)/(2*L);

% ---- ALVOS DE VELOCIDADE ----
v_targets = [1, 5, 12.5];   % [m/s]

% ---- CHUTE INICIAL (tempo) ----
x0 = 0;   % t0 = 0 s

% ---- LOOP PRINCIPAL: resolve para cada v* ----
for kk = 1:length(v_targets)
  v_star = v_targets(kk);

  % f(t) = v(t) - v_star ; v(t) = A*tanh(B*t)
  f   = @(t) (A*tanh(B*t) - v_star);
  f_d = @(t) (A*B ./ (cosh(B*t).^2));   % derivada analítica

  imax = 20;   % máximo de iterações
  es   = 1;    % erro relativo admissível (em %)
  t    = zeros(imax,1);
  t(1) = x0;
  erro = zeros(imax,1);

  for ii = 1:imax-1
    if ii ~= 1
      denom    = max(1e-12, abs(t(ii)));
      erro(ii) = abs((t(ii) - t(ii-1)) / denom) * 100;  % em %
      if erro(ii) < es
        break
      endif
    endif

    den = f_d(t(ii));
    if abs(den) < 1e-12
      break
    endif

    t(ii+1) = t(ii) - f(t(ii))/den;  % Newton
  endfor

  % Resultado
  t_final = t(ii);
  ea = erro(ii);
  fprintf('v* = %5.2f m/s  ->  t = %.6f s  (iter = %d, ea ≈ %.3f%%)\n', ...
          v_star, t_final, ii, ea);
endfor


