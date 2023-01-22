 function [data] = load_power_system(data, user)
 %--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
if ~isfield(data, 'system')
	error('pg:system', 'Invalid power flow data structure, variable "data.system" not found.\n')
 end

 in = isfield(data.system, {'bus', 'line', 'inTransformer', 'shiftTransformer', 'baseMVA'});

 if ~in(1)
	error('pg:bus', 'Invalid power flow data structure, variable "data.system.bus" not found.\n')
 end
 if ~in(2) && ~in(3) && ~in(4)
	error('pg:branch', 'Invalid power flow data structure, variables "data.system.line", "data.system.inTransformer" or "data.system.shiftTransformer" not found.\n')
 end
 if ~in(5)
	data.system.baseMVA = 100;
	warning('pg:baseMVA','The variable "data.system.baseMVA" not found. The algorithm proceeds with default value: %1.f(MVA). \n', data.system.baseMVA)
 end

 if ~isfield(data, 'stop') && any(ismember(user, {'nr', 'gs', 'dnr', 'fdnr'}))
	data.stop = 10^-6;
	warning('pg:stop','The variable "data.stop" not found. The algorithm proceeds with default value: %1.e.\n', data.stop)
 end
 if ~isfield(data, 'case')
	data.case = 'unknown';
 end
 end