function [f] = fitness(individual,prop_mat,output_element,bode_data)
%FITNESS Computes fitness of a candidate circuit design
%   INPUTS: individual - "unwrapped" binary string containing connections
%                       between elements
%           prop_mat - Matrix containing properties of each element
%           output_element - Element whose voltage is the ouput of the FRF
%           bode_data - Nx3 where column 1 is frequency and column 2 is
%           desired magnitude and column 3 is desired phase
%   OUTPUTS: f - fitness of indidivual, SSE between circuit FRF and data

end