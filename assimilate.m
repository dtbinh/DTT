function node=assimilate(node,strategy)

globals;

if strcmp(strategy,'Channel Filter (Broadcast)') || strcmp(strategy,'Channel Filter (Tree)')
    if node.num_chans >= 1
        for i=1:node.num_chans
            node.est.y=node.est.y+(node.chan_in(i).y-node.chan_out(i).y);
            node.est.Y=node.est.Y+(node.chan_in(i).Y-node.chan_out(i).Y);
        end
        % seems to require the next step for stability in Matlab
        node.est.Y=force_sym(node.est.Y);
    else
        return;
    end
elseif strcmp(strategy,'Covariance Intersection (Strategy 1)')
    if node.num_chans >= 1
        % CI strategy 1
        locali=node.est.y-node.pred.y;
        localI=node.est.Y-node.pred.Y;
        yc=node.pred.y;
        Yc=node.pred.Y;
        for i=1:node.num_chans
            [yc,Yc,omega]=commonInfo(yc,Yc,node.chan_out(i).y,node.chan_out(i).Y);
        end
        node.est.y = yc+locali;
        node.est.Y = Yc+localI;
        for i=1:node.num_chans
            node.est.y=node.est.y+node.chan_in(i).y;
            node.est.Y=node.est.Y+node.chan_in(i).Y;
        end
        % seems to require the next step for stability in Matlab
        node.est.Y=force_sym(node.est.Y);
    else
        return;
    end
elseif strcmp(strategy,'Covariance Intersection (Strategy 2)')
    if node.num_chans >= 1
        % CI strategy 2
        for i=1:node.num_chans
            node.est.y=node.est.y+(node.chan_in(i).y-node.chan_out(i).y);
            node.est.Y=node.est.Y+(node.chan_in(i).Y-node.chan_out(i).Y);
        end
        % seems to require the next step for stability in Matlab
        node.est.Y=force_sym(node.est.Y);
    else
        return;
    end
end
