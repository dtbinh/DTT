function [true,plat,obs]=post_sim(targets,observations,platforms)
%
% 	post_sim(targets,observations,platforms)
%
%	A function to display true target tracks, platform trajectories,
%  and observations following a simulation run.

% call globals and set plotting size
globals;
[nsamps,nplatforms]=size(platforms);
[nsamps,ntargets]=size(targets);
v=[0 WORLD_SIZE 0 WORLD_SIZE];
figure(1)
clf;
axis(v)
hold on
data=zeros(2,nsamps);
title('True Target Motions')
xlabel('x-position (m)')
ylabel('y-position (m)')

% first get true target trajectories
for n=1:ntargets
   for i=1:nsamps
      data(1,i)=targets(i,n).x;
      data(2,i)=targets(i,n).y;
   end
   true=plot(data(1,:),data(2,:));
end

% now plot true platform trajectories
for n=1:nplatforms
   for i=1:nsamps
      data(1,i)=platforms(i,n).x;
      data(2,i)=platforms(i,n).y;
   end
   plat=plot(data(1,:),data(2,:),'go');
end

% finally plot observations
[nsensors,nsamps]=size(observations);
for n=1:nsensors % for all sensors
   for i=1:nsamps % for all time
      report=observations(n,i).report;
      for m=1:ntargets % for all targets
         if report(m,1) > 0 % if they are seen 
            [zx,zy,R]=xy_obs(report,m); % convert observation to global xy coordinates
            odata(1,m)=zx; %report(m,4) + report(m,2)*cos(report(m,3));
            odata(2,m)=zy; %report(m,5) + report(m,2)*sin(report(m,3));
         end
      end
      obs=plot(odata(1,:),odata(2,:),'r.');
   end
end
legend([true,plat,obs],'Target True Position','Tracking Stations','Target Observations')
hold off
