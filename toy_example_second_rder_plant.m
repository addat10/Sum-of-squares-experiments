%% 
% This script is used to analyze a mass-friction LTI sys with SOS tools 
% as a sanity check and for getting insight
%
clear; echo on;
k_d= 1; % damping
k_p = 1; % non-linear spring coeff
syms x v ;
vars = [x; v];
% Constructing the vector field dx/dt = f
f = [v;
-k_d*v - k_p*x^3];
% =============================================
% First, initialize the sum of squares program
prog = sosprogram(vars);
% =============================================
% The Lyapunov function V(x):
% [prog,V] = sospolyvar(prog,[1;x;v;x*v;x^2;v^2;x^3;x^2*y;x*y^2;y^3],'wscoeff');
[prog,V] = sospolyvar(prog,monomials(vars,1:4),'wscoeff');
% =============================================
% Next, define SOSP constraints
% Constraint 1 : V(x) - (x1^2 + x2^2 + x3^2) >= 0
tol=1e-4;
prog = sosineq(prog,V-tol*(x^2+v^2));
% prog = soseq(prog,subs(subs(V,x,1),v,1)==1);
% subs1=subs(V,x,0);
% prog = soseq(prog,subs(subs1,v,0)==0);

% Constraint 2: -dV/dx*(x3^2+1)*f >= 0
expr = -(diff(V,x)*f(1)+diff(V,v)*f(2))-tol*(x^4+v^2);
prog = sosineq(prog,expr);
% =============================================
% And call solver
%prog = sossolve_PREV(prog);
% Set backend solver,
options.solver='sedumi';
prog = sossolve(prog,options);
% =============================================
% Finally, get solution
SOLV = sosgetsol(prog,V)

%% Plot V to see how it looks

figure()
fcontour(SOLV,'LevelStep',0.5)
