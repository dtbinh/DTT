function filter=get_filter_params
% simple function to get a fixed filter parameter block

globals;

% assume a constant velocity model for everything;

filter.XDIM=4;
filter.ZDIM=2;

filter.Q=[SIGMA_XY*SIGMA_XY, 0 ; 0 , SIGMA_XY*SIGMA_XY];
filter.A=[0 1 0 0; 0 0 0 0; 0 0 0 1; 0 0 0 0];
filter.B=[0 0; 1 0; 0 0; 0 1];
filter.H=[1 0 0 0; 0 0 1 0];
