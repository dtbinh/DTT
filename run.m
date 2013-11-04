% main

clear all;

globals;
ginit;
NEW_RUN = 1;
times = 0:DT:MAX_TIME;

% simulate only one target
% one target considerably simplifies computation
NUM_TARGETS = 1;
Targets = generate_targets(1,times);

% simulate NUM_NODES platforms in motion
% these are assumed perfectly known
Platforms = generate_platforms(NUM_NODES,times);


% establish initial topology if required
com_net=init_net(NUM_NODES);

% in every case, the sensors which sit on the platforms are defined
% this is because the filters may change between runs
filter = get_filter_params;
for i = 1:NUM_NODES
    Nodes(i) = make_sensor(i,filter,com_net);
end

% everything is now set up for the simulation

% establish the time base
ntimes = length(times);

% define space to record results
Results_y = zeros(ntimes,NUM_NODES,filter.XDIM);
Results_Y = zeros(ntimes,NUM_NODES,filter.XDIM,filter.XDIM);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% START OF FILTER LOOPS HERE
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run loop for all sensors at each time
% this is as close as we can get to running this in parallel

for i=1:ntimes
    % time in this loop
    t = times(i);
    
    % generate an observation for each node at this time
    for s=1:NUM_NODES
        obs(s).report = sensor_report(Nodes(s),Platforms,Targets,s,i);
        Obs_rec(s,i) = obs(s); % record observations for plotting
    end
    
    % first, do a local prediction
    for s=1:NUM_NODES
        Nodes(s)=local_predict(Nodes(s),t);
    end
    
    % second, a local update generating y tilde at each site
    for s=1:NUM_NODES
        Nodes(s)=local_update(Nodes(s),obs(s));
    end
    
    strategy = 'Covariance Intersection (Strategy 1)';
    % then communicate
    % this sets up and exchanges data in channel filters
    for s=1:NUM_NODES
        Nodes(s)=communicate(Nodes,com_net,s,strategy);
    end
    
    % finally do global update by adding
    for s=1:NUM_NODES
        Nodes(s)=assimilate(Nodes(s),strategy);
    end
    
    % record results
    for s=1:NUM_NODES
        Results_y(i,s,:)=Nodes(s).est.y;
        Results_Y(i,s,:,:)=Nodes(s).est.Y;
    end
    
end

disp('Plotting Data...');
post_sim(Targets,Obs_rec,Platforms);
plot_tracks(Targets,Results_y,Results_Y,times);
plot_errors(Targets,Results_y,Results_Y,times,1,10)