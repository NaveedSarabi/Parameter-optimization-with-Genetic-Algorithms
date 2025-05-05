% Task 1: Fitness function
function J = ga_eval(ind, model)
%Save the gains of the individual in a variable for the simulation
% This variable is shared with the simulink model, see
% Pendulum/DSimulator_robot1DOFV.slx
% The simulator will use this values and run the model.
sim_PD=[0,ind.p,ind.d];

% This function stores the variable in the workspace. Then, the
% simulink model will be able to use it.
assignin('base','sim_PD',sim_PD);

%Run the pendulum simulation for 10 seconds
sim(model,10)

%Here you need to get the fitness value from the simulation variable
%"sim_error"
%Remember: sim_error variable is a timeseries with fileds:
% Time - is the time in a n x 1 array where n is the number of
% samples
% Data(:,1) - is the control data (tau) in a n x 1 array
% Data(:,2) - is the joint error data (Dq) in a n x 1 array
% Use this variable to compute your fitness evaluation function

% TODO: Use the sim_error variable to compute the fitness evaluation function
% Tip: see Equations (1.1-1.5)

IAE=0;
ITAE=0;
ISE=0;
IATAU=0;
dt=0; tau=0; Dq=0;
for i = 2:size(sim_error.Data)
    dt=sim_error.Time(i)-sim_error.Time(i-1);
    tau=sim_error.Data(i,1)+sim_error.Data(i-1,1);
    Dq=sim_error.Data(i,2)+sim_error.Data(i-1,2);
    ISE=ISE+dt*((abs(Dq)/2)^2);
    IAE=IAE+dt*(abs(Dq)/2);
    ITAE=ITAE+dt*(abs(Dq)/2)*sim_error.Time(i-1);
    IATAU=IATAU+dt*(abs(tau)/2);
end
w1=1;
w2=1;
w3=1;
w4=1;

% Cost function\\\
J=-(w1*ISE+w2*IAE+w3*ITAE+w4*IATAU);
end
