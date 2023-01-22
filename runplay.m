 function [data] = runplay(user, data, sys)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------

 [msr] = variable_device(sys);
 if any(ismember({'pmuRedundancy', 'pmuDevice', 'pmuOptimal', 'legRedundancy', 'legDevice'}, user.list))
 	[user]      = check_measurement_set(user, msr);
 	[user, msr] = set_produce(user, msr, sys);
 	[data]      = play_set(user, data, sys, msr);
 end
 if any(ismember({'pmuUnique', 'pmuRandom', 'pmuType', 'legUnique', 'legRandom', 'legType'}, user.list))
	[user] = check_measurement_variance(user);
 	[msr]  = variance_produce(user, msr);
 	[data] = play_variance(user, data, sys, msr);
 end
 [data] = export_info(data, user, msr);
 end