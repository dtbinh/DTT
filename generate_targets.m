function targets = generate_targets(ntargets,times)
%
%	tracks=generate_targets(ntartgets,times)
%
% A function that generates true target information for later observation
% and tracking. Dynamics of target are contained in "target_step", number
% targets is defined by ntargets. A data point 
% is generated at each of a set of "times".
% HDW 19/10/00

% Define the global variables
globals;


% Define initial target locations in some random manner
for i=1:ntargets
   targets(1,i) = make_target; % make the target data structure
   targets(1,i).time=times(1);
   targets(1,i).id=i;
   targets(1,i).x = WORLD_SIZE*(0.25 +0.5*rand);
   targets(1,i).y = WORLD_SIZE*(0.25 +0.5*rand);
   targets(1,i).phi = 2*pi*rand -pi;
   targets(1,i).vel = MIN_TARGET_VEL + (MAX_TARGET_VEL-MIN_TARGET_VEL)*rand;
   targets(1,i).gamma=0;
   % Now iterate for all time
   [temp,ntimes]=size(times);
   for n=2:ntimes
      targets(n,i)=target_step(targets(n-1,i),times(n));
   end
end

% when we have multiple target models, the global variable TARGET_TYPE
% can be used to choose between targets
