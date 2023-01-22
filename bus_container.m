 function [sys] = bus_container(data, stop, sys)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 sys.bus = data.bus;
 sys.Nbu = size(data.bus,1);

 sys.bus(:,5:8) = sys.bus(:,5:8) ./ data.baseMVA;
 sys.bus(:,4)   = pi/180 * sys.bus(:,4);
 if isfield(data, 'generator')
	status  = logical(data.generator(:,7));

	sys.generator = data.generator(status,:);
	sys.generator(:,2:5) = sys.generator(:,2:5) ./ data.baseMVA;
 else
	sys.bus(:,11:14) = zeros(sys.Nbu,4);
 end
 sys.sck = find(sys.bus(:,2) == 3);
 sys.sck = [sys.sck sys.bus(sys.sck,4)];
sys.base = data.baseMVA;
 sys.stop = stop;
 end