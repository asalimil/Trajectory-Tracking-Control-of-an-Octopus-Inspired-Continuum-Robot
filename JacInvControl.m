function dQAll = JacInvControl(J,Xee,Xd,Q,dt)

    % convergence gain
    % k = 0.1;
    % k = 1;
    % k = 5;
    % k = 10;
    k = 20;
    
    % poistion control
    % dQAll = -k*J*(Xee(1:3)-Xd(1:3))*dt;
    
    %% OK >> pose control
    % dQAll = -k*J*(Xee-Xd)*dt;
    
    % Test
    Dqm = (Q - 0.5);
    dQAll = (-k*J*(Xee-Xd) + (eye(length(Q)) - J*pinv(J))*Dqm)*dt;
    
end