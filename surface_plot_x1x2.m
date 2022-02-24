% script for plotting the set of points reachable by [x1;x2;x1*x2]
clear
clc
%%
% Points in R3 spanned by [x1;x2;x1*x2]
f=@(x1,x2)(x1*x2);
figure()
fsurf(f)
title('Points in R3 spanned by [x1;x2;x1*x2]')
xlabel('x1')
ylabel('x2')
zlabel('x1*x2')
ylim([-10,10])
zlim([-100,100])

%%
% m11=1;m12=0;m13=0;
% m22=1;m23=0;
% m33=-0.1;
% f1=@(x1,x2)(m11*x1^2  +  2*m12*x1*x2  + 2*m13*x1*x1*x2  +  m22*x2^2  + 2*m23*x2^2*x1  +  m33*x1^2*x2^2);
% figure()
% fsurf(f1)