function [Y_matrix] = Y_matrix_assemble(number_of_nodes,global_nodes,prop_mat,omega_frequency)
%   Y_matrix_assemble: 
%   INPUTS: 
%   OUTPUTS: 

s_parm=1i*omega_frequency;

resistor_colm=prop_mat(:,1);
capacitor_colm=1./(prop_mat(:,2)*s_parm);
inductor_colm=prop_mat(:,3)*s_parm;

A_matrix=[resistor_colm capacitor_colm inductor_colm];

[row, col, value] = find(A_matrix);




Y_matrix=zeros(number_of_nodes,number_of_nodes);

end