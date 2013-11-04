function sigma=force_sym(sigma)
%
% a function that forces symmetry on a matrix
%

[nx,ny]=size(sigma);
if nx ~= ny
   error('Matrix must be square');
end

for i=1:nx
   for j=i+1:nx
      temp=(sigma(i,j)+sigma(j,i))/2;
      sigma(i,j)=temp;
      sigma(j,i)=temp;
   end
end
