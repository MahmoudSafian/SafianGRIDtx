 function [sys] = ybus_ac(sys)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
sys.branch(:,11) = 1 ./ complex(sys.branch(:,4), sys.branch(:,5));
 sys.branch(:,12) = 1i *  sys.branch(:,6) / 2;
 sys.branch(:,13) = sys.branch(:,7) .* exp(1i * sys.branch(:,8));
 sys.branch(:,14) = sys.branch(:,11) + sys.branch(:,12);
 sys.branch(:,15) = sys.branch(:,14) ./ (conj(sys.branch(:,13)) .* sys.branch(:,13));
 sys.branch(:,16) = -sys.branch(:,11) ./ conj(sys.branch(:,13));
 sys.branch(:,17) = -sys.branch(:,11) ./ sys.branch(:,13);
 row = [sys.branch(:,1); sys.branch(:,1)];
 col = [sys.branch(:,2); sys.branch(:,3)];

 Ai = sparse(sys.branch(:,1), sys.branch(:,2), 1, sys.Nbr, sys.Nbu);
 Yi = sparse(row, col, [sys.branch(:,15); sys.branch(:,16)], sys.Nbr, sys.Nbu);

 Aj = sparse(sys.branch(:,1), sys.branch(:,3), 1, sys.Nbr, sys.Nbu);
 Yj = sparse(row, col, [sys.branch(:,17); sys.branch(:,14)], sys.Nbr, sys.Nbu);
 sys.ysh = complex(sys.bus(:,7), sys.bus(:,8));
 Ysh = sparse(sys.bus(:,1), sys.bus(:,1), sys.ysh, sys.Nbu, sys.Nbu);
 sys.Ybu = Ai' * Yi + Aj' * Yj + Ysh;
 sys.Yii = sparse(sys.Nbu, sys.Nbu);
 sys.Yii = spdiags(spdiags(sys.Ybu,0), 0, sys.Yii);
 sys.Yij = sys.Ybu - sys.Yii;
 end