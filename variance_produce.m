 function [msr] = variance_produce(user, msr)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
if ismember('legUnique', user.list)
	var = user.legUnique;
	msr.var{1} = var * ones(msr.total(1),1);
 end

 if ismember('pmuUnique', user.list)
	var = user.pmuUnique;
	msr.var{2} = var * ones(msr.total(2),1);
 end
 if ismember('legRandom', user.list)
	std_min = min(user.legRandom);
	std_max = max(user.legRandom);
	msr.var{1} = std_min + (std_max - std_min) .* rand(msr.total(1),1);
 end

 if ismember('pmuRandom', user.list)
	std_min = min(user.pmuRandom);
	std_max = max(user.pmuRandom);
	msr.var{2} = std_min + (std_max - std_min) .* rand(msr.total(2),1);
 end
 if ismember('legType', user.list)
	var = user.legType;
	msr.var{1} = repelem(var, msr.tleg,1);
 end

 if ismember('pmuType', user.list)
	var = user.pmuType;
	msr.var{2} = repelem(var, msr.tpmu,1);
 end
 end