 function [data] = rungen(varargin)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
[user, data] = settings_generator(varargin);
 [data] = load_power_system(data, user.list);
[sys]  = container(data);
 [user] = check_maxiter(user);
 [sys]  = ybus_ac(sys);
 [pf]   = newton_raphson(user, sys);
 [pf]   = processing_acpf(sys, pf);
 [msr] = variable_device(sys);
 [user] = check_measurement_set(user, msr);
 [user, msr] = set_produce(user, msr, sys);
 [user] = check_measurement_variance(user);
 [msr]  = variance_produce(user, msr);
 [data] = export_measurement(data, user, sys, msr, pf);
 [data] = export_info(data, user, msr);
 disp(' Measurment data is successfully generated.')
 end