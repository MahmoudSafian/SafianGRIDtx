 function [data] = produce_Abv(data, sys, se, user)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------


 if ismember('export', user) && any(ismember({'dc', 'pmu'}, user))
    data.extras.A = sys.H;
    data.extras.b = sys.b;
    data.extras.v = se.estimate(:,2);
 end
 
 if ismember('exportSlack', user) && ismember('dc', user)
	h = sparse(1, sys.Nbu);
	h(sys.sck(1)) = 1;
 
    data.extras.As = [sys.H; h];
    data.extras.bs = [sys.b; sys.sck(2)];
    data.extras.vs = [se.estimate(:,2); 10^-30];
 end
