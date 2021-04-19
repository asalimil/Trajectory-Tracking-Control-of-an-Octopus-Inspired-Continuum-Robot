function [th, phi, psi] = Rot2Angles(R)

    th = atan2(R(3,2),R(3,3));
    phi = atan2(-R(3,1),sqrt(R(3,2)^2 + R(3,3)^2));
    psi = atan2(R(2,1),R(1,1));
    
end