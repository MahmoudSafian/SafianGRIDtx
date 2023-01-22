function [sys] = branch_container(data)
%--------------------------------------------------------------------------
% SafianGRIDtx Created by Mahmoud Safian on 2022-11-25
%--------------------------------------------------------------------------
tic
if isfield(data, 'line')
    status  = logical(data.line(:,6));
    Nli = nnz(status);
    
    Li = [data.line(status,1:5) ones(Nli,1) zeros(Nli,1)];
else
    Li  = [];
    Nli = 0;
end
if isfield(data, 'inTransformer')
    status = logical(data.inTransformer(:,7));
    Ntri = nnz(status);
    Tri = [data.inTransformer(status,1:6) zeros(Ntri,1)];
else
    Tri  = [];
    Ntri = 0;
end
if isfield(data, 'shiftTransformer')
    status = logical(data.shiftTransformer(:,8));
    Ntrp = nnz(status);
    Trp = data.shiftTransformer(status,1:7);
else
    Trp  = [];
    Ntrp = 0;
end
sys.Nbr = Nli + Ntri + Ntrp;
sys.branch = [(1:sys.Nbr)' [Li; Tri; Trp]];

sys.branch(:,8) = pi/180 * sys.branch(:,8);
end