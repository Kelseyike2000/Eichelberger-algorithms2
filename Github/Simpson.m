function I = Simpson(x,y)
%Simpson takes x and y value vectors for a function and integrates them
%using Simpson's 1/3 rule and maybe the Trapezoid rule if it so applies.


%Checking for the right x and y vector dimensions 
if numel(x) ~= numel(y)
    error('x and y vectors must have same dimensions')
    return
end

%Checking for the right x vector element spacing
number = numel(x);
checker = linspace(x(1,1),x(1,number),number);
logic_array = (checker == x); %confirms equal spacing
logic_sum = sum(logic_array);
if logic_sum ~= number
    error('unequal spacing. Simpsons rule cannot be used');
    return
end

%Finding out if Trapezoidal rule must be used
space = diff(x);
c = numel(space);
d = c/2;

%Warn the user if the Trapezoidal rule must be used 
if floor(d) ~= d
    warning('there is an odd number of segments, the Trapezoid rule must be used for the last segment');
    app = d-0.5;
end

if floor(d) == d
    app = d;
end

%Using Simpson's 1/3 Rule
sum_matrix = zeros(1,c);
j = 1;
for j= 1:app
    p = 2*j-1;
    sum_matrix(1,j) = (x(p+2)-x(p))*((y(p)+4*y(p+1)+y(p+2))/6);
end

%Using the Trapezoidal Rule (if necessary)
if floor(d) ~= d
    g = numel(x);
    sum_matrix(1,g+1) = (x(g)-x(g-1))*((y(g)+y(g-1))/2);
end

%Final calculation
I = sum(sum_matrix);

%Displaying it
fprintf('The integral value I = %f\n',I);

end


