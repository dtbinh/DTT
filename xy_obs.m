function [zx,zy,R]=xy_obs(rep,n)
%
%
%
% A function to extract an xy observation from a report

globals;

sr=sin(rep(n,3));
cr=cos(rep(n,3));
zx=rep(n,4)+rep(n,2)*cr;
zy=rep(n,5)+rep(n,2)*sr;
T=[cr -sr; sr cr];
range2=rep(n,2)*rep(n,2);
sigma=[SIGMAR2 0; 0 range2*SIGMAB2];
R=T*sigma*T';
