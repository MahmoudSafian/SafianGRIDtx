 function [sys] = bus_generator(sys)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 if isfield(sys, 'generator')
	Nge = size(sys.generator,1);
	A = sparse(sys.generator(:,1), (1:Nge)', 1, sys.Nbu, Nge);

	sys.bus(:,11) = A * sys.generator(:,2);
	sys.bus(:,12) = A * sys.generator(:,3);
	sys.bus(:,13) = A * sys.generator(:,4);
	sys.bus(:,14) = A * sys.generator(:,5);

	sys.bus(sys.generator(:,1),3) = sys.generator(:,6);

	sys.bus(:,2) = 1;
	sys.bus(sys.generator(:,1),2) = 2;
	sys.bus(sys.sck(1),2) = 3;
 end
 end