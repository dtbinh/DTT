function node=local_update(node,obs)
%
% NODE=LOCAL_UPDATE(NODE,OBS,TIME)
%
% a function to perform local update for each node

% observation model
H=node.filter.H;

% then extract observation
[zx,zy,R]=xy_obs(obs.report,1); % this keeps consistency with other trackers
z=[zx;zy];
Ri=inv(R);
% construct information terms
info=H'*Ri*z;
Info=H'*Ri*H;
% and add
node.est.y=node.pred.y+info;
node.est.Y=node.pred.Y+Info;

% seems to require the next step for stability in Matlab
node.est.Y=force_sym(node.est.Y);

