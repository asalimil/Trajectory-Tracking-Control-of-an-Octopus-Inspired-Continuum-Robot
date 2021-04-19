function PlotGS(disk,n,str)

% axis([-1 1 -1 1 0 10])
axis equal


%% AXIS
% axis([-2 2 -2 2 0 5.5]); % Ellipsoid
% axis([-1 4 -1 4 0 8]); % Line
% axis([-2 2 -2 4 0 8]); % Sinusoidal 
% axis([-3 3 -2 2 0 7]); % Reaching
% axis([-1 7 -3 3 -1 9]); % Fetching

% Disk data
a = disk(n-1).a;
A = disk(n-1).r;
Pa = disk(n-1).P;
Ra = disk(n-1).R;

b = disk(n).a;
B = disk(n).r;
Pb = disk(n).P;
Rb = disk(n).R;

% plot EE
PlotCircle(Pb,B,Rb,str)

% plot base
PlotCircle(Pa,A,Ra,str)

%% Plot Cylinders
PointsBase = TestPlotCircle(Pa,A,Ra);
PointsEE = TestPlotCircle(Pb,B,Rb);
X = [PointsEE(1,:) ; PointsBase(1,:)];
Y = [PointsEE(2,:) ; PointsBase(2,:)];
Z = [PointsEE(3,:) ; PointsBase(3,:)];

% s = surf(X,Y,Z,'FaceAlpha',0.5);
s = surf(X,Y,Z);
if str == 's' || str == 'e'
    s.EdgeColor = 'none';
    s.EdgeColor = [30,144,255]/255;
    s. LineStyle = '-';
    s. FaceAlpha = 0.5;
elseif str == 'm'
    % s.EdgeColor = 'none'; %    
    % s.EdgeColor = [0.2 0.5 0.8];
    s.EdgeColor = [135,206,250]/255;
    % s.EdgeColor = [169/255,169/255,169/255];
    s. LineStyle = '-';  %    
    % s. LineStyle = 'none';
%    s. FaceColor = 'flat';
     % s. FaceColor = 'none'; %     % s. FaceColor = [0 0 0];
     s. FaceLighting ='flat'; % s. FaceLighting = 'none';
     s. FaceAlpha = 0.5;
end
%     % plot joints
%     PlotJoints(a,b);
%
% plot links, n should get # of segment
%     nseg = n-1;
%     PlotLinks(a,b,nseg)

end
