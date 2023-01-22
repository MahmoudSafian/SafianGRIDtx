 function [user] = check_maxiter(user)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
if (ismember('maxIter', user.list) && (~isvector(user.maxIter) || ~(length(user.maxIter) == 1) || user.maxIter <= 0)) || ~ismember('maxIter', user.list) 
	if ismember('nr', user.list)
	   user.maxIter = 500;
	end
	if ismember('gs', user.list)
	   user.maxIter = 500;
	end
	if ismember('dnr', user.list)
	   user.maxIter = 500;
    end
	if ismember('fdnr', user.list)
	   user.maxIter = 500;
	end
	if ismember('nonlinear', user.list)
	   user.maxIter = 500;
	end    
 end
 end
