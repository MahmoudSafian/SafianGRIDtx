 function [user] = check_start(user)              
 %--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
if ismember('flat', user.list) && ~isempty(user.flat) && (~isvector(user.flat) || ~(length(user.flat) == 2))
	user.flat = [0 1];
	warning('se:startFlat', ['The value pair argument of the variable ' ...
	'"flat" has invalid type. The algorithm proceeds with default ' ...
	'value: [%1.f %1.f].\n'], 0,1)
 elseif ismember('flat', user.list) && isempty(user.flat)
	user.flat = [0 1];
 end

 if ismember('random', user.list) && ~isempty(user.random) && (~isvector(user.random) || ~(length(user.random) == 4))
	user.random = [-0.5 0.5 0.95 1.05];
	warning('se:startFlat', ['The value pair argument of the variable ' ...
	'"random" has invalid type. The algorithm proceeds with default ' ...
	'value: [%1.2f %1.2f %1.2f %1.2f].\n'], -0.5,0.5,0.95,1.05)
 elseif ismember('random', user.list) && isempty(user.random)
	user.random = [-0.5 0.5 0.95 1.05];
 end
 end