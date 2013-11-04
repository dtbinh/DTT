clear
clc

% test

% el = canonicalNets(4,'line');
% el = canonicalNets(10,'btree');
el = canonicalNets(4,'circle');
adj = edgeL2adj(el);
adj = triu(adj);
adj(size(adj,1),1) = adj(1,size(adj,2));
adj(1,size(adj,2)) = 0;
view(biograph(adj));