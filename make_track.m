function track=make_track(id,dim,time)
% simple function to make space for a track

track.id=id;
track.XDIM=dim;
track.time=time;
track.y=zeros(dim,1);
track.Y=zeros(dim,dim);


