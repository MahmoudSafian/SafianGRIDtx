 function [Fv] = voltage_acse(V, T, ml, mp, ap)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 Fv = [V(ml); V(mp); T(ap)];
 end