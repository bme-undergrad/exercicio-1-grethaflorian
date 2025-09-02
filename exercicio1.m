function t = exercicio1(func, x0)

% nao alterar: inicio
es = 1;      % tolerancia em PERCENTUAL (1%)
imax = 20;   % maximo de iteracoes
% nao alterar: fim

% ===== Metodo de NEWTON (derivada NUMERICA central) =====
t    = zeros(imax, 1);
erro = zeros(imax, 1);

t(1) = x0;

for ii = 1:imax-1
  % valor da funcao no ponto atual
  f0 = func(t(ii));

  % derivada numerica central: f'(x) ≈ (f(x+h)-f(x-h))/(2h)
  h  = max(1e-6, 1e-6*max(1, abs(t(ii))));   % passo seguro, adaptativo
  fp = (func(t(ii)+h) - func(t(ii)-h)) / (2*h);

  % proteção contra derivada zero/nao finita
  if fp == 0 || ~isfinite(fp)
    t = t(ii);     % devolve melhor estimativa disponivel
    break
  endif

  % passo de Newton
  t(ii+1) = t(ii) - f0/fp;

  % erro relativo EM % (compatível com es = 1)
  if t(ii+1) ~= 0
    erro(ii+1) = abs((t(ii+1) - t(ii)) / t(ii+1)) * 100;
  else
    erro(ii+1) = Inf;
  endif

  % criterio de parada
  if erro(ii+1) < es
    t = t(ii+1);
    break
  endif
endfor

% se nao convergiu em imax, retorna a ultima estimativa calculada
idx = find(t, 1, "last");
if ~isempty(idx)
  t = t(idx);
else
  t = x0;
endif

endfunction

