 function [user] = check_measurement_set(user, msr)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
if ismember('pmuRedundancy', user.list) && ~isempty(user.pmuRedundancy) && (~isvector(user.pmuRedundancy) || ~(length(user.pmuRedundancy) == 1)  || user.pmuRedundancy < 0 || user.pmuRedundancy > msr.mred(2))
	user.pmuRedundancy = msr.mred(2);
	warning('se:pmuRedundancy', ['The value pair argument of the '...
	'variable "pmuRedundancy" has invalid type. The algorithm ' ...
	'proceeds with default value: %1.2f.\n'], msr.mred(2))
 elseif ismember('pmuRedundancy', user.list) && isempty(user.pmuRedundancy)
	user.pmuRedundancy = msr.mred(2);
 end

if ismember('pmuDevice', user.list) && ~isempty(user.pmuDevice) && (~isvector(user.pmuDevice) || ~(length(user.pmuDevice) == 1) || user.pmuDevice < 0 || user.pmuDevice > msr.dpmu)
	user.pmuDevice = msr.dpmu;
	warning('se:legDevice', ['The value pair argument of the '...
	'variable "pmuDevice" has invalid type. The algorithm ' ...
	'proceeds with default value: %1.f.\n'], msr.dpmu)
 elseif ismember('pmuDevice', user.list) && isempty(user.pmuDevice)
	user.pmuDevice = msr.dpmu;
end
 if ismember('legRedundancy', user.list) && ~isempty(user.legRedundancy) && (~isvector(user.legRedundancy) || ~(length(user.legRedundancy) == 1)  || user.legRedundancy < 0 || user.legRedundancy > msr.mred(1))
	user.legRedundancy = msr.mred(1);
	warning('se:legRedundancy', ['The value pair argument of the '...
	'variable "legRedundancy" has invalid type. The algorithm ' ...
	'proceeds with default value: %1.2f.\n'], msr.mred(1))
 elseif ismember('legRedundancy', user.list) && isempty(user.legRedundancy)
	user.legRedundancy = msr.mred(1);
 end

 if ismember('legDevice', user.list) && ~isempty(user.legDevice)
	dim = size(user.legDevice);
	if dim(1) == 1
	   user.legDevice = user.legDevice';
	end
	if ~isvector(user.legDevice) || ~(length(user.legDevice) == 4) || any(user.legDevice < 0) || any(user.legDevice > msr.dleg)
	   user.legDevice = msr.dleg;
	   warning('se:legDevice',['The value pair argument of the '...
	   'variable "legDevice" has invalid type. The algorithm ' ...
	   'proceeds with default value: [%1.f %1.f %1.f %1.f].\n'], ...
	   msr.dleg(1), msr.dleg(2), msr.dleg(3), msr.dleg(4))
	end
 elseif ismember('legDevice', user.list) && isempty(user.legDevice)
	user.legDevice = msr.dleg;
 end
 end