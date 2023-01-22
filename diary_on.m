 function diary_on(user, case_in)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
if ismember('save', user)
    cd('experiments') 
	diary(strcat(case_in, datestr(now,'_dd-mm-yy','local'),'_', datestr(now,'hh-MM-ss','local'), '.txt'))
    cd('../') 
 end
 end