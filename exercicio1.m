function t = exercicio1(func,x0)

% nao alterar: inicio
es = 1;
imax = 20;
% nao alterar: fim

% === Metodo de Newton: requer func e func_d; es em fracao (1%) ===
t = zeros(imax, 1);
erro = zeros(imax, 1);

t(1) = x0;

for ii = 1:imax-1
  den = func_d(t(ii));
  if den == 0
    % derivada nula: retorna melhor estimativa conhecida
    t = t(ii);
    break
  endif

  t(ii+1) = t(ii) - func(t(ii)) / den;

  if t(ii+1) ~= 0
    erro(ii+1) = abs((t(ii+1) - t(ii)) / t(ii+1));  % erro em fracao
  else
    erro(ii+1) = Inf;
  endif

  if erro(ii+1) < es
    t = t(ii+1);   % convergiu
    break
  endif

  % continua ate imax
endfor

% se nao convergiu, devolve a ultima aproximacao calculada
if length(t) > 1 && t(end) ~= 0
  t = t(find(t, 1, "last"));
else
  t = t(end);
endif


endfunction
