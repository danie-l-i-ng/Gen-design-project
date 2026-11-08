function [ke] = local_elemental_matrix(local_property,s_parm)
%   local_elemental_matrix: this finds the local elemental matrix at a
%   given frequency and elemental property (resistor, capacitor, or
%   inductor)
%   INPUTS: local_property - specifies the type of elemental property
%           s_parm - specifics the frequency content
%   OUTPUTS: ke - local elemental matrix

idx=find(local_property~=0);

if numel(idx) > 1
    fprintf('ERROR ERROR ERROR local_property contains more than one nonzero value.\n');
    return
elseif numel(idx) == 0
    fprintf('ERROR ERROR ERROR local_property does not contain a nonzero value.\n');
    return
end

if idx==1
    % resistor value
    y_local=1/local_property(idx);

elseif idx==2
    % capacitor value
    y_local=(s_parm*local_property(idx));

elseif idx==3
    % inductor value
    y_local=1/(s_parm*local_property(idx));

end

% local matrix
ke=y_local*[1 -1; -1 1];

end