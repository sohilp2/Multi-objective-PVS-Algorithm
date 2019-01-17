function [InitFunction, CostFunction, FeasibleFunction,FeasibleFunction_1,CostFunction_1 ] = prob10_1

InitFunction = @prob10_1Init;
CostFunction = @prob10_1Cost;
CostFunction_1 = @prob10_1Cost_1;
FeasibleFunction = @prob10_1Feasible;
FeasibleFunction_1 = @prob10_1Feasible_1;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [MaxParValue, MinParValue, Population, OPTIONS] = prob10_1Init(OPTIONS)

global MinParValue MaxParValue ll ul
Granularity = 1;
%MinParValue = 1;

%%%%%%%%% for result 
ll=[-1 -1 -1];
ul=[1 1 1];



MaxParValue = ul;
MinParValue=ll;

% Initialize population
for popindex = 1 : OPTIONS.popsize
    
    for k = 1 : OPTIONS.numVar
        %chrom(k) =round(ll(k)+ (ul(k) - ll(k)) * rand);
        chrom(k) =(ll(k)+ (ul(k) - ll(k)) * rand);
    end
    %chrom =floor(0+ (MaxParValue - 0) * rand(1,OPTIONS.numVar));
    %chrom1 =(MinParValue + (MaxParValue - MinParValue+1 ) * rand(1,OPTIONS.numVar));
    %fprintf(1,'\n chr= %f',chrom);
    
    
    Population(popindex).chrom = chrom;
    %Population(popindex).chrom1 = chrom1;
end
OPTIONS.OrderDependent = true;
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population] = prob10_1Cost(OPTIONS, Population)

% Compute the cost of each member in Population

global MinParValue MaxParValue
popsize = OPTIONS.popsize;
for popindex = 1 : popsize
    
    for k = 1 : OPTIONS.numVar
        x(k) = Population(popindex).chrom(k);
    end
    Population(popindex).cost = obj_prob10_1(x);
end
return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population_1] = prob10_1Cost_1(OPTIONS, Population)

% Compute the cost of each member in Population

global MinParValue MaxParValue
popsize = size(Population,1);
for popindex = 1 : popsize
    x=[];
    for k = 1 : OPTIONS.numVar
        x(k) = Population(popindex,k);
    end
    Population_1(popindex) = obj_prob10_1(x);
end
return


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population] = prob10_1Feasible(OPTIONS, Population)

global MinParValue MaxParValue ll ul
for i = 1 : OPTIONS.popsize
    for k = 1 : OPTIONS.numVar
        Population(i).chrom(k) = max(Population(i).chrom(k), ll(k));%always chage this mini value
        Population(i).chrom(k) = min(Population(i).chrom(k), MaxParValue(k));
    end
end
return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Population_1] = prob10_1Feasible_1(OPTIONS, Population_1)

global MinParValue MaxParValue ll ul
%for i = 1 : OPTIONS.popsize
for i = 1 : size(Population_1,1)
    for k = 1 : OPTIONS.numVar
        
        if Population_1(i,k)<ll(k)
            Population_1(i,k)=ll(k)+(rand*(ul(k)-ll(k)));
        end
            
        if Population_1(i,k)>ul(k)
            Population_1(i,k)=ll(k)+(rand*(ul(k)-ll(k)));
        end
        

    end
end
return;