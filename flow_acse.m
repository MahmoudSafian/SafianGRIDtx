 function [Ff, Jf] = flow_acse(V, T, p, q, Nbu)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
U  = T(p.i) - T(p.j) - p.fij;
 Vi = V(p.i);
 Vj = V(p.j);

 Tp1 = p.gij .* cos(U) + p.bij .* sin(U);
 Pij = Vi.^2 .* p.tgij - p.pij .* Vi .* Vj .* Tp1;
 Tp2    = p.gij .* sin(U) - p.bij .* cos(U);
 Pij_Ti = p.pij .* Vi .* Vj .* Tp2;
 Pij_Tj = -Pij_Ti;

 Pij_Vi =  2 * p.tgij .* Vi  - p.pij .* Vj .* Tp1;
 Pij_Vj = -p.pij .* Vi .* Tp1 ;

 J11 = sparse(p.jci, p.jcj, [Pij_Ti; Pij_Tj], p.N, Nbu);
 J12 = sparse(p.jci, p.jcj, [Pij_Vi; Pij_Vj], p.N, Nbu);
U  = T(q.i) - T(q.j) - q.fij;
 Vi = V(q.i);
 Vj = V(q.j);

 Tq1 = q.gij .* sin(U) - q.bij .* cos(U);
 Qij = - q.tbij .* Vi.^2 - q.pij .* Vi .* Vj .* Tq1;
Tq2    = q.gij .* cos(U) + q.bij .* sin(U);
 Qij_Ti = -q.pij .* Vi .* Vj .* Tq2;
 Qij_Tj = -Qij_Ti;

 Qij_Vi = - 2 * q.tbij .* Vi - q.pij .* Vj .* Tq1;
 Qij_Vj = -q.pij .* Vi .* Tq1;

 J21 = sparse(q.jci, q.jcj, [Qij_Ti; Qij_Tj], q.N, Nbu);
 J22 = sparse(q.jci, q.jcj, [Qij_Vi; Qij_Vj], q.N, Nbu);
Ff = [Pij; Qij];
 Jf = [J11 J12; J21 J22];
 end