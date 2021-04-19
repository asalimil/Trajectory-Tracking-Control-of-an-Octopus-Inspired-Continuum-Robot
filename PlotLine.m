function PlotLine(Start,End)

    N = 10;   % Number of Points between the start and points 
    
    Dx = Start(1):(End(1)-Start(1))/N:End(1);
    Dy = Start(2):(End(2)-Start(2))/N:End(2);
    Dz = Start(3):(End(3)-Start(3))/N:End(3);
    
    if isempty(Dz) == 1
        Dz = Start(3)*ones(length(Dx),1); % length(Dx or Dy)
    elseif isempty(Dy) == 1
        Dy = Start(3)*ones(length(Dx),1); % length(Dx or Dz)
    elseif isempty(Dx) == 1
        Dx = Start(3)*ones(length(Dy),1); % length(Dy or Dz)
    end
        
        
    % plot line
    plot3(Dx,Dy,Dz,'-k','LineWidth',1)

end