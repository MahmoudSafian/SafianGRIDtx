 function [data] = play_set(user, data, sys, msr)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 if any(ismember({'legRedundancy', 'legDevice', 'noLegacy'}, user.list))
	data.legacy.flow(:,5) = msr.set{1}(1:2*msr.w);
	data.legacy.flow(:,8) = msr.set{1}(2*msr.w+1:4*msr.w);
	data.legacy.current(:,5) = msr.set{1}(4*msr.w+1:6*msr.w);
	data.legacy.injection(:,4) = msr.set{1}(6*msr.w+1:6*msr.w+sys.Nbu);
	data.legacy.injection(:,7) = msr.set{1}(6*msr.w+sys.Nbu+1:6*msr.w+2*sys.Nbu);
	data.legacy.voltage(:,4) = msr.set{1}(6*msr.w+2*sys.Nbu+1:end);
 end
 if any(ismember({'pmuRedundancy', 'pmuDevice', 'pmuOptimal', 'noPmu'}, user.list))
	data.pmu.current(:,5) = msr.set{2}(1:2*msr.w);
	data.pmu.current(:,8) = msr.set{2}(2*msr.w+1:4*msr.w);
	data.pmu.voltage(:,4) = msr.set{2}(4*msr.w+1:4*msr.w+sys.Nbu);
	data.pmu.voltage(:,7) = msr.set{2}(4*msr.w+sys.Nbu+1:end);
 end
 end