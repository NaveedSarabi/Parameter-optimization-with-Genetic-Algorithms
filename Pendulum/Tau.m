 function tau = Tau(u)
%TAU PD control for a 1 DOF robot (Pendulum)
%   u: vector of input arguments (defined by the simulink model)

%Joint Position
q1=u(1);

%Joint Velocity
qp1=u(2);

% Control Gains
% Proportional gain
Kp=u(13);
% Derivative gain
Kd=u(14);

% Desired joint position
qd=deg2rad(u(15));
% Regulation then zero
qdp=0;

% Joint position error
Dq=qd-q1;
% Joint velocity error
Dqp=qdp-qp1;

% PD controller
tauo=Kp*Dq+Kd*Dqp;

% we output both, tau (needed for the robot plant), and Dq to integrate it.
tau=[tauo;Dq];


end

