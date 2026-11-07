clc; 
clear all; 
close all;


% adj_matrix = [0 0 1 0 0;
%               0 0 0 0 1;
%               1 0 0 1 0;
%               0 0 1 0 1;
%               0 1 0 1 0];

% adj_matrix = [0 0 0 0 0 1;
%               0 0 1 0 0 0;
%               0 1 0 1 1 0;
%               0 0 1 0 1 1;
%               0 0 1 1 0 1;
%               1 0 0 1 1 0];

adj_matrix=[0 0 0 0 0 0 1; 0 0 1 1 1 0 0; 0 1 0 1 1 1 0; 0 1 1 0 1 1 0; 0 1 1 1 0 1 0; 0 0 1 1 1 0 1; 1 0 0 0 0 1 0];


R = 1e3; % Ohms
C = 10e-6; % Farad
L = 1e-6; % Henry

% prop_matrix = [R 0 0;
%                0 C 0;
%                0 0 L];

% prop_matrix = [0 C 0;
%               R 0 0;
%               R 0 0;
%               0 0 L];

prop_matrix=[0 C 0; R 0 0; 0 0 L; R 0 0; 0 0 L];

input_node = 1;
ground_node = 2;
v_IN=1;

frequency_vector=logspace(-1, 8, 1000);

[FRF_mag, FRF_phase] = eval_circuit(adj_matrix,prop_matrix, 1,frequency_vector,input_node,ground_node,v_IN);

figure;

subplot(2,1,1);
semilogx(frequency_vector, 20*log10(FRF_mag), 'LineWidth', 1.5);
grid on;
ylabel('Magnitude (dB)');
title('Circuit Frequency Response');

subplot(2,1,2);
semilogx(frequency_vector, FRF_phase, 'LineWidth', 1.5);
grid on;
xlabel('Angular frequency (rad/s)');
ylabel('Phase (degrees)');