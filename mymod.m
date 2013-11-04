function out=mymod(in,bottom,top)
%
%
%
range=top-bottom;

while in > top
   in=in-range;
end

while in < bottom
   in=in+range;
end

out=in;
