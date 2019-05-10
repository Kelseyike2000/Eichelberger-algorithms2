function [L,U,P] = luFactor(A)
%Input:

%A = coefficient matrix

%Output:

%L = lower triangular matrix
%U = upper triangular matrix
%P = pivot matrix

[q,r]=size(A);

%Error if the same number of rows and columns is not inputed for Matrix A.
%Matrix A has to be a square matrix. Sooo...
if q~=r, error('Matrix A must be a square matrix');
end

%L begins as the identity matrix the same size as Matrix A.
%L = P to become the pivot matrix and track the pivoting throughout the
%code.
%U = A to account for the changes made to A from L. 
%[L] is to [P] as [U] is to [A].
U = A; L = eye(r); P = L;

%Finding the highest absolute value elements of Matrix A in order to know
%which rows to pivot.
for v = 1:r
    [pivot q] = max(abs(U(v:r,v))); 
    q = q+v-1;
    
    %Pivoting in Matrix U to move the highest absolute value to
    %the top row.
    %Pivoting Matrix P to account for the pivoting in Matrix U.
    %Repeating this process until Matrix A is fully factored into U and L.
    if q~=v
        % change rows q and v in U
        peak = U(v,:);
        U(v,:) = U(q,:);
        U(q,:) = peak;
        % change rows q and v in P
        peak = P(v,:);
        P(v,:) = P(q,:);
        P(q,:) = peak;
       
        if v >= 2
            peak = L(v,1:v-1);
            L(v,1:v-1) = L(q,1:v-1);
            L(q,1:v-1) = peak;
        end    
    end
    
    for s = v+1:r
        L(s,v) = U(s,v)/U(v,v);
        U(s,:) = U(s,:)-L(s,v)*U(v,:);
    end
end

%Display the final Matrices from A as the Matrices L,U, and P.
%L = lower triangular matrix
%U = upper triangular matrix
%P = pivot matrix
disp('L = ');disp(L)

disp('U = ');disp(U)

disp('P = ');disp(P)




        




