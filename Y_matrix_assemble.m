function [Y_matrix] = Y_matrix_assemble(global_nodes,prop_mat,omega_frequency)
%   Y_matrix_assemble: creates global Y matrix from association between
%   elements and global nodes
%   INPUTS: global_nodes - vector of global nodes for each element
%           prop_mat - matrix of properties for each element
%           omega_frequency - frequency of voltage input, in rad/s
%   OUTPUTS: Y_matrix

s_parm=1i*omega_frequency;
% each element has two indices in global_nodes
n_elem = length(global_nodes)/2;
for elem=1:n_elem
    prop_vec = prop_mat(elem,:);
    ke = local_elemental_matrix(prop_vec);





Y_matrix=zeros(number_of_nodes,number_of_nodes);

end