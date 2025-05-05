function plotGenerations(fig,vGenerations, vFitness)
%PLOTGENERATIONS generates a 2D plot with all the generations
%   

sG=numel(vFitness);

file=fopen("generations.txt",'w');

fprintf(file,"Gen ind   P      D     Cost\n");
fprintf(1,"Gen ind   P      D     Cost\n");
for i=1:sG
    si=numel(vFitness{i});
    for j=1:si
        fprintf(file,"%d   %d    %4d    %4d   %f\n",i,j,vGenerations{i}(j).p,vGenerations{i}(j).d,vFitness{i}(j));
        fprintf(1,"%d   %d    %4d    %4d   %f\n",i,j,vGenerations{i}(j).p,vGenerations{i}(j).d,vFitness{i}(j));
    end
end

fclose(file);

% Create Color List RGB starting in [0 0 1]

Colors=jet(sG);

if sG>0
    
    f=figure(fig);
    
    %Plotting first generation
    plot3(1,vGenerations{1}(1).p,vGenerations{1}(1).d, 'Marker','o',...
        'Color',[0 1 0.3],'MarkerSize',10,'LineWidth',4);
    hold on 
    grid on
    xlabel('Generation')
    ylabel('P')
    zlabel('D')
    for i=2:numel(vGenerations{1})
        plot3(1,vGenerations{1}(i).p,vGenerations{1}(i).d, 'Marker','o',...
            'Color',[0 1 0.3],'MarkerSize',10,'LineWidth',4);
    end
    
    % Plotting generated populations
    for i=2:sG
        for j=1:numel(vGenerations{i})
            plot3(i,vGenerations{i}(j).p,vGenerations{i}(j).d, 'Marker','+',...
            'Color',Colors(i,:),'MarkerSize',10,'LineWidth',2);
        end
    end
    
    % Plotting the final result  
     plot3(sG,vGenerations{sG}(1).p,vGenerations{sG}(1).d, 'Marker','d',...
            'Color',[0 0 0],'MarkerSize',10,'LineWidth',4);
    
end

%You can save the figure in different formats, e.g. png
saveas(f,"generations.svg",'svg');


end


