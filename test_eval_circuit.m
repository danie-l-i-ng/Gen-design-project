clc; clear all; close all;

adj_matrix = [0 0 1 0 0;
              0 0 0 0 1;
              1 0 0 1 0;
              0 0 1 0 1;
              0 1 0 1 0];
R = 1e3; % Ohms
C = 10e-6; % Farad
L = 1e-6; % Henry

prop_matrix = [R 0 0;
               0 C 0;
               0 0 L];

[FRF_mag, FRF_phase] = eval_circuit(adj_matrix,prop_matrix, 1);