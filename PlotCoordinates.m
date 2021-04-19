function PlotCoordinates(u1,u2,u3)

% plot3(u1,u2,u3, 'p-b')
plot3(u1(:,1),u1(:,2),u1(:,3), '^-b', 'LineWidth' , 2);
hold on;
plot3(u2(1,:),u2(2,:),u2(3,:), 'v-r' , 'LineWidth' , 2)
hold on;
plot3(u3(1,:),u3(2,:),u3(3,:), 'v-k' , 'LineWidth' , 2)
hold on;
grid on

end