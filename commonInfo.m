function [yc,Yc,omega] = commonInfo(ya,Ya,yb,Yb)
%
% [yc,Yc,omega]=common_info(ya,Ya,yb,Yb)
%
% CI update of two information quantities:
% ya with information matrix Ya and
% yb with information matrix Yb
%
% The output is the information quantity
% yc with information matrix Yc
% omega is the optimum weighting coefficent.

omega = fminbnd('cidet', 0, 1, optimset('TolX',1e-4,'Display','off'),Ya,Yb);
% omega=0.5;
Yc=omega*Ya+(1-omega)*Yb;
yc=omega*ya+(1-omega)*yb;
Yc = force_sym(Yc);% added by landcolin

function r = cidet(omega, Ai, Bi)
r = 1/det(omega*Ai+(1-omega)*Bi);
