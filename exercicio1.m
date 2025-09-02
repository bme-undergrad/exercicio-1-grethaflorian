function t = exercicio1(func, x0)
  % nao alterar: inicio
  es   = 1;     % erro relativo admissível (%)
  imax = 20;    % máximo de iterações
  % nao alterar: fim

  % === Método de Newton (derivada numérica) ===
  T = zeros(imax, 1);
  T(1) = x0;

  for ii = 1:imax-1
    % derivada numérica por diferença central
    h  = max(1e-6, 1e-6 * max(1, abs(T(ii))));
    df = (func(T(ii) + h) - func(T(ii) - h)) / (2*h);

    % proteção: derivada muito pequena
    if abs(df) < 1e-12
      t = T(ii);           % melhor estimativa até aqui
      return
    end

    % passo de Newton
    T(ii+1) = T(ii) - func(T(ii)) / df;

    % critério de parada (erro relativo em % a partir da 2ª iteração)
    if ii >= 1
      denom = max(1e-12, abs(T(ii+1)));
      ea    = abs((T(ii+1) - T(ii)) / denom) * 100;   % em %
      if ea < es
        t = T(ii+1);
        return
      end
    end
  end

  % se não convergiu antes, retorna a última estimativa
  t = T(imax);
endfunction

