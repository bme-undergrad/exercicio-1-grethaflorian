function t = exercicio1(func, x0)

% nao alterar: inicio
es = 1;       % tolerancia EM PORCENTAGEM (1%)
imax = 20;    % maximo de iteracoes
% nao alterar: fim

% ===== Metodo de NEWTON (derivada NUMERICA central) =====
tvals = zeros(imax, 1);
erro  = zeros(imax, 1);

tvals(1) = x0;
convergiu = false;

for ii = 1:imax-1
  % f(t_k)
  f0 = func(tvals(ii));

  % f'(t_k) por diferença central: (f(x+h)-f(x-h))/(2h)
  h  = max(1e-6, 1e-6*max(1, abs(tvals(ii))));
  fp = (func(tvals(ii) + h) - func(tvals(ii) - h)) / (2*h);

  % proteção contra derivada zero/NaN/Inf
  if fp == 0 || ~isfinite(fp)
    % retorna melhor estimativa disponivel
    t = tvals(ii);
    return
  endif

  % passo de Newton
  tvals(ii+1) = tvals(ii) - f0/fp;

  % erro relativo EM %  (compatível com es = 1)
  if tvals(ii+1) ~= 0
    erro(ii+1) = abs((tvals(ii+1) - tvals(ii)) / tvals(ii+1)) * 100;
  else
    erro(ii+1) = Inf;
  endif

  % criterio de parada
  if erro(ii+1) < es
    t = tvals(ii+1);   % estimativa convergida
    convergiu = true;
    break
  endif
endfor

% se nao convergiu em imax-1 iteracoes, devolve a ultima estimativa calculada
if ~convergiu
  lastidx = find(tvals, 1, "last");
  if isempty(lastidx)
    t = x0;                 % fallback
  else
    t = tvals(lastidx);
  endif
endif

endfunction

