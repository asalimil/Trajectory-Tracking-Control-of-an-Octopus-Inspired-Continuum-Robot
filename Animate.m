% Animation figures in Matlab
aa=1;
x = 0:0.1:10;
y = sin(x);
for i=1:length(x)-1
    p = plot(x(aa*i),y(aa*i),'.-r','markersize',1);
    hold on
    FF(i) = getframe(gcf);
    % pause(0.02)
    hold on
    delete(p)
    plot(x(aa*i),y(aa*i),'.r','LineWidth',0.5)
    hold on
end
video = VideoWriter('obs_av_10.mp4','MPEG-4');
open(video)
writeVideo(video,FF);
close(video)