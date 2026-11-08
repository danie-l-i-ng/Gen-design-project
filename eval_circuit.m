function [FRF_mag, FRF_phase] = eval_circuit(top_mat, prop_mat, output_element,frequency_vector,input_node,ground_node,v_IN)
%   EVAL_CIRCUIT: Analyzes given circuit topology and computes FRF magnitude
%           and phase
%   INPUTS: top_mat - Adjacency matrix containing topology of circuit
%           prop_mat - Matrix containing properties of each element
%           output_element - Element whose voltage is the ouput of the FRF
%           input_node - the node where the input is applied
%           ground_node - the node where the ground is applied
%           v_IN - voltage input (V)
%   OUTPUTS: FRF_mag - list of frequency vs FRF magnitude (in dB)
%             FRF_phase - list of frequency vs FRF phase (in dB)

% initialization

freq_step=numel(frequency_vector);
mag=zeros(freq_step,1);
phase=zeros(freq_step,1);

% create association between elements and global nodes

global_nodes=get_global_nodes(top_mat);
% number_of_nodes=numel(unique(global_nodes));

fixed_nodes=[input_node; ground_node];
free_nodes=setdiff(unique(global_nodes), fixed_nodes);

% evaluate the transfer function at each frequency

for i_index=1:1:length(frequency_vector)

    omega_frequency=frequency_vector(i_index);

    % assemble the y matrix in the form: I = Y * V

    [Y_matrix]=Y_matrix_assemble(global_nodes,prop_mat,omega_frequency);

    if det(Y_matrix) == 0
        fprintf('ERROR ERROR ERROR: The Y matrix is singular. Invalid candiatate. \n')
        return
    end

    % invert the y matrix to find the z matrix in the form: V = Z * I

    % Z_matrix=inv(Y_matrix);

    Voltage=zeros(size(Y_matrix,1),1);
    Voltage(input_node)=v_IN;
    Voltage(ground_node)=0;

    Voltage(free_nodes)=Y_matrix(free_nodes,free_nodes)\(-Y_matrix(free_nodes,fixed_nodes)*Voltage(fixed_nodes));

    % extract the element specific transfer function (voltage across the
    % element) divided the global node

    coords1=global_nodes(2*output_element-1);
    coords2=global_nodes(2*output_element);

    % TF_pointwise=(Z_matrix(coords1)-Z_matrix(coords2))/Z_matrix(coords2);
    TF_pointwise=Voltage(coords1)-Voltage(coords2);

    % calculate the FRF's properties

    mag(i_index,1)=abs(TF_pointwise);
    phase(i_index,1)=angle(TF_pointwise)*(180/pi); % convert to degrees   

end

FRF_mag=mag;
FRF_phase=phase;

end