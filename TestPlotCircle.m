function Points = TestPlotCircle(O,R,Rot)

% inputs : Origin , Radius , Rotation
    t = 0:0.1:2*pi;
    Points = [];
    for n = 1:length(t)
        dx = R*cos(t(n));
        dy = R*sin(t(n));
        dz = 0;
        P = Rot*[dx;dy;dz];
        plot3(O(1)+P(1), O(2)+P(2), O(3)+P(3),'--k','LineWidth',1)
        hold on; 
        % grid on;
        Points = [Points [O(1)+P(1) ; O(2)+P(2) ; O(3)+P(3)]];
    end

end