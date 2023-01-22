 function [data] = load_measurements(user, data)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 se = isfield(data, {'legacy', 'pmu'});

 if se(1) == 1
	leg = isfield(data.legacy, {'flow', 'injection', 'voltage', 'current'});
 end
 if se(2) == 1
	pmu = isfield(data.pmu, {'voltage', 'current'});
 end

 if se(1) == 1 && any(leg == 1) || se(2) == 1 && any(pmu == 1)
 else
	error('data:legacyPmuMissed', 'Invalid measurement data structure, measurements not found.\n')
 end
 if ismember('dc', user.list) && (se(1) == 0 && all(leg(1:2) == 0) || se(2) == 0 && pmu(1) == 0)
	error('data:legacyPmuDC', 'Invalid measurement data structure, measurements not found.\n')
 end
 if se(1) == 0
	data.legacy.flow = zeros(1,11);
	data.legacy.injection = zeros(1,11);
	data.legacy.voltage = zeros(1,11);
	data.legacy.current = zeros(1,11);
 end
 if se(1) == 1 && leg(1) == 0
	data.legacy.flow = zeros(1,11);
 end
 if se(1) == 1 && leg(2) == 0
	data.legacy.injection = zeros(1,11);
 end
 if se(1) == 1 && leg(3) == 0
	data.legacy.voltage = zeros(1,11);
 end
 if se(1) == 1 && leg(4) == 0
	data.legacy.current = zeros(1,11);
 end

 if se(2) == 0
	data.pmu.current = zeros(1,11);
	data.pmu.voltage = zeros(1,11);
 end
 if se(2) == 1 && pmu(1) == 0
	data.pmu.current = zeros(1,11);
 end
 if se(2) == 1 && pmu(2) == 0
	data.pmu.voltage = zeros(1,11);
 end
 end