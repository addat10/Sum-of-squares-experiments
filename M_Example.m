clear
clc
% Need to add sedumi tools to the workspace
%%
syms x1 x2;
m11=2;          m12=0;          m13=0;
                m22=2;          m23=0;
                                m33=-1;
p = m11*x1^2+2*m12*x1*x2+2*m13*x1*(x1*x2)+m22*x2^2+m23*x2*(x1*x2)+m33*(x1*x2)^2;
options.solver='sedumi';
[Q, Z] = findsos(p, options)
% Returns matrices Q and Z so that Z.'*Q*Z = p