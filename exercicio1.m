function t = exercicio1(func, func_d, x0)
  % nao alterar: inicio
  es   = 1;     % erro relativo admissível (%)
  imax = 20;    % máximo de iterações
  % nao alterar: fim

  % ===== Método de Newton (usando a derivada fornecida) =====
  tvec    = zeros(imax, 1);
  tvec(1) = x0;

  for ii = 1:imax-1
    if ii ~= 1
      denom = max(1e-12, abs(tvec(ii)));
      ea    = abs((tvec(ii) - tvec(ii-1)) / denom) * 100;  % erro em %
      if ea < es
        t = tvec(ii);
        return
      endif
    endif

    den = func_d(tvec(ii));
    if abs(den) < 1e-12
      t = tvec(ii);   % derivada ~0: devolve melhor estimativa
      return
    endif

    tvec(ii+1) = tvec(ii) - func(tvec(ii)) / den;  % passo de Newton
  endfor

  t = tvec(ii);  % última estimativa válida
endfunction

