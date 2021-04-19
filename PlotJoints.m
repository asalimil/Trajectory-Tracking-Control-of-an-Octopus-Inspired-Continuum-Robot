function  PlotJoints(a,b)

% Joints on base
    plot3(a(1,1),a(2,1),a(3,1),'ob','LineWidth',1)
    plot3(a(1,2),a(2,2),a(3,2),'ob','LineWidth',1)
    plot3(a(1,3),a(2,3),a(3,3),'og','LineWidth',1)
    plot3(a(1,4),a(2,4),a(3,4),'og','LineWidth',1)
    plot3(a(1,5),a(2,5),a(3,5),'oy','LineWidth',1)
    plot3(a(1,6),a(2,6),a(3,6),'oy','LineWidth',1)

    
% Joints on EE >> B : b in global frame
    B = b;
    plot3(B(1,1),B(2,1),B(3,1),'ob','LineWidth',1)
    plot3(B(1,2),B(2,2),B(3,2),'ob','LineWidth',1)
    plot3(B(1,3),B(2,3),B(3,3),'og','LineWidth',1)
    plot3(B(1,4),B(2,4),B(3,4),'og','LineWidth',1)
    plot3(B(1,5),B(2,5),B(3,5),'oy','LineWidth',1)
    plot3(B(1,6),B(2,6),B(3,6),'oy','LineWidth',1)
    % drawnow;
    
end