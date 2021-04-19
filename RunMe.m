clc; clear; close all;

dt = 0.05; threshold = 0.06; RMS = inf;

% Desired target
Thd = [0;0;0]; Xd = [3;4;10];  Posed = [Xd ; Thd];
Rd = pinv(Angle2R(Thd(1),Thd(2),Thd(3)));

% Create Model()
% [A,ai,B,bi,Pee,Ree,u1,u2,u3] = createmodel();
[A,ai,B,bi,Pee,Ree] = createmodel();
[th, phi, psi] = Rot2Angles(Ree); PoseEE = [Pee ; [th ; phi ; psi]];

% t = 0;
while (RMS > threshold)
    
    % t = t+dt;
    plot3(Xd(1),Xd(2),Xd(3),'*r','LineWidth',3); hold on;
    xlabel('x');ylabel('y');zlabel('z')
    
    [Li,si] = GSIKP(ai,bi,Pee,Ree);
    [th , phi , psi] = Rot2Angles(Ree);
    PoseEE = [Pee ; [th ; phi ; psi]];
    PlotGS(A,B,ai,Ree*bi+Pee,eye(3),Ree,[0;0;0],Pee);
    clf;
    
    % Jacobian
    J66 = GSJacobian(bi,si,6);
    J36 = GSJacobian(bi,si,3);
    
    % Jacobian Inverse Control
    Ldot = JacInvControl(J36,PoseEE,Posed);
    
    % New pose
    Xdot = J66*Ldot;
    PoseEE = PoseEE + Xdot*dt;
    Pee = PoseEE(1:3); Ree = Angle2R(PoseEE(4),PoseEE(5),PoseEE(6));
    % u1 = Ree*u1; u2 = Ree*u2; u3 = Ree*u3;
    
    
    RMS_p = rms(Pee-Xd);
    % RMS_o = rms(PoseEE(4:6)-Posed(4:6));
    % disp(['RMSp : ', num2str(RMS_p), ' RMSo : ', num2str(RMS_o)])
    disp(['RMSp : ', num2str(RMS_p)])
    % plot(t,RMS_p,'*-b'); hold on; drawnow
    % plot(t,RMS_o,'*-k'); hold on; drawnow
    
end
