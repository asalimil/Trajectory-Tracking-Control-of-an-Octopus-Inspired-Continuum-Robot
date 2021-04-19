function PlotLinks(a,b,n)

if mod(n,2) == 1
    % link1
    PlotLine(a(:,1),b(:,6));
    % link2
    PlotLine(a(:,2),b(:,1));
    % link3
    PlotLine(a(:,3),b(:,2));
    % link4
    PlotLine(a(:,4),b(:,3));
    % link5
    PlotLine(a(:,5),b(:,4));
    % link6
    PlotLine(a(:,6),b(:,5));
    
elseif mod(n,2) == 0
    % link1
    PlotLine(a(:,6),b(:,1));
    % link2
    PlotLine(a(:,1),b(:,2));
    % link3
    PlotLine(a(:,2),b(:,3));
    % link4
    PlotLine(a(:,3),b(:,4));
    % link5
    PlotLine(a(:,4),b(:,5));
    % link6
    PlotLine(a(:,5),b(:,6));
    
end

end

% function PlotLinks(a,b)
% 
%     % link1 
%     PlotLine(a(:,1),b(:,2));
%     % link2
%     PlotLine(a(:,2),b(:,3));
%     % link3 
%     PlotLine(a(:,3),b(:,4));
%     % link4
%     PlotLine(a(:,4),b(:,5));
%     % link5
%     PlotLine(a(:,5),b(:,6));
%     % link6
%     PlotLine(a(:,6),b(:,1));
%     
%     drawnow;
% end