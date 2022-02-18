% This script tries to manually convert an SOS problem to SDP manually and
% searches for a SOS decomposition
%%
clear
clc
%% 
tol=1e-4;
cvx_begin sdp
variable M(3,3) symmetric
variable Q(6,6) symmetric
variable t

cvx_precision high

minimize 1

subject to:
Q >= 0
Q(1,4)+Q(2,3)==M(1,2)
2*Q(1,5)+Q(2,2)==M(1,1)
2*Q(1,6)+Q(3,3)==M(2,2)
Q(2,4)+Q(3,5)==M(1,3)
Q(2,6)+Q(3,4)==M(2,3)
Q(4,4)+2*Q(5,6)==M(3,3)
Q(1,1)==0
Q(1,2)==0
Q(1,3)==0
Q(2,5)==0
Q(3,6)==0
Q(4,5)==0
Q(4,6)==0
Q(5,5)==0
Q(6,6)==0

% Try to get an indefinite M
M(3,3)<=-tol

cvx_end
status=cvx_status; 
%% Decompose the obtained Q if one found
% [V,eig_Q]=eigs(Q);
% D=sqrt(eig_Q)*V'; % D'D=Q;



