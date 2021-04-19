clc; clear; close all;

% Create Model
N = 20; K = 0.95;
disk = createmodel(N,K);
for i = 1:N+1
    [th, phi, psi] = Rot2Angles(disk(i).R);
    disk(i).pose = [disk(i).P ; [th ; phi ; psi]];
end

% adjust parameters
dt = 0.001;
threshold = 0.06;
plotres = 4;
Npoints = 20;


% Line
X_start = [-0.5;0.5;6]; X_end = [2.5;3.5;7];
[t, Xd, Thd]= DesiredPath(X_start,X_end,Npoints);
% plot3(Xd(1,:),Xd(2,:),Xd(3,:),'*r','LineWidth',2); grid on; hold on; drawnow;
Posed = [Xd ; Thd];


% %*** Plot Multi-Segment Robot
% for cc = 2:N+1
%     PlotGS(disk,cc,'s');
% end
% drawnow; hold on; grid on;
% %***

% Main Lopp
RMSE = [];
normE = [];
Error = [];
f = 0; time = 0; iteration = 0;
RMSp = inf;


DESIRED_position = [];
TRACKED_position = [];
ERROR_position = [];
normErrorPosition = [];

for i = 1:size(Xd,2)
    
    posed = Posed(:,i);
    error = disk(end).pose(1:3)-posed(1:3);
    RMS = rms(disk(end).pose-posed);
    % NRM = norm(disk(end).pose-posed);
    % clf;
    while (RMS > threshold)
        % while (NRM > threshold)
        % disp(['RMS : ', num2str(RMS)]);
        % clf;
        % ti = t(i); % original
        f = f+1;
        J66n = []; J63n = []; Q = [];
        % plot3(Xd(1,:),Xd(2,:),Xd(3,:),'*r','LineWidth',2); hold on; grid on;
        % xlabel('x');ylabel('y');zlabel('z');
        
        for n = 2:N+1
            [seg(n-1).qi,seg(n-1).si] = GSIKP(disk,n);
            Q = [Q ; seg(n-1).qi];
            
            % Jacobian > pose control
            seg(n-1).J66 = GSJacobian(seg,disk,n,6);
            J66n = [J66n ; seg(n-1).J66];
        end
        % pose control
        dQAll = JacInvControl(J66n,disk(end).pose,posed,Q,dt); % global coordinates
        
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
        % NRM = norm(disk(end).pose-posed);
        error = disk(end).pose(1:3)-posed(1:3);
        % plot(t,RMSp,'-*b'); hold on; drawnow; grid on
        
        % clf;
        % if i >= 2
        iteration = iteration + 1;
        RMSE = [RMSE; iteration RMS];
        % normE = [normE; iteration NRM];
        % Error = [Error ; error'];
        Error = [Error; iteration norm(error')];
        % end
        time = time + dt;
        TRACKED_position = [TRACKED_position; [time disk(end).pose(1) disk(end).pose(2) disk(end).pose(3)]];
        %         EEE = [disk(end).pose(1)-Xd(1,i) disk(end).pose(2)-Xd(2,i) disk(end).pose(3)-Xd(3,i)];
        %         ERROR_position = [ERROR_position; [time EEE]];
        %         normErrorPosition = [normErrorPosition; rms(EEE)];
    end
    disp(['point: ', num2str(i), ',  time: ', num2str(time)]);
    
%     %% *** Plot Multi-Segment Robot
%     if mod(i-1,plotres) == 0
%         if i ~= Npoints+1
%             for cc = 2:N+1
%                 PlotGS(disk,cc,'m');
%             end
%         else
%             for kk = 2:N+1
%                 PlotGS(disk,kk,'e');
%             end
%         end
%         drawnow; hold on; grid on;
%         xlabel('X'); ylabel('Y'); zlabel('Z');
%     end
%     % axis([-1.5 1.5 -1.5 1.5 0 5.5])
%     %***
%     if i > 1
%         M(i-1) = getframe;
%     end
    
    %     %% *** Plot Tracked and Desired Position
    DESIRED_position = [DESIRED_position; [time Xd(1,i) Xd(2,i) Xd(3,i)]];
end

% video = VideoWriter('ReachingTracking.mp4','MPEG-4');
% open(video)
% writeVideo(video,M);
% close(video)

%% Figure 7
% desired
plot(DESIRED_position(:,1),DESIRED_position(:,2),'*r','LineWidth',2); hold on;
plot(DESIRED_position(:,1),DESIRED_position(:,3),'*k','LineWidth',2); hold on;
plot(DESIRED_position(:,1),DESIRED_position(:,4),'*b','LineWidth',2); hold on;
% tracked
plot(TRACKED_position(:,1),TRACKED_position(:,2),'--r','LineWidth',1); hold on;
plot(TRACKED_position(:,1),TRACKED_position(:,3),'--k','LineWidth',1); hold on;
plot(TRACKED_position(:,1),TRACKED_position(:,4),'--b','LineWidth',1); hold on;
grid on; axis square;
xlabel('t (s)');ylabel('Desired and Tracked Position');zlabel('z');

% % all position errors
% plot(ERROR_position(:,1),ERROR_position(:,2),'.r','LineWidth',3); hold on;
% plot(ERROR_position(:,1),ERROR_position(:,3),'.k','LineWidth',3); hold on;
% plot(ERROR_position(:,1),ERROR_position(:,4),'.b','LineWidth',3); hold on;
% grid on; axis square;

% plot(TRACKED_position(:,1),threshold*ones(1,length(TRACKED_position(:,1))),'--r','LineWidth',2); hold on;
% plot(TRACKED_position(:,1),RMSE(:,2),'.k','LineWidth',3); hold on;
% xlabel('t (s)'); ylabel('RMSE of position errors')
% grid on; drawnow;