function network = init_net(nsize,net_categ)
%
%  NETWORK=INIT_NET(PLATFORMS,NODES)
%
% Function to initialise a network structure

network=zeros(nsize,nsize);

switch net_categ
    case 'fully connected'
        network = ones(nsize,nsize);
        for i = 1:nsize
            network(i,i) = 0;
        end
    case 'tree'
        el = canonicalNets(nsize,'btree');
        network = edgeL2adj(el);
    case 'neighbor'
        % here is one alorithm which simply connects to
        % its nearest four neighbours
        for i=1:nsize
            for j=i:i+2
                if j>nsize
                    k=j-nsize;
                else
                    k=j;
                end
                if i ~=k
                    network(i,k)=1;
                    network(k,i)=1;
                end
            end
        end
    otherwise
        disp('warning: unknown network topology type');
        network = network; % default is fixed
end