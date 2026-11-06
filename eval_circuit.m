function [FRF_mag, FRF_phase] = eval_circuit(top_mat, prop_mat, output_element)
%EVAL_CIRCUIT Analyzes given circuit topology and computes FRF magnitude
%and phase
%   INPUTS: top_mat - Adjacency matrix containing topology of circuit
%           prop_mat - Matrix containing properties of each element
%           output_element - Element whose voltage is the ouput of the FRF
%   OUTPUTS: FRF_mag - list of frequency vs FRF magnitude (in dB)
%             FRF_phase - list of frequency vs FRF phase (in dB)

% create association between elements and global nodes
global_nodes = get_global_nodes(top_mat);





FRF_mag = 0;
FRF_phase = 0;


end