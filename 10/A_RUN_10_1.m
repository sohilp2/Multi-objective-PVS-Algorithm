function A_RUN_10_1()

clc;
clear all;
format long

run=3;


global l
% fprintf('\nprob10_1\n');

%     fprintf('\nPVS\n'); 
for l=0.01:0.01:0.99
for i=1:run  
        PVS(@prob10_1);
end
end
    
