function child = ga_reproduce(population_c,probability,nBits)
%GA_REPRODUCE create a new child from a population based on a random method
%   This function will generate a new child using three different
%   reproduction methods Replication, Crossover, and Mutation.

% Select randomly the reproduction method:
% [Replication, Crosover, Mutation ]
% We want to reduce the probability of the Mutation method, e.g.
% probability_method=[0.40,0.40,0.2] will add more chances to
% Replication and Crossover methods.
% Tip: you can use the randsample function. Type 'help rand sample'
% in the matlab terminal for more information

method=randsample([1 2 3],1,true,[0.40,0.40,0.2]);

switch method
    case 1
        % Task 6b Replication
        disp('---Replication')
        
        % TODO: Select a random individual from the population and assign
        % it as the new child
        % Tip: You can use the function randsample or implement
        % your own selection pool function.
        % Use 'help randsample' to get info about this function
        child=randsample(population_c,1,true,probability);
        disp(child)
        
    case 2
        % Task 6c Crossover
        disp('---Crossover')
        
        % TODO: Randomly select two individuals using the probability
        % Tip: you can use again randsample or your own selection
        % pool function. In this case, the function should return
        % two random individuals.
        individuals_c=randsample(population_c,2,true,probability);
        
        disp("//Random selection");
        for i=1:2
            disp(individuals_c(i))
        end
        
        % TODO: Concatenate the coded parameters p(14bit) and d(14bit)
        % of each selected individual in a single 28bits WORD
        i_l(1,:)=[individuals_c(1).p individuals_c(1).d];
        i_l(2,:)=[individuals_c(2).p individuals_c(2).d];  

        % number of target bits
        m=2;
        % TODO: Random selection of m target bits (2*nBits), see randi.
        rbits=randi(2*nBits,1,m);
        
        % TODO: Option (1) Swap the target bits (rbits) between 
        % random individual 1 and 2
        for i=1:numel(rbits)
            i_l(1,rbits(i))=i_l(2,rbits(i));    
        end
        
        % TODO: Split the 28bit WORD into two parameters
        % p and d (14 bit) each, and add the two crossover individuals
        % to the child
        disp("//Modified");
        child=[];
        %for i=1:2
            %child(i).p=i_l(1,1:14);
            child.p=i_l(1,1:14);
            %child(i).d=i_l(1,15:28);
            child.d=i_l(1,15:28);
            disp(child)
        %end
        
%         % TODO: Option (2) Concatenate 1:rbits from i_l1 and 
%         % rbits+1:n from i_l2
%         % and form a new individual
%         individual_c=[i_l(???) i_l(???)];
% 
%         % TODO: Split the 28bit word into two parameters
%         % p and d (14 bit) each and assign them to the
%         % new child
%         child.p=individual_c(???);
%         child.d=individual_c(???);
%         disp("//Modified");
%         disp(child)
        
    case 3
        % Task 6d Mutation
        disp('---Mutation')
        
        % TODO: Randomly select an individual using the probability
        individual_c=randsample(population_c,1,true,probability);
        
        disp("//Random selection");
        disp(individual_c)
        
        % TODO: Random selection of target bits (1 bit from 2*nBits)
        rbit=randi(2*nBits);
        
        % TODO: Concatenate the coded parameters p(14bit) and d(14bit)
        % in a single 28 bit word
        i_l=[individual_c.p individual_c.d];
        
        % TODO: Negate the target bit in the 28bit word i_l
        % NOTE: operator "~" doesn't work for type (char). Then, we need
        % to implement a simple if-else condition.
        if i_l(rbit)=='0'
            i_l(rbit)='1';
        else
            i_l(rbit)='0';
        end
        
        % TODO: Split the 28bit word into two parameters
        % p and d (14 bit) each and assign them to the new child
        child.p=i_l(1:14);
        child.d=i_l(15:28);

        disp("//Modified");
        disp(child)
        
end



end

