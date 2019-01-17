function [OPTIONS, MinCost, AvgCost, InitFunction, CostFunction, FeasibleFunction, ...
    MaxParValue, MinParValue, Population,FeasibleFunction_1,CostFunction_1] = Init(DisplayFlag, ProblemFunction, RandSeed)
global zz
% Initialize population-based optimization software.

% WARNING: some of the optimization routines will not work if population size is odd.
OPTIONS.popsize = 20; % total population size
OPTIONS.Maxgen = 200; % generation count limit
OPTIONS.numVar =3; % number of genes in each population member


%{
if ~exist('RandSeed', 'var')
    RandSeed = round(sum(100*clock));
end
rand('state', RandSeed); % initialize random number generator
if DisplayFlag
    %disp(['random # seed = ', num2str(RandSeed)]);
end
%}


% Get the addresses of the initialization, cost, and feasibility functions.
[InitFunction, CostFunction, FeasibleFunction,FeasibleFunction_1,CostFunction_1] = ProblemFunction();
% Initialize the population.
[MaxParValue, MinParValue, Population, OPTIONS] = InitFunction(OPTIONS);
% Make sure the population does not have duplicates. 
Population = ClearDups(Population, MaxParValue, MinParValue);
% Compute cost of each individual  
Population = CostFunction(OPTIONS, Population);
% Sort the population from most fit to least fit
Population = PopSort(Population);
% Compute the average cost
AverageCost = ComputeAveCost(Population);
% Display info to screen
MinCost = [Population(1).cost];
AvgCost = [AverageCost];
if DisplayFlag
    %disp(['The best and mean of Generation # 0 are ', num2str(MinCost(end)), ' and ', num2str(AvgCost(end))]);
end

return;