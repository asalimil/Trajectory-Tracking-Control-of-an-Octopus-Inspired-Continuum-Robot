function [Li,si] = GSIKP(disk,n)

% Local base of GS
a = disk(n-1).a; 
Pa = disk(n-1).P;
Ra = disk(n-1).R;

% Local EE of GS
b = disk(n).a; 
Pb = disk(n).P;
Rb = disk(n).R;

% Relative R & b
R = pinv(Ra)*Rb;
P = Pb - Pa;

% IKP of local GS
L1 = ( P'*P + b(:,1)'*b(:,1) + a(:,1)'*a(:,1) - 2*P'*a(:,1) + 2*P'*(R*b(:,1)) - 2*(R*b(:,1))'*a(:,1) ).^(1/2);
L2 = ( P'*P + b(:,2)'*b(:,2) + a(:,2)'*a(:,2) - 2*P'*a(:,2) + 2*P'*(R*b(:,2)) - 2*(R*b(:,2))'*a(:,2) ).^(1/2);
L3 = ( P'*P + b(:,3)'*b(:,3) + a(:,3)'*a(:,3) - 2*P'*a(:,3) + 2*P'*(R*b(:,3)) - 2*(R*b(:,3))'*a(:,3) ).^(1/2);
L4 = ( P'*P + b(:,4)'*b(:,4) + a(:,4)'*a(:,4) - 2*P'*a(:,4) + 2*P'*(R*b(:,4)) - 2*(R*b(:,4))'*a(:,4) ).^(1/2);
L5 = ( P'*P + b(:,5)'*b(:,5) + a(:,5)'*a(:,5) - 2*P'*a(:,5) + 2*P'*(R*b(:,5)) - 2*(R*b(:,5))'*a(:,5) ).^(1/2);
L6 = ( P'*P + b(:,6)'*b(:,6) + a(:,6)'*a(:,6) - 2*P'*a(:,6) + 2*P'*(R*b(:,6)) - 2*(R*b(:,6))'*a(:,6) ).^(1/2);

% Local si 
s1 = (P-a(:,1)+R*b(:,1))/L1;
s2 = (P-a(:,2)+R*b(:,2))/L2;
s3 = (P-a(:,3)+R*b(:,3))/L3;
s4 = (P-a(:,4)+R*b(:,4))/L4;
s5 = (P-a(:,5)+R*b(:,5))/L5;
s6 = (P-a(:,6)+R*b(:,6))/L6;

Li = [L1;L2;L3;L4;L5;L6];
si = pinv(Ra)*[s1 s2 s3 s4 s5 s6]; % convert local si to global si

end