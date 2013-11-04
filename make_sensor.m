function sensor=make_sensor(id,filter,com_net)
%
% SENSOR=MAKE_SENSOR(ID)
%
%
% Returns a sensor data structure which contains all
% necessary information for a decentralised sensor.
% Assumes a single track only
% ID is a unique identifier
% FILTER is a data structure with relevant filter parameters
globals;

num_chan = 1;
% for i=1:NUM_NODES
for i = 1:size(com_net,1)
    if com_net(id,i)==1
        num_chan=num_chan+1;
    end
end
sensor.num_chans = num_chan-1;

sensor.id=id;
sensor.time=0.0;
sensor.r_err=SIGMA_RANGE; % 20 meter range error sigma
sensor.b_err=SIGMA_BEARING; % 0.1 degree beam width
sensor.point=0; % zero point angle
sensor.beam_view=2*pi;
sensor.max_range=WORLD_SIZE;
sensor.filter=filter;
sensor.est=make_track(0,filter.XDIM,0.0);
sensor.pred=make_track(0,filter.XDIM,0.0);
% added by landcolin
sensor.px = 0;
sensor.py = 0;

if sensor.num_chans >= 1
    for i=1:sensor.num_chans
        sensor.chan_in(i)=make_track(i,filter.XDIM,0.0);
        sensor.chan_out(i)=make_track(i,filter.XDIM,0.0);
        % added by landcolin
        sensor.y_ij(:,i) = sensor.pred.y;
        sensor.Y_ij(:,:,i) = sensor.pred.Y;
    end
else
    sensor.chan_in(1) = make_track(1,filter.XDIM,0.0);
    sensor.chan_out(1) = make_track(1,filter.XDIM,0.0);
    sensor.y_ij(:,1) = sensor.pred.y;
    sensor.Y_ij(:,:,1) = sensor.pred.Y;
end
