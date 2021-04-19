function J = GSJacobian(seg,disk,n,cc)
% n (# disk) - 1 = m (# segment)

% From global to local vectors
si = disk(n-1).R*seg(n-1).si;
bi = disk(n-1).R*disk(n).a;

if cc==6
    % si = disk(n-1).R*seg(n-1).si;
    % bi = disk(n-1).R*disk(n).a;
    % Jacobian 6*6
%     J = [si(:,1) si(:,2) si(:,3) si(:,4) si(:,5) si(:,6)
%         cross(bi(:,1),si(:,1)) cross(bi(:,2),si(:,2)) cross(bi(:,3),si(:,3)) cross(bi(:,4),si(:,4)) cross(bi(:,5),si(:,5)) cross(bi(:,6),si(:,6))];
    J = [si(:,1)' cross(bi(:,1),si(:,1))'
         si(:,2)' cross(bi(:,2),si(:,2))' 
         si(:,3)' cross(bi(:,3),si(:,3))'
         si(:,4)' cross(bi(:,4),si(:,4))'
         si(:,5)' cross(bi(:,5),si(:,5))'
         si(:,6)' cross(bi(:,6),si(:,6))'];
elseif cc==3
    % si = seg(n-1).si;
    % bi = disk(n).a;
    % Jacobian 3*6 > just linear velocity
%     J = [si(:,1) si(:,2) si(:,3) si(:,4) si(:,5) si(:,6)];
    J = [si(:,1)' 
        si(:,2)' 
        si(:,3)' 
        si(:,4)' 
        si(:,5)' 
        si(:,6)'];
end

end