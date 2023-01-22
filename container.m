 function [sys] = container(data)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
[sys] = branch_container(data.system);
 [sys] = bus_container(data.system, data.stop, sys);
 [sys] = numbering(data.system, sys);
 [sys] = bus_generator(sys);
 end