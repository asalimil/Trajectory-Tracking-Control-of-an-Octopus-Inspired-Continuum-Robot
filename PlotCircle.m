function PlotCircle(O,R,Rot,str)

% inputs : Origin , Radius , Rotation
    t = 0:0.2:2*pi;
    
    for n = 1:length(t)
        dx = R*cos(t(n));
        dy = R*sin(t(n));
        dz = 0;
        Points = Rot*[dx;dy;dz];
        if str == 's' || str == 'e'
            plot3(O(1)+Points(1), O(2)+Points(2), O(3)+Points(3),'.k','LineWidth',1)
        else 
            plot3(O(1)+Points(1), O(2)+Points(2), O(3)+Points(3),'.-k','LineWidth',0.1)
        end
        hold on; 
        % grid on;
    end

end