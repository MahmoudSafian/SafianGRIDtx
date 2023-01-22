 function [] = terminal_error_se(in, re)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
disp(' ')
 disp('   ________________________________________________________________________________________________________')
 disp('  |                                 SafianGRIDtx State Estimation Evaluation                               |')
 disp('  |                                                                                                        |')
 disp('  |               Description                                MAE              RMSE             WRSS        |')
 disp('  |--------------------------------------------------------------------------------------------------------|')
 fprintf('  |\t Estimate Values and Measurement Values     %20.4e %16.4e %16.4e     |\n', re.error.EstimateMean)
 if in.exact
	fprintf('  |\t Estimate Values and Exact Values           %20.4e %16.4e %16.4e     |\n', re.error.EstimateExact)
	fprintf('  |\t Estimate State Variables and Exact Values  %20.4e %16.4e  \t\t\t\t\t   |\n', re.error.EstimateExactState(1:2))
 end
 disp('  |________________________________________________________________________________________________________|')