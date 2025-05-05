function X=FK_robot1DOFV(u)
%FK_ROBOT1DOFV Forward kinematics of a 1 DOF robot (Pendulum)
%   u=[q1 l1]: vector of input arguments (defined by the simulink model)

q1=u(1);
l1=u(2);
X=[ l1*cos(q1);
l1*sin(q1);
0];
