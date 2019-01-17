function [Population] = ClearDups(Population, MaxParValue, MinParValue)


global ll zz
% Make sure there are no duplicate individuals in the population.
% This logic does not make 100% sure that no duplicates exist, but any duplicates that are found are
% randomly mutated, so there should be a good chance that there are no duplicates after this procedure.
for i = 1 : length(Population)
    Chrom1 = (Population(i).chrom);
    for j = i+1 : length(Population)
        Chrom2 = (Population(j).chrom);
       
        Chrom3=Chrom1./Chrom2;
        %Chrom4=ones(1,length(ll))+0.00001;
        Chrom4=ones(1,length(ll));
        
        
        if isequal(Chrom1, Chrom2)
           % if isequal(Chrom3, Chrom4)
          % if rand<0.1
                fff=1;
                
               parnum = floor(1+(length(Population(j).chrom)-1) * rand);
            
            if length(MaxParValue)==1
                Population(j).chrom = (MinParValue + (MaxParValue - MinParValue ) * rand);
           
              % Population(j).chrom(parnum) = (MaxParValue + MinParValue)/2 * rand;
         
            else
              Population(j).chrom(parnum) = (ll(parnum) + (MaxParValue(parnum) - ll(parnum)) * rand);
            end
              
            end
    end
end
return;