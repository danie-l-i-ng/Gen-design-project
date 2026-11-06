function [global_nodes] = get_global_nodes(top_mat)
%GET_GLOBAL_NODES Helper for eval_circuit that parses top_mat and computes
%global node connections for each element
%   INPUTS: top_mat - Adjacency matrix containing topology of circuit
%   OUTPUTS: global_nodes - list of global node assignments for each
%   elemental node

global_nodes = zeros(2*(size(top_mat,1)-2),1);

global_node_counter = 3; 

for row=1:size(top_mat,1)
    row_elem = (row-2)*2+[-1 0]; % indices of the elemental nodes for this row in global_nodes
    for col=row+1:size(top_mat,2)
        if top_mat(row,col)
            col_elem = (col-2)*2+[-1 0];
            if row==1 % ground node
                row_elem_node = -1;
            elseif row==2
                row_elem_node = 0;
            else
                row_global_nodes = global_nodes(row_elem);
                col_global_nodes = global_nodes(col_elem);
        
        
                % if elements share non-zero node, they do not need to be
                % assigned
                if any(ismember(row_global_nodes(row_global_nodes~=0),col_global_nodes(col_global_nodes~=0)))
                    continue
                end
                    
                % if element has not appeared in loop yet, automatically assign
                % elemental node 1
                if sum(row_global_nodes)==0
                    row_elem_node = 1;
                else
                    row_elem_node = 2;
                end
            end
            if sum(global_nodes(col_elem))==0
                col_elem_node = 1;
            else
                col_elem_node = 2;
            end
    
            if row_elem_node==-1 % ground node
                global_nodes(col_elem(col_elem_node)) = 1;
            elseif row_elem_node==0 % v_in node
                global_nodes(col_elem(col_elem_node)) = 2;
            else
                if global_nodes(row_elem(row_elem_node))>0
                    global_nodes(col_elem(col_elem_node)) = row_global_nodes(row_elem_node);
                elseif global_nodes(col_elem(col_elem_node))>0
                    global_nodes(row_elem(row_elem_node)) = col_global_nodes(col_elem_node);
                else
                    global_nodes(row_elem(row_elem_node)) = global_node_counter;
                    global_nodes(col_elem(col_elem_node)) = global_node_counter;
                    global_node_counter = global_node_counter + 1;
                end
            end
        end
        
           


    end
end
end