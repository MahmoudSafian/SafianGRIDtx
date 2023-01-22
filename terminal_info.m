 function terminal_info(in, sys, user)
 %--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
disp(' ')
 disp(' ')
 fprintf('\tMethod: %s\n', in.method);
 fprintf('\tPower System: %s\n', user{end});
 fprintf(['\tDate: ', datestr(now, 'dd.mm.yyyy HH:MM:SS \n')])
 disp(' ')
 fprintf('\tPreprocessing time: %2.5f seconds\n', in.time.Preprocess)
 fprintf('\tConvergence time: %2.5f seconds\n', in.time.Convergence)
 fprintf('\tPostprocessing time: %2.5f seconds\n', in.time.Postprocess)
 if any(ismember({'nr', 'gs', 'dnr', 'fdnr', 'nonlinear'}, user))
	disp(' ')
	fprintf('\tStopping condition for iterative process: %s\n ', num2str(sys.stop))
	fprintf ('\tNumber of iterations: %d\n', in.iteration)
 end
 if any(ismember({'nr', 'gs', 'dnr', 'fdnr'}, user))
	if any(in.bus.MinLim)
	   fprintf('\tMinimum equality constraint violated at buses: %s\n', sprintf('%d ', in.bus.Bus(logical(in.bus.MinLim))))
	end
	if any(in.bus.MaxLim)
	   fprintf('\tMaximum equality constraint violated at buses: %s\n', sprintf('%d ', in.bus.Bus(logical(in.bus.MaxLim))))
	end
 end