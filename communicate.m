function node=communicate(Nodes,com_net,node_num,strategy)

globals;

% this node
node=Nodes(node_num);

% Find the current communication neighbourhood
num_chan=1;
% for i=1:NUM_NODES
for i=1:size(com_net,1)
    if com_net(node_num,i) ~= 0
        % for connected nodes, compute common prior
        % and estimate. The difference is the new information
        %         if FULL_CON
        if strcmp(strategy,'Channel Filter (Broadcast)')
            node.chan_out(num_chan) = Nodes(i).pred;
            node.chan_in(num_chan)=Nodes(i).est;
            %         elseif TREE_CON
        elseif strcmp(strategy,'Channel Filter (Tree)')
            % compute transition matrices
            [F,G]=c2d(node.filter.A,node.filter.B,DT);
            Q=node.filter.Q;
            % do prediction
            y_ij = node.y_ij(:,num_chan);
            Y_ij = node.Y_ij(:,:,num_chan);
            M=(inv(F))'*Y_ij*(inv(F));
            Sigma=G'*M*G+inv(Q);
            Omega=M*G*inv(Sigma); % here is the problem
            Y_ij = M-(Omega*Sigma*Omega');
            Y_ij = force_sym(Y_ij);
            y_ij = (eye(4,4)-(Omega*G'))*(inv(F))'*y_ij;
            node.chan_out(num_chan).Y = Y_ij;
            node.chan_out(num_chan).y = y_ij;
            Y_ij = node.est.Y+Nodes(i).est.Y-Y_ij;
            y_ij = node.est.y+Nodes(i).est.y-y_ij;
            node.Y_ij(:,:,num_chan) = Y_ij;
            node.y_ij(:,num_chan) = y_ij;
            node.chan_in(num_chan)=Nodes(i).est;
        elseif strcmp(strategy,'Covariance Intersection (Strategy 1)')
            % CI strategy 1
            node.chan_out(num_chan)=Nodes(i).pred;
            node.chan_in(num_chan).y=Nodes(i).est.y-Nodes(i).pred.y;
            node.chan_in(num_chan).Y=Nodes(i).est.Y-Nodes(i).pred.Y;
        elseif strcmp(strategy,'Covariance Intersection (Strategy 2)')
            % CI strategy 2
            [node.chan_out(num_chan).y,node.chan_out(num_chan).Y,omega] = commonInfo(node.pred.y,node.pred.Y,Nodes(i).pred.y,Nodes(i).pred.Y); % added by landcolin
            node.chan_in(num_chan)=Nodes(i).est;
        end
        num_chan=num_chan+1;
    end
end
% note the number of channels for later
node.num_chans = num_chan-1;