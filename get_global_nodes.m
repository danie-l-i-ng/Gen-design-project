function [global_nodes] = get_global_nodes(top_mat)
%GET_GLOBAL_NODES Helper for eval_circuit that parses top_mat and computes
%global node connections for each element
%   INPUTS: top_mat - Adjacency matrix containing topology of circuit
%   OUTPUTS: global_nodes - list of global node assignments for each
%   elemental node

global_nodes = zeros(2*(size(top_mat,1)-2),1);


for row=1:size(top_mat,1)
    row_elem = (row-2)*2+[-1 0]; % indices of the elemental nodes for this row in global_nodes
    for col=1:size(top_mat,2)
        col_elem = (col-2)*2+[-1 0];
        switch row
            case 1
                if top_mat(row,col) % element connected to ground
                    global_nodes(col_elem(1)) = 1; % 1 is the ground node
                end
            case 2
                if top_mat(row,col)
                    % check if 1st node of col_elem has been used already
                    if ismember(1,global_nodes(col_elem))
                        global_nodes(col_elem(2)) = 2;
                    else
                        global_nodes(col_elem(1)) = 2;
                    end
                end
            otherwise
                if top_mat(row,col)
                    % for row element, check if 

        end

    end
end
end