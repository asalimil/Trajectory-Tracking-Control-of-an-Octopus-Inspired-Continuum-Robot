clc; clear; close all;

DESIRED_position = [];
TRACKED_position = [];

% Create Model
N = 20; K = 0.95;
disk = createmodel(N,K);
for i = 1:N+1
    [th, phi, psi] = Rot2Angles(disk(i).R);
    disk(i).pose = [disk(i).P ; [th ; phi ; psi]];
end

dtc = 0.001
threshold = 0.05;
RMSp = inf;
Npoints = 1000;

% straight line
X_start = [-0.5;0.5;6]; X_end = [2.5;3.5;7];
% [t, Xd, Thd]= DesiredPath(X_start,X_end,res);
% [t, Xd, Thd]= DesiredPath(X_start,X_end,Npoints);
Xd = MyDesiredPath(X_start,X_end,Npoints);
Thd = zeros(3,Npoints);
Posed = [Xd ; Thd];

DESIRED_position = [DESIRED_position; [0 Xd(1) Xd(2) Xd(3)]];
TRACKED_position = [TRACKED_position; [0 disk(end).pose(1) disk(end).pose(2) disk(end).pose(3)]];

RMSE = [];
Error = [];
iteration = 0;

%% Main Loop
f = 0;
time = 0;
for i = 1:size(Xd,2)
    %
    posed = Posed(:,i);
    error = disk(end).pose(1:3)-posed(1:3);
    RMS = rms(disk(end).pose-posed);
    %
    while (RMS > threshold)
        time = time  + dtc;
        % ti = t(i); 
        f = f+1;
        J66n = []; J63n = []; Q = [];
        % xlabel('x');ylabel('y');zlabel('z');
        %
        for n = 2:N+1
            [seg(n-1).qi,seg(n-1).si] = GSIKP(disk,n);
            Q = [Q ; seg(n-1).qi];
            % Jacobian > pose control
            seg(n-1).J66 = GSJacobian(seg,disk,n,6);
            J66n = [J66n ; seg(n-1).J66];
        end
        % pose control
        dQAll = JacInvControl(J66n,disk(end).pose,posed,Q,dtc); % global coordinates
        % Update pose
        DP = zeros(3,1); DR = eye(3);
        %
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
        %
        RMS = rms(disk(end).pose-posed);
        % disp(['t: ', num2str(time),' RMS: ', num2str(RMS)]);
        error = disk(end).pose(1:3)-posed(1:3);
        iteration = iteration + 1;
        RMSE = [RMSE; iteration RMS];
        Error = [Error; iteration norm(error')];
        DESIRED_position = [DESIRED_position; [time Xd(1,i) Xd(2,i) Xd(3,i)]];
        TRACKED_position = [TRACKED_position; [time disk(end).pose(1) disk(end).pose(2) disk(end).pose(3)]];
    end
    disp(['***** point ***** : ', num2str(i)]);
%     % start and end point
%     if i==1 || i==res+1
%         plot(time,Xd(1,i),'*g','LineWidth',3); hold on;
%         plot(time,Xd(2,i),'*g','LineWidth',3); hold on;
%         plot(time,Xd(3,i),'*g','LineWidth',3); hold on;
%     end
end
% desired
plot(DESIRED_position(:,1),DESIRED_position(:,2),'--r','LineWidth',2); hold on;
plot(DESIRED_position(:,1),DESIRED_position(:,3),'--k','LineWidth',2); hold on;
plot(DESIRED_position(:,1),DESIRED_position(:,4),'--b','LineWidth',2); hold on;
% tracked
plot(TRACKED_position(:,1),TRACKED_position(:,2),'.r','LineWidth',3); hold on;
plot(TRACKED_position(:,1),TRACKED_position(:,3),'.k','LineWidth',3); hold on;
plot(TRACKED_position(:,1),TRACKED_position(:,4),'.b','LineWidth',3); hold on;
grid on; axis square;
xlabel('t (s)');ylabel('Desired and Tracked Position');zlabel('z');