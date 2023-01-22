 function [Fi, Ji] = injection_acse(V, T, p, q, Nbu)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 U  = T(p.i) - T(p.j);
 Vi = V(p.i);
 Vj = V(p.j);
 Vb = V(p.bus);

 Tp1 = p.Gij .* cos(U) + p.Bij .* sin(U);
 Pi  = Vb .* sparse(p.ii, p.j, Tp1, p.N, Nbu) * V;
 Tp2   = -p.Gij .* sin(U) + p.Bij .* cos(U);
 Pi_Ti = Vb .* sparse(p.ii, p.j, Tp2, p.N, Nbu) * V - Vb.^2 .* p.Bii;
 Pi_Tj = -Vi(p.ij) .* Vj(p.ij) .* Tp2(p.ij);

 Pi_Vi = sparse(p.ii, p.j, Tp1, p.N, Nbu) * V + Vb .* p.Gii;
 Pi_Vj = Vi(p.ij) .* Tp1(p.ij);

 J41 = sparse(p.jci, p.jcj, [Pi_Ti; Pi_Tj], p.N, Nbu);
 J42 = sparse(p.jci, p.jcj, [Pi_Vi; Pi_Vj], p.N, Nbu);
 U  = T(q.i) - T(q.j);
 Vi = V(q.i);
 Vj = V(q.j);
 Vb = V(q.bus);

 Tq1 = q.Gij .* sin(U) - q.Bij .* cos(U);
 Qi  = Vb .* sparse(q.ii, q.j, Tq1, q.N, Nbu) * V;
 Tq2 = q.Gij .* cos(U) + q.Bij .* sin(U);
 Qi_Ti = Vb .* sparse(q.ii, q.j, Tq2, q.N, Nbu) * V - Vb.^2 .* q.Gii;
 Qi_Tj = -Vi(q.ij) .* Vj(q.ij) .* Tq2(q.ij);

 Qi_Vi = sparse(q.ii, q.j, Tq1, q.N, Nbu) * V - Vb .* q.Bii;
 Qi_Vj = Vi(q.ij) .* Tq1(q.ij);

 J51 = sparse(q.jci, q.jcj, [Qi_Ti; Qi_Tj], q.N, Nbu);
 J52 = sparse(q.jci, q.jcj, [Qi_Vi; Qi_Vj], q.N, Nbu);
 Fi = [Pi; Qi];
 Ji = [J41 J42; J51 J52];
 end