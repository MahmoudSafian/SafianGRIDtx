 function [user, msr] = set_produce(user, msr, sys)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 if ismember('legRedundancy', user.list)
	meas = round((msr.state) * user.legRedundancy);
	idxn = randperm(msr.total(1));
	idx  = idxn(1:meas);

	msr.set{1} = zeros(msr.total(1),1);
	msr.set{1}(idx) = 1;
 end
 if ismember('legDevice', user.list)
	t = cell(4,1);
	set = user.legDevice;
	for i = 1:4
		idx  = randperm(msr.dleg(i), set(i));
		t{i} = zeros(msr.dleg(i),1);
		t{i}(idx) = 1;
	end
	msr.set{1} = vertcat([t{1}; t{1}; t{2}; t{3}; t{3}; t{4}]);
 end
 if ismember('pmuRedundancy', user.list)
	meas = round((msr.state) * user.pmuRedundancy);
	idxn = randperm(msr.total(2));
	idx  = idxn(1:meas);

	msr.set{2} = zeros(msr.total(2),1);
	msr.set{2}(idx) = 1;
 end
 if ismember('pmuOptimal', user.list)
	A = sys.Ybu ~= 0;
	f  = ones(sys.Nbu,1);
	lb = zeros(sys.Nbu,1);
	ub = ones(sys.Nbu,1);
	intcon = 1:sys.Nbu;

	disp(' Mixed-integer linear programming is running to find an optimal PMU set.')
	options = optimoptions('intlinprog','Display','off');
	[bus, ~, flag] = intlinprog(f,intcon,-A,-f,[],[],lb,ub,[],options);

	if any(flag == [1 2])
	   disp(' Optimal solution found.')
	   bra = ismember([sys.branch(:,2); sys.branch(:,3)], find(bus));
	   msr.set{2} = [bra; bra; bus; bus];
	else
	   warning('set:noFeasible', 'No integer feasible point found. The algorithm proceeds with complete PMU set.\n')
	   rem = ismember(user.list, 'pmuOptimal');
	   user.list(rem) = [];
	   user.pmuDevice = msr.dpmu;
	   user.list = [user.list, 'pmuDevice'];
    end
 end
 if ismember('pmuDevice', user.list)
	set = user.pmuDevice;
	idx = randperm(msr.dpmu, set);
	bus = zeros(msr.dpmu,1);
	bus(idx) = 1;
	bra = ismember([sys.branch(:,2); sys.branch(:,3)], find(bus));
	msr.set{2} = [bra; bra; bus; bus];
 end
 if any(ismember({'legRedundancy', 'legDevice'}, user.list)) && ~any(ismember({'pmuRedundancy', 'pmuDevice', 'pmuOptimal'}, user.list))
	user.list = [user.list, 'noPmu'];
	msr.set{2} = zeros(msr.total(2),1);
 end
 if ~any(ismember({'legRedundancy', 'legDevice'}, user.list)) && any(ismember({'pmuRedundancy', 'pmuDevice', 'pmuOptimal'}, user.list))
	user.list = [user.list, 'noLegacy'];
	msr.set{1} = zeros(msr.total(1),1);
 end
 end