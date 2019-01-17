function PVS(ProblemFunction, DisplayFlag, ProbFlag)
global ll
global ul
global ov counter_FE func_number local_method;

format long

if ~exist('DisplayFlag', 'var');DisplayFlag = true; end

Population.chrom=[];
Population.cost=[];

[OPTIONS, MinCost, AvgCost, InitFunction, CostFunction, FeasibleFunction, ...
    MaxParValue, MinParValue, Population,FeasibleFunction_1,CostFunction_1] = Init(DisplayFlag,ProblemFunction);

Keep=1;
norm_factor=1; %%%constant for normalization
VF=1; %% velocity factor   

% Begin the optimization loop
for GenIndex = 1 : OPTIONS.Maxgen
         %Save the solutions in a temporary array.
            for i = 1 : Keep
                chromKeep(i,:) = Population(i).chrom;
                costKeep(i) = Population(i).cost;
            end
 
    % Save population in variable temp_1        
    for i=1:OPTIONS.popsize
        temp_1(i,:)=Population(i).chrom;
        temp_1_cost(i)=Population(i).cost;
    end


    Pop_size=OPTIONS.popsize;
    for k = 1 : OPTIONS.popsize
            r=[]; v=[];
           r(1) = k;
           while true;
               r(2) = round(OPTIONS.popsize * rand + 0.5);
                if (r(2) ~= r(1)), break, end
           end
            while true
                r(3) = round(OPTIONS.popsize* rand + 0.5);
                if (r(3) ~= r(1)) && (r(3) ~= r(2)), break, end
            end
        
        r2=r; % temp save r in r2
        r=(norm_factor/Pop_size)*r;%normalization eq 16 
        r1=r;% save r in r1
        v1=(rand(1,3)).*(VF-r1);% generate random velocity eq 17 
        
        
        %%%% Passing vehicle procedure %%%
        y=abs(r1(3)-r1(2)); %eq 18
        x=abs(r1(3)-r1(1)); % eq 19
        x1=(x*v1(3))/(v1(1)-v1(3));%% dist travelled by 3 /eq 4
        y1=(x*v1(2))/(v1(1)-v1(3));%%%dist travelled by 2 /eq 5
       
        %%% passing vehicle conditions%%%
        if v1(1)>v1(3) %step 6
                if (y-y1)>x1;
                con1=v1(1)/(v1(1)-v1(3)); % eq 23
                    % eq 20                    
                    temp_1_new=  Population(r2(1)).chrom+ con1*rand(1,OPTIONS.numVar).*(Population(r2(1)).chrom-Population(r2(3)).chrom);    
                else
                    % eq 21
                        temp_1_new=  Population(r2(1)).chrom+ rand(1,OPTIONS.numVar).*(Population(r2(1)).chrom-Population(r2(2)).chrom);    
                 end
        else
                    % eq 22
                        temp_1_new =  Population(r2(1)).chrom+ rand(1,OPTIONS.numVar).*(Population(r2(3)).chrom-Population(r2(1)).chrom);    
        end
                
       
                    temp_1_new = FeasibleFunction_1(OPTIONS, temp_1_new);
                    temp_1_new_cost = CostFunction_1(OPTIONS, temp_1_new);
                    if temp_1_new_cost<Population(k).cost
                        Population(k).chrom =temp_1_new;
                        Population(k).cost=temp_1_new_cost;
                    end
 end %% pop end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
       
            Population = PopSort(Population);
            %Replace the worst with the previous generation's elites.
            n = length(Population);
            for i = 1 : Keep
            Population(n-i+1).chrom = chromKeep(i,:);
            Population(n-i+1).cost = costKeep(i);
            end
  
       Population = ClearDups(Population, MaxParValue, MinParValue);
       Population = PopSort(Population);

    MinCost = [MinCost Population(1).cost];
        
    FE=(GenIndex (end)*OPTIONS.popsize+OPTIONS.popsize);


    
        %% print each iteration result
%          fprintf('\n %f',MinCost(end));
   
end%%%%% end of generation
% disp([num2str(Population(1).cost)]);
disp([num2str(Population(1).chrom)]);
