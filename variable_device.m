 function [msr] = variable_device(sys)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 msr.w = sys.Nbr;

 msr.state = 2 * sys.Nbu - 1;
 msr.total = [6 * msr.w + 3 * sys.Nbu; 4 * msr.w + 2 * sys.Nbu];
 msr.tleg  = [2 * msr.w; 2 * msr.w; 2 * msr.w; sys.Nbu; sys.Nbu; sys.Nbu];
 msr.tpmu  = [2 * msr.w; 2 * msr.w; sys.Nbu; sys.Nbu];
 msr.dleg  = [2 * msr.w; 2 * msr.w; sys.Nbu; sys.Nbu];
 msr.dpmu  = sys.Nbu;
 msr.mred  = msr.total ./ msr.state;
 end