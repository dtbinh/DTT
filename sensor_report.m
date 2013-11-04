function report=sensor_report(sensor,platforms,targets,nsensor,ntime)
%
%
%
% function to construct a report for a sensor at a particular time
globals;

report=zeros(NUM_TARGETS,5);
% find platform location at this time
px=platforms(ntime,nsensor).x;
py=platforms(ntime,nsensor).y;

% generate an observation for each target in view
% this is a range-bearing model
for tnum=1:NUM_TARGETS
    % find target location
    tx=targets(ntime,tnum).x;
    ty=targets(ntime,tnum).y;
    % compute true range and bearing
    dx=tx-px; dy=ty-py;
    range=sqrt(dx*dx + dy*dy);
    bearing=atan2(dy,dx);
    % determine if this is actually visable
    % always assume visable at this point
    % add error from sensor model
    report(tnum,1)=tnum;
    report(tnum,2)=range + sensor.r_err*randn;
    report(tnum,3)=bearing + sensor.b_err*randn;
    report(tnum,4)=px;
    report(tnum,5)=py;
end



