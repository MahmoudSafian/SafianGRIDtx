 function [se] = gauss_newton(user, sys, se, data)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 se.method = 'Non-linear State Estimation using Gauss-Newton Method';
 [T, V] = initial_point_acse(user, sys, data);

 x   = [T; V];
 z   = se.estimate(:,1);
 No  = 0;
 eps = 9999;
se.time.pre = toc; tic
 while eps > sys.stop && No < user.maxIter
 No = No+1;
 [Ff, Jf] = flow_acse(V, T, sys.Pf, sys.Qf, sys.Nbu);
 [Fc, Jc] = current_acse(V, T, sys.Cm, sys.Nbu);
 [Fi, Ji] = injection_acse(V, T, sys.Pi, sys.Qi, sys.Nbu);
 [Fp, Jp] = current_ph_acse(V, T, sys.Cmp, sys.Cap, sys.Nbu);
 [Fv] = voltage_acse(V, T, sys.Vml.i, sys.Vmp.i, sys.Vap.i);

 f = [Ff; Fc; Fi; Fv; Fp];
 H = [Jf; Jc; Ji; sys.Jv; Jp];  
 
 H(:, sys.sck(1)) = [];
 dx = (H' * sys.W * H) \ (H' * sys.W * (z - f));

 ins = @(a, x, n) cat(1, x(1:n), a, x(n + 1:end));
 dx  = ins(0, dx, sys.sck(1) - 1);
x = x + dx;

 T = x(1:sys.Nbu);
 V = x(sys.Nbu + 1:end);

 eps = norm(dx, inf);
 end
 se.time.con  = toc; tic
 se.Vc        = V .* exp(T * 1i);
 se.iteration = No;
%--------------------------------------------------------------------------