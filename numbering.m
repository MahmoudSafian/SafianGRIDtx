 function [sys] = numbering(data, sys)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 sys.branch(:,9:10) = [sys.branch(:,2) sys.branch(:,3)];
 sys.bus(:,15) = sys.bus(:,1);
 bus = (1:sys.Nbu)';

 if max(bus ~= sys.bus(:,1)) == 1
	[~, b] = ismember(sys.branch(:,2), sys.bus(:,1));
	sys.branch(:,2) = bus(b);

	[~, b] = ismember(sys.branch(:,3), sys.bus(:,1));
	sys.branch(:,3) = bus(b);

	if isfield(data, 'generator')
	   [~, b] = ismember(sys.generator(:,1), sys.bus(:,1));
	   sys.generator(:,1) = bus(b);
	end

	sys.bus(:,1) = bus;
 end
 end
 