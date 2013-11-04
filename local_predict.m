function node=local_predict(node,time)
%
% NODE=LOCAL_PREDICT(NODE,TIME)
%
% a function to perform local prediction for each node
% based on Joseph form
%

% simple constant velocity predictor
dt=time-node.time;
if dt < 0
   error('Negative prediction step in state_pred')
end

% compute transition matrices
[F,G]=c2d(node.filter.A,node.filter.B,dt);
Q=node.filter.Q;

% do prediction
M=(inv(F))'*(node.est.Y)*(inv(F));
Sigma=G'*M*G+inv(Q);
Omega=M*G*inv(Sigma); % here is the problem
node.pred.Y=M-(Omega*Sigma*Omega');
node.pred.y=(eye(4,4)-(Omega*G'))*(inv(F))'*(node.est.y);
node.time=time;
node.pred.Y=force_sym(node.pred.Y);