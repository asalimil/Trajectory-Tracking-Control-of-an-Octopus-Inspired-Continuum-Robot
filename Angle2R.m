function R = Angle2R(theta,phi,psi)

%     R = [cos(theta)*cos(psi)-sin(theta)*sin(phi)*sin(psi)  -cos(phi)*sin(theta)  cos(theta)*sin(psi)+cos(psi)*sin(theta)*sin(phi)
%         cos(psi)*sin(theta)+cos(theta)*sin(phi)*sin(psi)  +cos(theta)*cos(phi)  sin(theta)*sin(psi)-cos(theta)*cos(psi)*sin(phi)
%         -cos(phi)*sin(psi)                    sin(phi)             cos(phi)*cos(psi)];

    R = [cos(phi)*cos(psi)   -cos(phi)*sin(psi)  sin(phi)
         cos(theta)*sin(psi)+cos(psi)*sin(theta)*sin(phi)   cos(theta)*cos(psi)-sin(theta)*sin(phi)*sin(psi)    -cos(phi)*sin(theta)
         sin(theta)*sin(psi)-cos(theta)*cos(psi)*sin(phi)   cos(psi)*sin(theta)+cos(theta)*sin(phi)*sin(psi)    cos(theta)*cos(phi)];

end