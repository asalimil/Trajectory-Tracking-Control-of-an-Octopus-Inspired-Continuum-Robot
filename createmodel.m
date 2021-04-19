
function disk = createmodel(N,k)

r0 = 0.25; P0 = [0;0;5/N];

for n = 1:N+1
    
    r = r0*k^n;
    
    if mod(n,2) == 0 % segments with # even
        a = r*[-sqrt(3)/2   0.5     0
               -sqrt(3)/2   0.5     0
               0        -1          0
               0        -1          0
               +sqrt(3)/2   0.5     0
               +sqrt(3)/2   0.5     0]';
        %         a = r*[ 0.5   sqrt(3)/2   0
        %             0.5   sqrt(3)/2   0
        %             -1     0               0
        %             -1     0               0
        %             0.5  -sqrt(3)/2   0
        %             0.5  -sqrt(3)/2   0]';
    elseif mod(n,2) == 1 % segments with # odd
        a = r*[0     1              0
            0     1              0
            -sqrt(3)/2   -0.5      0
            -sqrt(3)/2   -0.5      0
            +sqrt(3)/2   -0.5       0
            +sqrt(3)/2   -0.5       0]';
        
        %         a = r*[1     0               0
        %                1     0               0
        %              -0.5   sqrt(3)/2        0
        %              -0.5   sqrt(3)/2        0
        %              -0.5  -sqrt(3)/2        0
        %              -0.5  -sqrt(3)/2        0]';
    end
    
    P =  P0*(n-1);
    R = eye(3);
    
    disk(n).r = r;
    disk(n).a = a + P;
    % disk(n).a = a;
    disk(n).P = P;
    disk(n).R = R;
    
end


end

% % function [A,a,B,b,P,R,u1,u2,u3] = createmodel()
% function [A,a,B,b,P,R] = createmodel()
%
% A = 1.5; B = 0.5;
%
% b = B*[1       0               0
%     1       0               0
%     -0.5   sqrt(3)/2   0
%     -0.5   sqrt(3)/2   0
%     -0.5  -sqrt(3)/2   0
%     -0.5  -sqrt(3)/2   0]';
% a = A*[ 0.5   sqrt(3)/2   0
%     0.5   sqrt(3)/2   0
%     -1     0               0
%     -1     0               0
%     0.5  -sqrt(3)/2   0
%     0.5  -sqrt(3)/2   0]';
%
% P = [0;0;2];
% R = eye(3);
% % b = R*blocal + P;
%
% % u1 = [0  0  0; 0  0  0; 0  0  1];
% % u2 = [0  0  0; 0  1  0; 0  0  0];
% % u3 = [1  0  0; 0  0  0; 0  0  0];
% % PlotCoordinates(u1,u2,u3)
%
% end