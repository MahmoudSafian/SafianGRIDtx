 function [user] = check_bad_data(user)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
if ismember('bad', user.list) && ~isempty(user.badSet) && (~isvector(user.badSet) || ~(any(length(user.badSet) == [1 2])))
	user.badThreshold = 3;
    user.badPass = 10;
	warning('se:Threshold', ['The value pair argument of the variable ' ...
	'"bad" has invalid type. The algorithm proceeds with default ' ...
	'value: [%1.f %1.f].\n'], 3, 10)
 elseif ismember('bad', user.list) && isempty(user.badSet)
	user.badThreshold = 3;
    user.badPass = 10^60;
 elseif ismember('bad', user.list) && length(user.badSet) == 1
    user.badThreshold = user.badSet(1);
    user.badPass = 10^60;
 elseif ismember('bad', user.list) && length(user.badSet) == 2
    user.badThreshold = user.badSet(1);
    user.badPass = user.badSet(2);
 end
 end