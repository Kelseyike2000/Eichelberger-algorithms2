function [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter)
%falsePosition: find the roots of a function using the false position
%method
%   [root,fx,ea,iter] = falsePosition(func,xl,xu,es,maxiter): uses the
%   method to locate the root of a function

format long

%Error for the incorrect number of inputs

if nargin < 3
    error('need minimum three inputs: falsePosition(func,xl,xu,es,maxiter)')
elseif nargin > 5
    error('only five outputs maximun: falsePosition(func,xl,xu,es,maxiter)')
end    
 
%Error if the x values have the same sign; they need to be different to
%bracket the root

if sign(func(xl)) == sign(func(xu)) 
    error('no root found in bracket')
end

%set the default values of the error and the max iteration if they're
%otherwise not imputed by the user

if nargin == 3
    es = 0.0001;
    maxiter = 200;
end

%using the false position method to calculate the root through multiple
%iterations

iter = 0; 
ea = 1;
ea_prev = 1;
xr = 0;

while (ea == 0 || ea > 0.0001) && iter < 200
    ea_prev = ea;
    iter = iter+1;
    xr_prev = xr;
    xr = xu-((func(xu)*(xl-xu))/(func(xl)-func(xu)));
    if iter > 1
        ea = abs(((xr-xr_prev)/xr)*100);
    end
    if sign(func(xr)) == sign(func(xl))
        xl = xr;
    elseif sign(func(xr)) == sign(func(xu))
        xu = xr;
    end
end

%evaluating the function at the root and re-naming variables

root = xr;
fx = func(xr);

%outputs

fprintf('the estimated root of the function is %s\n',root)
fprintf('the function evaluated at the root is %s\n',fx)
fprintf('the approximate persent relative error is %s\n',ea)
fprintf('the number of iterations is %s\n',iter)