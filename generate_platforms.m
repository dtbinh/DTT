function platforms = generate_platforms(nplatforms,times)
%
%
% platforms=generate_platforms(times)
%
% function to geneate trajectories for platforms
% HDW 19/10/00

% Define the global variables
globals;


% Define the platform initial locations 
for i=1:nplatforms
   platforms(1,i) = make_platform;
   platforms(1,i).id=i;
   platforms(1,i).time=times(1);
   platforms(1,i).x = WORLD_SIZE*(0.25 +0.5*rand);
   platforms(1,i).y = WORLD_SIZE*(0.25 +0.5*rand);
   platforms(1,i).phi = 2*pi*rand -pi;
   platforms(1,i).vel = 0;
   platforms(1,i).gamma=0;
   
   % now generate platform trajectories
   [temp,ntimes]=size(times);
   for n=2:ntimes
      platforms(n,i)=platform_step(platforms(n-1,i),times(n));
   end
end
