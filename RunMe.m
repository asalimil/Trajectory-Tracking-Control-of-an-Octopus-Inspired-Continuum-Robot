clc; clear; close all;

%% dtc = 0.01;
% dtc = 0.01; % original
dtc = 0.001;

%% Create Model
N = 20; K = 0.95;
disk = createmodel(N,K);
for i = 1:N+1
    [th, phi, psi] = Rot2Angles(disk(i).R);
    disk(i).pose = [disk(i).P ; [th ; phi ; psi]];
end

%% threshold = 0.025;
% threshold = 0.1; % original
threshold = 0.05;
RMSp = inf;

%% Desired Path
% path resolution >> just for plot

% plotres = 1;
plotres = 4;
% plotres = 10;
% res = 50; % original
Npoints = 50;
% dt = 1/res; % original

% % path resolution >> for output result
% plotres = 6;
% res = 50; dt = 1/res;

% straight line
% X_start = disk(end).P; X_end = [3;2;8];
X_start = [-0.5;0.5;6]; X_end = [2.5;3.5;7];
[t, Xd, Thd]= DesiredPath(X_start,X_end,Npoints);
plot3(Xd(1,:),Xd(2,:),Xd(3,:),'--r','LineWidth',1); grid on; hold on; drawnow;
% axis([-2 2 -2 2 0 5.5]); % Ellipsoid
% axis([-1 4 -1 4 0 8]); % Line
% axis([-2 2 -2 4 0 8]); % Sinusoidal
% axis([-3 3 -2 2 0 7]); % Reaching
axis([-1 7 -3 3 -1 9]); % Fetching
Posed = [Xd ; Thd];

% axis equal

%*** Plot Multi-Segment Robot
for cc = 2:N+1
    PlotGS(disk,cc,'s');
end
drawnow; hold on; grid on;
%***

RMSE = [];
Error = [];
iteration = 0;
%% Main Lopp
f = 0; time = 0;
for i = 1:size(Xd,2)
    
    posed = Posed(:,i);
    error = disk(end).pose(1:3)-posed(1:3);
    RMS = rms(disk(end).pose-posed);
    % clf;
    while (RMS > threshold)
        % disp(['RMS : ', num2str(RMS)]);
        % clf;
        % ti = t(i); % original
        f = f+1;
        J66n = []; J63n = []; Q = [];
        plot3(Xd(1,:),Xd(2,:),Xd(3,:),'--r','LineWidth',1); hold on; grid on;
        % axis([-2 2 -2 2 0 5.5]); % Ellipsoid
        % axis([-1 4 -1 4 0 8]); % Line
        % axis([-2 2 -2 4 0 8]); % Sinusoidal
        % axis([-3 3 -2 2 0 7]); % Reaching
        axis([-1 7 -3 3 -1 9]); % Fetching
        xlabel('x');ylabel('y');zlabel('z');
        
        for n = 2:N+1
            [seg(n-1).qi,seg(n-1).si] = GSIKP(disk,n);
            Q = [Q ; seg(n-1).qi];
            
            % Jacobian > pose control
            seg(n-1).J66 = GSJacobian(seg,disk,n,6);
            J66n = [J66n ; seg(n-1).J66];
            
            % % Jacobian > position control
            % seg(n-1).J63 = GSJacobian(seg,disk,n,3);
            % J63n = [J63n ; seg(n-1).J63];
        end
        % rank(pinv(J66n(1:3,:)))
        % size(null(pinv(J66n(1:3,:))))
        null(pinv(J66n(1:3,:)));
        % Jacobian Inverse Control
        % position control
        % dQAll = JacInvControl(J63n,disk(end).pose,Posed,Q,dt); % global coordinates
        % pose control
        dQAll = JacInvControl(J66n,disk(end).pose,posed,Q,dtc); % global coordinates
        
        % Update pose
        DP = zeros(3,1); DR = eye(3);
        for c = 2:N+1
            disk(c).dX = pinv(seg(c-1).J66)*dQAll(6*(c-2)+1:6*(c-1));
            
            % update position
            disk(c).dp = disk(c).dX(1:3,:);
            DP = DP + disk(c).dp;
            disk(c).P = disk(c).P + DP;
            
            % update rotation
            disk(c).dth = disk(c).dX(4:6);
            disk(c).dR = Angle2R(disk(c).dth(1),disk(c).dth(2),disk(c).dth(3));
            DR = DR*disk(c).dR;
            disk(c).R = DR*disk(c).R;
            
            % update a vector
            disk(c).a = update_a(c,disk(c).r,disk(c).P,disk(c).R);
            
            % update pose
            [th,phi,psi] = Rot2Angles(disk(c).R);
            disk(c).pose = [disk(c).P ; [th ; phi ; psi] ];
            % PlotGS(disk,c);
        end
        % drawnow; hold on; grid on;
        
        RMS = rms(disk(end).pose-posed);
        error = disk(end).pose(1:3)-posed(1:3);
        % plot(t,RMSp,'-*b'); hold on; drawnow; grid on
        
        % clf;
        % if i >= 2
        iteration = iteration + 1;
        RMSE = [RMSE; iteration RMS];
        % Error = [Error ; error'];
        Error = [Error; iteration norm(error')];
        % end
        time = time + dtc;
    end
    disp(['point: ', num2str(i), ',  time: ', num2str(time)]);
    
    %% *** Plot Multi-Segment Robot
    if mod(i-1,plotres) == 0
        if i ~= Npoints+1
            for cc = 2:N+1
                PlotGS(disk,cc,'m');
            end
        else
            for kk = 2:N+1
                PlotGS(disk,kk,'e');
            end
        end
        drawnow; hold on; grid on;
        xlabel('X'); ylabel('Y'); zlabel('Z');
    end
    % axis([-1.5 1.5 -1.5 1.5 0 5.5])
    %***
    if i > 1
        M(i-1) = getframe;
    end
    %% clf;
end
% figure();
% movie(M,200)
video = VideoWriter('ReachingTracking.mp4','MPEG-4');
open(video)
writeVideo(video,M);
close(video)
