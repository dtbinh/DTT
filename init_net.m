function network=init_net(nsize)
%
%  NETWORK=INIT_NET(PLATFORMS,NODES)
%
% Function to initialise a network structure

network=zeros(nsize,nsize);

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
