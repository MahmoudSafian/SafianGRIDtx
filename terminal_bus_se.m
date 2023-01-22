 function terminal_bus_se(in, sys, user)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
if any(ismember({'nonlinear', 'pmu'}, user))
    A = [in.bus.Bus  in.bus.Vmag  in.bus.Vang  in.bus.Pinj  in.bus.Qinj  in.bus.Psh  in.bus.Qsh];
    B = [sum(in.bus.Pinj) sum(in.bus.Qinj) sum(in.bus.Psh) sum(in.bus.Qsh)];


	disp(' ')
	disp('   _______________________________________________________________________________________________')
	disp('  |     Bus                Voltage               Injection Power      |       Shunt Element       |')
	disp('  |                   Vm[pu]  |  Va[deg]        P[MW]  |  Q[MVAr]     |     P[MW]  |  Q[MVAr]     |')
	disp('  | ------------------------------------------------------------------|---------------------------|')
	fprintf('  |     %-8.f %11.4f %11.4f %12.2f  %10.2f     | %9.2f %11.2f     |\n', A')
	disp('  |-------------------------------------------------------------------|---------------------------|')
	fprintf('  |  Sum %44.2f %11.2f     | %9.2f %11.2f     |\n', B')
	disp('  |___________________________________________________________________|___________________________|')
 end
 if ismember('dc', user)
    A = [in.bus.Bus  ones(sys.Nbu, 1)  in.bus.Vang  in.bus.Pinj  in.bus.Psh];
    B = [sum(in.bus.Pinj)  sum(in.bus.Psh)];

	disp(' ')
	disp('   __________________________________________________________________________________________')
	disp('  |     Bus                Voltage               Injection Power     |     Shunt Element     |')
	disp('  |                   Vm[pu]  |  Va[deg]              P[MW]          |         P[MW]         |')
	disp('  | -----------------------------------------------------------------|-----------------------|')
    fprintf('  |\t    %-8.f %11.4f %11.4f %18.2f          | %13.2f         |\n', A')
	disp('  |------------------------------------------------------------------|-----------------------|')
	fprintf('  |\tSum %51.2f          | %13.2f         |\n', B')
	disp('  |__________________________________________________________________|_______________________|')
 end