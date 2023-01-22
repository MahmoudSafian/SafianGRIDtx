 function terminal_bad_data(in, re, sys, user)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 if ismember('nonlinear', user)
	N = size(in.bad, 1);
	A = [(1:N)' in.bad];
	d = in.device(in.bad(:,3));
	o = [repmat({'Remove'}, [N-1,1]); ' '];

	disp(' ')
	disp('   _______________________________________________________________________________________________________________')
	disp('  |     Gauss-Newton Pass     Number of Iterations      Suspected Bad Data     Normalized Residual     Status     |')
	disp('  | --------------------------------------------------------------------------------------------------------------|')
	for i = 1:N
		   fprintf('  |\t    %10.f    %20.f  %25s      %18.2e   %13s     |\n',...
				    A(i,1),  A(i,2),  d{i,1}, A(i,3),  o{i,1} )
	end
	disp('  |_______________________________________________________________________________________________________________|')
 end
if ismember('dc', user)
	N   = size(in.bad, 1);
	num = string(1:N)';
	res = compose('%1.2e', re.bad.Residual);
	bad = [num re.bad.Device res re.bad.Status]';

	disp(' ')
	disp('   ____________________________________________________________________________')
	disp('  |     WLS Pass     Suspected Bad Data     Normalized Residual     Status     |')
	disp('  | ---------------------------------------------------------------------------|')
	fprintf('  |  %7s             %-13s %16s             %-10s |\n', bad{:})
	disp('  |____________________________________________________________________________|')
 end

 if ismember('pmu', user)
	N = size(in.bad,1 );
	A = [(1:N)' in.bad];
	d = sys.device(in.bad(:,2));
	o = [repmat({'Remove'}, [N-1,1]); ' '];

	disp(' ')
	disp('   ___________________________________________________________________________________')
	disp('  |     WLS Pass     Suspected Phasor Bad Data     Normalized Residual     Status     |')
	disp('  | ----------------------------------------------------------------------------------|')
	for i = 1:N
		   fprintf('  |\t    %4.f    %20s      %22.2e   %14s     |\n',...
				    A(i,1), d{i,1}, A(i,2),  o{i,1} )
	end
	disp('  |___________________________________________________________________________________|')
 end