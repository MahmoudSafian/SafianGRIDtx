 function [data] = export_measurement(data, user, sys, msr, pf)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
 rng('shuffle');
Aflo_mean = real([pf.Sij; pf.Sji]);
 Rflo_mean = imag([pf.Sij; pf.Sji]);
 Cmag_mean = abs([pf.Iij; pf.Iji]);
 Cang_mean = angle([pf.Iij; pf.Iji]);

 Ainj_mean = real(pf.Si);
 Rinj_mean = imag(pf.Si);
 Vmag_mean = abs(pf.Vc);
 Vang_mean = angle(pf.Vc);
 Aflo_gwn = randn(2*msr.w,1);
 Rflo_gwn = randn(2*msr.w,1);
 Cmag_gwn = randn(2*msr.w,1);
 Cang_gwn = randn(2*msr.w,1);
 Ainj_gwn = randn(sys.Nbu,1);
 Rinj_gwn = randn(sys.Nbu,1);
 Vmag_gwn = randn(sys.Nbu,1);
 Vang_gwn = randn(sys.Nbu,1);
Afv = msr.var{1}(1:2*msr.w);
 Rfv = msr.var{1}(2*msr.w+1:4*msr.w);
 Cmv = msr.var{1}(4*msr.w+1:6*msr.w);
 Aiv = msr.var{1}(6*msr.w+1:6*msr.w+sys.Nbu);
 Riv = msr.var{1}(6*msr.w+sys.Nbu+1:6*msr.w+2*sys.Nbu);
 Vmv = msr.var{1}(6*msr.w+2*sys.Nbu+1:end);

 Cpmv = msr.var{2}(1:2*msr.w);
 Cpav = msr.var{2}(2*msr.w+1:4*msr.w);
 Vpmv = msr.var{2}(4*msr.w+1:4*msr.w+sys.Nbu);
 Vpav = msr.var{2}(4*msr.w+sys.Nbu+1:end);
 Af = Aflo_mean + Afv.^(1/2) .* Aflo_gwn;
 Rf = Rflo_mean + Rfv.^(1/2) .* Rflo_gwn;
 Cm = Cmag_mean + Cmv.^(1/2) .* Cmag_gwn;
 Ai = Ainj_mean + Aiv.^(1/2) .* Ainj_gwn;
 Ri = Rinj_mean + Riv.^(1/2) .* Rinj_gwn;
 Vm = Vmag_mean + Vmv.^(1/2) .* Vmag_gwn;

 Cpm = Cmag_mean + Cpmv.^(1/2) .* Cmag_gwn;
 Cpa = Cang_mean + Cpav.^(1/2) .* Cang_gwn;
 Vpm = Vmag_mean + Vpmv.^(1/2) .* Vmag_gwn;
 Vpa = Vang_mean + Vpav.^(1/2) .* Vang_gwn;
br = [sys.branch(:,9:10); sys.branch(:,10) sys.branch(:,9)];
 bs = sys.bus(:,15);

 z1 = zeros(2*sys.Nbr,1);
 z2 = zeros(sys.Nbu,1);

 data.legacy.flow      = [br Af Afv z1 Rf Rfv z1 Aflo_mean Rflo_mean];
 data.legacy.current   = [br Cm Cmv z1 Cmag_mean];
 data.legacy.injection = [bs Ai Aiv z2 Ri Riv z2 Ainj_mean Rinj_mean];
 data.legacy.voltage   = [bs Vm Vmv z2 Vmag_mean];
 data.pmu.current      = [br Cpm Cpmv z1 Cpa Cpav z1 Cmag_mean Cang_mean];
 data.pmu.voltage      = [bs Vpm Vpmv z2 Vpa Vpav z2 Vmag_mean Vang_mean];

 [data] = play_set(user, data, sys, msr);
