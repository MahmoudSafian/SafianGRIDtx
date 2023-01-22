 function [Fc, Jc] = current_acse(V, T, c, Nbu)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 U  = T(c.i) - T(c.j) - c.fij;
 Vi = V(c.i);
 Vj = V(c.j);

 Tc1 = c.C .* cos(U) - c.D .* sin(U);
 Fc  = (c.A .* Vi.^2 + c.B .* Vj.^2 - 2 * Vi .* Vj .* Tc1).^(1/2);
 Tc2    = c.C .* sin(U) + c.D .* cos(U);
 Iij_Ti = Vi .* Vj .* Tc2 ./ Fc;
 Iij_Tj = -Iij_Ti;

 Iij_Vi = (-Vj .* Tc1 + c.A .* Vi) ./ Fc;
 Iij_Vj = (-Vi .* Tc1 + c.B .* Vj) ./ Fc;

 J31 = sparse(c.jci, c.jcj, [Iij_Ti; Iij_Tj], c.N, Nbu);
 J32 = sparse(c.jci, c.jcj, [Iij_Vi; Iij_Vj], c.N, Nbu);

 Jc = [J31 J32];
 end