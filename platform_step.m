function next_platform=platform_step(platform,time)
%
% Function to step a platform
%
globals;

% this is a no motion model

dt=time-platform.time;
next_platform = make_platform; % space for platform data structure
next_platform.id=platform.id;
next_platform.time = time;
next_platform.x = platform.x;
next_platform.y = platform.y;
next_platform.phi = platform.phi;
next_platform.vel = platform.vel; 
next_platform.gamma = platform.gamma; 


