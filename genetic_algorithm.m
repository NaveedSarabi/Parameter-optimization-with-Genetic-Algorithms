%% Clean the workspace
clear all
clc

figure=5;

% Close Figure 5

if ishandle(figure)
    close(figure);
end

%% Initialization
tic
% The dir "pendulum" contains the model (simulator) that we will use to
% evaluate each individual of the pupulation in our GA.
% we need to add it to the matlab path, then the ga_eval function can
% find the model
addpath('Pendulum');

%TODO: Define the maximum population
maxPop=25;
%TODO: Define the number of generations
generations=50;

% Decimal factor to convert integer numbers to float numbers. We will use 2 decimals precision
df=100.0;

% Max parameter value. It corresponds to 10000/100.0=100.0 as max value for
% Kp. We will use maxVal/2 for the values of Kd.
maxVal=10000;
% Number of bits 
nBits=14; % 14 bits=> It can contain up to 16383>maxVal 

% Container for the population (integer)
population=[];

%Task 2: First create an initial random population
% population will be an array of struct 'individual'
for i = 1:maxPop
    % The individuals are structs containing gains p and d.
    % The structs variables are defined using ".", e.g.
    % individual.p=1, individual.d=2, will create a
    % structure 'individual' with two fields.
    % TODO: create the random integer values
    individual_d.p=randi(maxVal);%(maxVal)
    individual_d.d=randi(maxVal/2);%(maxVal/2);
    % TODO: append the newly created individual to the array 'population'
    population=[population individual_d];
end

% Container variables to save all the generations (for plotting)
vGenerations{1}=population;
vGenerations{generations+1}=[];

%% GA

% Task 7b: Iterate through the number of Generations
for gen = 1:generations
    % Container for the new population
    % In each generation we will create a new population which evolves
    % using the GA
    
    % Container for the new population, created from the reproduction process
    newPop_c=[];
    
    % Container for the binary codified population
    population_c=[];
    
    
    % Container for the fitness values (results of evaluating the
    % individuals in the model.
    fitnessL=[];
    
    fprintf(1,"+++++++++++Generation: %d\n",gen);
    
    %Task 3: Get the fitness value of each individual
    % Evaluate each individual, i.e. each Kp, Kd in the simulink-model and
    % calculate the error (fitness value)
    % Iterate through the size of the population
    
    for i = 1:numel(population)
        
        fprintf(1,'{%d}Individual(%d): \n',gen,i);
        disp(population(i)); % --> it can be used with structures!
        
        % TODO: Convert the individuals' parameters (defined as integer numbers
        % by the function --randi--) to floats with 2 decimals
        individual.p=population(i).p/df;
        individual.d=population(i).d/df;
        % Run the model using each individual values (p,d), the model
        % will calculate an error function and return it. This value
        % will be used as fitness value.
        % TODO: define the simulation model: 
        % a) 'Pendulum/DSimulator_robot1DOFV.slx' (visualization) or 
        % b) 'Pendulum/DSimulator_robot1DOFV_NG.slx' (No visualization)
        fitness=ga_eval(individual,'Pendulum/DSimulator_robot1DOFV_NG');
        fprintf(1,'Fitness Value: \n');
        disp(fitness);
        
        % TODO: Append the fitness value of the individual(i) to the array
        % The population and fitnessL array will have the same order,
        % i.e. the fitness value of the individual 'population(i)' is
        % fitnessL(i)
        fitnessL=[fitnessL fitness];
        
        % Task 4: Codification using nBits (see dec2bin function)
        individual_c.p=dec2bin(population(i).p,nBits);
        individual_c.d=dec2bin(population(i).d,nBits);
        
        
        disp(individual_c);
        
        
        % TODO: add the codified individual (individual_c) to the 
        % Population with binary codification (population_c)
        population_c=[population_c individual_c];
        
        disp("------------------------");
        
    end
    
    %% Task 5: Probabilities
    % Convert the fitnessL vector into probabilities. The higher the number
    % the higher the probability.
    
    % Tip:  1) define a threshold as the lowest score + 10%
    %       2) substract the threshold
    %       3) get the probabilities
    % probability is an array with the same dimension as fitnessL 
lowest = min(fitnessL);
threshold = lowest + 0.1 * lowest;
diffL=fitnessL-threshold;
sumL=sum(diffL);
prob=0;
probability=[];

for i = 1:numel(diffL)
    prob=diffL(i)/sumL;
    probability = [probability prob];
end
    
    
    %% Task 6: Reproduction
    
    % Task 6a Elitsm: choose the individual with the best fitness and add it to
    % the new population.
    % Tip1: remember that population_c and fitnessL have the same order.
    % Tip2: The max function returns the max value found in an array, and
    % its index, type 'help max' to get more information
    [bestFit,bestIdx]=max(fitnessL);
    % TODO: Get the best individual using the obtained index from 'max' 
    bestInd=population_c(bestIdx);
    % TODO: Add the best individual to the new population list
    % In this way, the new population will always have the best
    % individual found during the generations
    newPop_c=[newPop_c bestInd];
    
    % Loop until you have created a new population of size = maxPop
    while length(newPop_c)<maxPop

        % Generate a new child with the function ga_reproduce
        child=ga_reproduce(population_c,probability,nBits);
        
        % TODO: add the new child to the new population
        newPop_c=[newPop_c child];
    end
    
    % Task 7 Decode the new population (newPop_c) into a Decimal
    % representation (newPop), using the function bin2dec

    newPop=[];
    for i=1:numel(newPop_c)
        individual.p=bin2dec(newPop_c(i).p);
        individual.d=bin2dec(newPop_c(i).d);
        
        % TODO: add the decodified individual to the new population
        newPop=[newPop individual];
    end
    
    % TODO: Assign the new decodeded population (newPop) to the population to
    % process the new generation (iteration)
    population=newPop;
    
    % Save the decoded new population (newPop) and the
    % list of scores (fitnessL) in two cells to print them at the end.
    vGenerations{gen+1}=newPop;
    vFitness{gen}=fitnessL;
    
    fprintf(1,"Best Individual Generation {%d}: PD(%d,%d) c[%f]\n",gen,newPop(1).p/df,newPop(1).d/df,fitnessL(bestIdx));
end

toc

% The last generation is not re-evaluated, then we assign 0 as their score.
vFitness{generations+1}=zeros(1,numel(newPop));


%Save the best gains in a variable for the final simulation
% This variable is shared with the simulink model, see
% Pendulum/DSimulator_robot1DOFV.slx
% The simulator will use this values when running the model.
best_individual=vGenerations{end}(1);

% Assign the best individual to the global variable sim_PD to run the
% simulation
sim_PD=[0,best_individual.p/df,best_individual.d/df];

% This function stores the variable in the workspace. Then, the
% simulink model will be able to use it.
assignin('base','sim_PD',sim_PD);

% %Enable these lines if you want to run the simulator after the GA
% %Run the pendulum simulation for 10 seconds (with visualization)
% sim('Pendulum/DSimulator_robot1DOFV.slx',10);

% Plot all the individuals of each generation with different colors. Save
% the Generations and their scores in a txt file.
plotGenerations(figure,vGenerations, vFitness);


