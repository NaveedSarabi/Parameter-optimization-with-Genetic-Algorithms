function simpleRobotPlotv2_pendulum(u)
%SIMPLEROBOTPLOT Plot a vertical pendulum (1 DOF robot)
%   u: vector of input arguments (defined by the simulink model)

persistent handles told qd_old


%Joint Position
q1=u(1);

%Kinematic Parameters
l1=u(3);

%Time
t=u(8);

% Desired position (no orientation)
qd=deg2rad(u(14));%u();

% EFd position
xefd_w=FK_robot1DOFV([qd l1]);

% EF position
xef_w=FK_robot1DOFV([q1 l1]);

fig=6;

% Visualization area
initSize=1.5;

% Plottig paramters
ms=8;
lw=2;

if t==0
    
    
    if (ishandle(fig) && strcmp(get(fig, 'type'), 'figure'))
        % If the figure exists
        % Delete all objects in the figure (reset figure)
        allHandles=findobj(fig);
        EraseCFHandles(allHandles);
    else
        % If the fig doesn't exist
        % Initializes the figure where the robot will be plotted
        f=figure(fig);
        f.Position=[55         266        1253        1056];
        
        axis(initSize*[-1 1 -1 1]);
        view([0 90])
        hold on
        grid on
    end
    
    % Deletes all the persistent variables
    clear plotRobot
    
    % Desired robot position
    hd=plot([0;xefd_w(1)],[0;xefd_w(2)],'LineStyle','--','Color',[1 0 0],...
        'Marker','o','MarkerSize',ms,'MarkerFaceColor',[1 0 0],...
        'LineWidth',lw);
    % Real robot position
    hj=plot([0;xef_w(1)],[0;xef_w(2)],'LineStyle','-','Color',[0 0 1],...
        'Marker','o','MarkerSize',ms,'MarkerFaceColor',[0 0 1],...
        'LineWidth',lw);
    % Robot center
    ch=plot(0,0,'Marker','o','Color',[0 0 0],'MarkerSize',ms,...
        'MarkerFaceColor',[0 0 0],'LineWidth',lw);
    
    % Joint position label
    tag=sprintf('q_1=%2.2f',rad2deg(q1));
    hText=text(0,0,tag, 'fontsize',8,'fontweight','b');
    
    handles=[ch;hd;hj;hText];
    
    told=-1;
    
    qd_old=qd;
end

% Defines the refresh rate for visualizing the robot
sT=str2double(get_param('DSimulator_robot1DOFV','FixedStep'));
sampleTime=33*sT;%30/60 Hz refresh rate

% Plot desired position (if it changes)
Dqt=qd-qd_old;
if (abs(Dqt)>0)
    
    %Update desired robot position
    handles(2).XData=[0 xefd_w(1)];
    handles(2).YData=[0 xefd_w(2)];
    qd_old=qd;
end

% Plot robot
if((~mod(t,sampleTime))&&(t~=0.0)&&(t~=told))
    % Update robot position
    handles(3).XData=[0 xef_w(1)];
    handles(3).YData=[0 xef_w(2)];
    
    % Update label
    tag=sprintf('q_1=%2.2f',rad2deg(q1));
    handles(4).Position=xef_w(1:2,1)+0.03;
    handles(4).String=tag;
    
    %Refresh figure
    drawnow
    
end



end

