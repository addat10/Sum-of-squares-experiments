%% 
% This script is just to experiment with MATLAB sum of squares tools
% It tries to reproduce the example from https://underactuated.mit.edu/lyapunov.html#ex:global_pend  
% Script is modifed from the following examples
% SOSDEMO2 --- Lyapunov Function Search
% Section 3.2 of SOSTOOLS User’s Manual
%
% Need to add sedumi tools to the workspace
clear; echo on;
syms x1 x2 x3;
vars = [x1; x2; x3];
% Constructing the vector field dx/dt = f for a simple normalized damped 
% pendulum with x1=sin(theta), x2=cos(theta), x3=theta_dot
f = [x2*x3;
    -x1*x3;
    -x3-x1];
% =============================================
% First, initialize the sum of squares program
prog = sosprogram(vars);
% =============================================
% The Lyapunov function V(x):
[prog,V] = sospolyvar(prog,[1;x1;x2;x3;x1*x2;x1*x3;x2*x3;x1^2; x2^2; x3^2],'wscoeff');

% The Lagrange multiplier function L(x):
[prog,L] = sospolyvar(prog,[1;x1;x2;x3;x1*x2;x1*x3;x2*x3;x1^2; x2^2; x3^2],'wscoeff');

% =============================================
% Next, define SOSP constraints
% Constraint 1 : V(x) - (x1^2 + x2^2 + x3^2) >= 0
tol=1e-4;
prog = sosineq(prog,V-tol*(x1^2+(x2-1)^2+x3^2));
% Constraint 2: -dV/dx*(x3^2+1)*f >= 0
expr = -(diff(V,x1)*f(1)+diff(V,x2)*f(2)+diff(V,x3)*f(3))- L * (x1^2 + x2^2 - 1) - tol*(x1^2+(x2-1)^2+x3^2)*x2^2;
prog = sosineq(prog,expr);
% =============================================
% And call solver
%prog = sossolve_PREV(prog);
% Set backend solver,
options.solver='sedumi';
prog = sossolve(prog,options);
% =============================================
% Finally, get solution
SOLV = sosgetsol(prog,V);

%% Plot V to see how it looks

syms theta theta_dot

SOLV1=subs(SOLV,x1,sin(theta));
SOLV2=subs(SOLV1,x2,cos(theta));
f=subs(SOLV2,x3,theta_dot);
fsurf(f)
figure()
fcontour(f,'LevelStep',0.5)