function next_target=target_step(target,time)
%
% Function to step a target
%
globals;

dt=time-target.time;
next_target = make_target; % space for target data structure
next_target.id=target.id;
next_target.time = time;
next_target.x = target.x + dt*target.vel*cos(target.phi + target.gamma);
next_target.y = target.y + dt*target.vel*sin(target.phi + target.gamma);
next_target.phi = target.phi + dt*(target.vel/TARGET_B)*sin(target.gamma);
next_target.vel = target.vel + dt*TARGET_VEL_SD*randn;
next_target.gamma = target.gamma + dt*TARGET_GAMMA_SD*randn;

% Check if platform is in world map
if APPLY_BOUNDS
   next_target.x=mymod(next_target.x,0,WORLD_SIZE);
   next_target.y=mymod(next_target.y,0,WORLD_SIZE);
end

next_target.phi=mymod(next_target.phi,-pi,pi);

% and bound control inputs
if next_target.vel > MAX_TARGET_VEL
   next_target.vel=MAX_TARGET_VEL;
elseif next_target.vel < MIN_TARGET_VEL
   next_target.vel=MIN_TARGET_VEL;
end

if next_target.gamma > MAX_TARGET_GAMMA
   next_target.gamma=MAX_TARGET_GAMMA;
elseif next_target.gamma < -MAX_TARGET_GAMMA
   next_target.gamma = -MAX_TARGET_GAMMA;
end

