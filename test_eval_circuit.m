clc; 
clear all; 
close all;

% Parameters
R = 1e3; % Ohms
C = 10e-6; % Farad
L = 1e-6; % Henry


input_node = 1;
ground_node = 2;
v_IN=1;

frequency_vector=logspace(-1, 8, 1000);

% Standard RCL circuit
% adj_matrix = [0 0 1 0 0;
%               0 0 0 0 1;
%               1 0 0 1 0;
%               0 0 1 0 1;
%               0 1 0 1 0];
% 
% prop_matrix = [R 0 0;
%                0 C 0;
%                0 0 L];

adj_matrix=zeros(12,12);

adj_matrix(1,1:12)=[0 0 0 1 0 1 0 0 1 0 0 1];
adj_matrix(2,1:12)=[0 0 1 0 0 0 0 0 0 0 0 0];
adj_matrix(3,3:12)=[0 1 0 0 0 0 0 0 0 0];
adj_matrix(4,4:12)=[0 1 0 0 0 0 0 0 0];
adj_matrix(5,5:12)=[0 1 1 1 0 0 0 0];
adj_matrix(6,6:12)=[0 1 1 0 0 0 0];
adj_matrix(7,7:12)=[0 1 0 1 1 0];
adj_matrix(8,8:12)=[0 0 1 1 0];
adj_matrix(9,9:12)=[0 1 0 0];
adj_matrix(10,10:12)=[0 1 0];
adj_matrix(11,11:12)=[0 1];
adj_matrix(12,12)=0;

adj_matrix=adj_matrix+transpose(adj_matrix);

prop_matrix=[0 0 L;
             0 C 0;
             R 0 0;
             R 0 0;
             0 0 L;
             0 C 0;
             R 0 0;
             0 C 0;
             0 0 L;
             R 0 0];

% RCL Circuit with 2 Resistors in Parallel

% adj_matrix = [0 0 0 0 0 1;
%               0 0 1 0 0 0;
%               0 1 0 1 1 0;
%               0 0 1 0 1 1;
%               0 0 1 1 0 1;
%               1 0 0 1 1 0];
% 
% prop_matrix = [0 C 0;
%     R 0 0;
%     R 0 0;
%     0 0 L];

% RCL Circuit with resistor, capacitor, and inductor in parallel

% adj_matrix=[0 0 0 0 0 0 1; 0 0 1 1 1 0 0; 0 1 0 1 1 1 0; 0 1 1 0 1 1 0; 0 1 1 1 0 1 0; 0 0 1 1 1 0 1; 1 0 0 0 0 1 0];

% prop_matrix=[0 C 0; R 0 0; 0 0 L; R 0 0; 0 0 L];

% Evaluator

[FRF_mag, FRF_phase] = eval_circuit(adj_matrix,prop_matrix, 10,frequency_vector,input_node,ground_node,v_IN);

% Results

figure;

subplot(2,1,1);
semilogx(frequency_vector, 20*log10(FRF_mag), 'LineWidth', 1.5);
grid on;
ylabel('Magnitude (dB)');
title('Circuit Frequency Response');

subplot(2,1,2);
semilogx(frequency_vector, (FRF_phase), 'LineWidth', 1.5);
grid on;
xlabel('Angular frequency (rad/s)');
ylabel('Phase (degrees)');