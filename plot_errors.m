function plot_errors(targets,y,Y,times,node_num,startfig)

globals;

[ntimes,nsensors,xdim1]=size(y);
[ntimes,nsensors,xdim2,xdim3]=size(Y);

data=zeros(5,ntimes);

%startfig=6;


warning off;
for i=1:ntimes
   P = pinv(squeeze(Y(i,node_num,:,:)));
   x=P*squeeze(y(i,node_num,:));
   data(1,i)=times(i);
   data(2,i)=x(1)-targets(i,1).x;
   data(3,i)=x(3)-targets(i,1).y;
   sigma=real(sqrtm(P));
   data(4,i)=sigma(1,1);
   data(5,i)=sigma(3,3);
   data(6,i)=sqrt(x(2)*x(2)+x(4)*x(4))-targets(i,1).vel;
   data(7,i)=atan2(x(4),x(2))-targets(i,1).phi;
   data(8,i)=sigma(2,2)+sigma(4,4);
end
warning on;

figure(startfig);
clf;
plot(data(1,:),data(2,:),'b',data(1,:),data(4,:),'r',data(1,:),-data(4,:),'r')
legend('Actual Error','Estimated Error');
buf=sprintf('Node %d: X position Error and Covariance',node_num); 
title(buf)
xlabel('time')
ylabel('X error (m)')


figure(startfig+1);
clf;
plot(data(1,:),data(6,:),'b',data(1,:),data(8,:),'r',data(1,:),-data(8,:),'r')
legend('Actual Error','Estimated Error');
buf=sprintf('Node %d: Velocity Error and Covariance',node_num); 
title(buf)
xlabel('time')
ylabel('Error (m/s)')


figure(startfig+2);
clf;
plot(data(1,:),data(3,:),'b',data(1,:),data(5,:),'r',data(1,:),-data(5,:),'r')
legend('Actual Error','Estimated Error');
buf=sprintf('Node %d: Y position Error and Covariance',node_num); 
title(buf)
xlabel('time')
ylabel('Y error (m)')

figure(startfig+3);
clf;
plot(data(1,:),data(7,:),'b')
buf=sprintf('Node %d: Heading Error',node_num); 
title(buf)
xlabel('time')
ylabel('Heading error (rads)')
