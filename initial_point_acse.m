 function [T, V] = initial_point_acse(user, sys, data)
 if ismember('flat', user.list)
	T = pi/180 * user.flat(1) * ones(sys.Nbu,1);
	T(sys.sck(1)) = sys.sck(2);
	V = user.flat(2) * ones(sys.Nbu,1);
 end
 if ismember('exact', user.list)
	try
	  T = data.pmu.voltage(:,9);
	  V = data.pmu.voltage(:,8);
	catch
	  rem = ismember(user.list, 'exact');
	  user.list(rem) = [];
	  user.list = [user.list, 'warm'];
	  warning('se:startExact','Exact values were not found. The algorithm proceeds with the same initial point as the one applied in AC power flow.\n')
	end
 end
 if ismember('warm', user.list)
	[sys] = bus_generator(sys);
	T = sys.bus(:,4);
	V = sys.bus(:,3);
 end
 if ismember('random', user.list)
	a = pi/180 * [user.random(1) user.random(2)];
	T = (max(a)-min(a)).*rand(sys.Nbu,1) + min(a);
	T(sys.sck(1)) = sys.sck(2);
	a = [user.random(3) user.random(4)];
	V = (max(a)-min(a)).*rand(sys.Nbu,1) + min(a);
 end
 end