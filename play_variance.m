 function [data] = play_variance(user, data, sys, msr)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 rng('shuffle');
 if any(ismember({'legUnique', 'legRandom', 'legType'}, user.list))
	Afv = msr.var{1}(1:2*msr.w);
	Rfv = msr.var{1}(2*msr.w+1:4*msr.w);
	Cmv = msr.var{1}(4*msr.w+1:6*msr.w);
	Aiv = msr.var{1}(6*msr.w+1:6*msr.w+sys.Nbu);
	Riv = msr.var{1}(6*msr.w+sys.Nbu+1:6*msr.w+2*sys.Nbu);
	Vmv = msr.var{1}(6*msr.w+2*sys.Nbu+1:end);

	Af = data.legacy.flow(:,9) + Afv.^(1/2) .* randn(2*msr.w,1);
	Rf = data.legacy.flow(:,10) + Rfv.^(1/2) .* randn(2*msr.w,1);
	Cm = data.legacy.current(:,6) + Cmv.^(1/2) .* randn(2*msr.w,1);
	Ai = data.legacy.injection(:,8) + Aiv.^(1/2) .* randn(sys.Nbu,1);
	Ri = data.legacy.injection(:,9) + Riv.^(1/2) .* randn(sys.Nbu,1);
	Vm = data.legacy.voltage(:,5) + Vmv.^(1/2) .* randn(sys.Nbu,1);

	data.legacy.flow(:,3:4) = [Af Afv];
	data.legacy.flow(:,6:7) = [Rf Rfv];
	data.legacy.current(:,3:4) = [Cm Cmv];
	data.legacy.injection(:,2:3) = [Ai Aiv];
	data.legacy.injection(:,5:6) = [Ri Riv];
	data.legacy.voltage(:,2:3) = [Vm Vmv];
 end
 if any(ismember({'pmuUnique', 'pmuRandom', 'pmuType'}, user.list))
	Cpmv = msr.var{2}(1:2*msr.w);
	Cpav = msr.var{2}(2*msr.w+1:4*msr.w);
	Vpmv = msr.var{2}(4*msr.w+1:4*msr.w+sys.Nbu);
	Vpav = msr.var{2}(4*msr.w+sys.Nbu+1:end);

	Cpm = data.pmu.current(:,9) + Cpmv.^(1/2) .* randn(2*msr.w,1);
	Cpa = data.pmu.current(:,10) + Cpav.^(1/2) .* randn(2*msr.w,1);
	Vpm = data.pmu.voltage(:,8) + Vpmv.^(1/2) .* randn(sys.Nbu,1);
	Vpa = data.pmu.voltage(:,9) + Vpav.^(1/2) .* randn(sys.Nbu,1);

	data.pmu.current(:,3:4) = [Cpm Cpmv];
	data.pmu.current(:,6:7) = [Cpa Cpav];
	data.pmu.voltage(:,2:3) = [Vpm Vpmv];
	data.pmu.voltage(:,5:6) = [Vpa Vpav];
 end
 end