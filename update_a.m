function a = update_a(n,r,P,R)

% disk's number
if mod(n,2) == 0 % disk with # odd
%     a = r*[ 0.5   sqrt(3)/2   0
%         0.5   sqrt(3)/2   0
%         -1     0               0
%         -1     0               0
%         0.5  -sqrt(3)/2   0
%         0.5  -sqrt(3)/2   0]';
a = r*[-sqrt(3)/2   0.5     0
               -sqrt(3)/2   0.5     0
               0        -1          0
               0        -1          0
               +sqrt(3)/2   0.5     0
               +sqrt(3)/2   0.5     0]';
elseif mod(n,2) == 1 % disk with # even
    a = r*[0     1              0
            0     1              0
            -sqrt(3)/2   -0.5      0
            -sqrt(3)/2   -0.5      0
            +sqrt(3)/2   -0.5       0
            +sqrt(3)/2   -0.5       0]';
%     a = r*[1     0               0
%         1     0               0
%         -0.5   sqrt(3)/2        0
%         -0.5   sqrt(3)/2        0
%         -0.5  -sqrt(3)/2        0
%         -0.5  -sqrt(3)/2        0]';
end

a = R*a + P;

end