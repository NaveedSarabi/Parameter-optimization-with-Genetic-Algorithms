function Qpp=Dinamic_robot1DOFV(u)
%DINAMIC_ROBOT1DOFV Dynamic model of a 1 DOF robot (Pendulum)
%   u: vector of input arguments (defined by the simulink model)

%Joint Position
q1=u(1);

%Joint Velocity
qp1=u(2);

%Kinematic Parameters
l2=u(4);

%Dynamic Parameters
m1=u(5);

% Inertia tensor
I133=u(6);


%Viscous Friction Matrix
Beta(1,1)=u(9);
%Gravity Vector
gx=u(10);
gy=u(11);

%Joint Position Vector
Q=q1;

%Joint Velocity Vector
Qp=qp1;

%Inertia Matrix
M(1,1)=I133 + l2^2*m1;


%Centripetal and Coriolis Matrix
C(1,1)=0;


%Gravitational Torques Vector
G(1,1)=l2*m1*(gy*cos(q1) - gx*sin(q1));

% Control
Tao=u(13);

% Direct dynamic model
Qpp=(M)\(Tao-C*Qp-G-Beta*Qp);
