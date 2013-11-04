function r = cidet(omega, Ai, Bi)
r=det(omega*Ai+(1-omega)*Bi);
if r==0
   r=r;
else
   r=1/r;
end
