function plot_tracks(targets,y,Y,times)

globals;

[ntimes,nsensors,xdim1]=size(y);
[ntimes,nsensors,xdim2,xdim3]=size(Y);

data=zeros(2,ntimes);

startfig=5;

figure(startfig);
clf;
v=[0 WORLD_SIZE 0 WORLD_SIZE];
axis(v)
title('Target Motions')
xlabel('x-position (m)')
ylabel('y-position (m)')

hold on

% the true trajectory
for i=1:ntimes
   data(1,i)=targets(i,1).x;
   data(2,i)=targets(i,1).y;
end
plot(data(1,:),data(2,:),'r');

% the estimated trajectory
warning off;
for s=1:nsensors
   for i=1:ntimes
      P=inv(squeeze(Y(i,s,:,:)));
      x=P*squeeze(y(i,s,:));
      data(1,i,s)=x(1);
      data(2,i,s)=x(3);
   end
   plot(data(1,:),data(2,:),'b')
end
warning on;


hold off