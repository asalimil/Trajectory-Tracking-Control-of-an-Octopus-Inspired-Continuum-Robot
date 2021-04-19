function [T, Xd, Thd] = DesiredPath(X_start,X_end,res)

% Start > t = 0 End > t = 1 
dt = 1/res;

% %% Line Tracking
% % Straight Line > N = 5; threshold = 0.1 res = 10
% Xd = []; Thd = []; T = [];
% for t = 0:dt:1
%     Xd = [Xd (1-t)*X_start + t*X_end];
%     Thd = [Thd zeros(3,1)];
%     T = [T t];
% end

% % Circular Path > N = 5; threshold = 0.1 res = 10
% Xd = []; Thd = []; T = [];
% for t = 0:dt:1
%      Xd = [Xd [0 ; 0 + cos(2*pi*t) ; 5 + sin(2*pi*t)]];
%      Thd = [Thd zeros(3,1)];
%      T = [T t];
% end

% 
% % 2D Ellipsoid Path
% Xd = []; Thd = []; T = [];
% for t = 0:dt:1
%      Xd = [Xd [0 ; 0 + 2*cos(2*pi*t) ; 5 + sin(2*pi*t)]];
%      Thd = [Thd zeros(3,1)];
%      T = [T t];
% end

% %% Ellipsoid Tracking
% % 3D Ellipsoid path
% Xd = []; Thd = []; T = [];
% for t = 0:dt:1
%      Xd = [Xd [0 + cos(2*pi*t) ; 0 + sin(2*pi*t) ; 4 + sin(2*pi*t)]];
%      Thd = [Thd zeros(3,1)];
%      T = [T t];
% end

% % 3D Spiral path
% Xd = []; Thd = []; T = [];
% for t = 0:dt:1
%      Xd = [Xd [3*cos(2*pi*t) ; sin(2*pi*t) ; 3 + 2*t]];
%      Thd = [Thd zeros(3,1)];
%      T = [T t];
% end

% % 3D semi-reaching path
% Xd = []; Thd = []; T = [];
% for t = 0:dt:1
%      Xd = [Xd [3*cos(2*pi*t) ; sin(2*pi*t) ; 3 + 3*t]];
%      Thd = [Thd zeros(3,1)];
%      T = [T t];
% end

% %% Sinusoidal Tracking
% % 3D Sinusoidal path
% Xd = []; Thd = []; T = [];
% for t = 0:dt:1
%      % Xd = [Xd [ 2*t ; 3*sin(2*pi*t); 5 + exp(t)*sin(2*pi*t)]];
%      Xd = [Xd [1*sin(2*pi*t); -1 + 4*t ; 5 + exp(t)*sin(2*pi*t)]];
%      Thd = [Thd zeros(3,1)];
%      T = [T t];
% end

%% Reaching Tracking
% % 3D semi-reaching path
% Xd = []; Thd = []; T = [];
% for t = 0:dt:1
%      Xd = [Xd [3*exp(t)-5 ; 0.5*cos(2*pi*t) ; 1 + 6*t]];
%      Thd = [Thd zeros(3,1)];
%      T = [T t];
% end
% 
%% Fetching Tracking
% 3D semi-reaching path
Xd = []; Thd = []; T = [];
for t = 0:dt:1
     Xd = [Xd [3*exp(1-t)-2 ; 2*cos(2*pi*(1-t)) ; 2 + 6*(1-t)]];
     Thd = [Thd zeros(3,1)];
     T = [T t];
end

end