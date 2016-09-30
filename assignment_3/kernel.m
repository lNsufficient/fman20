function kx = kernel(X1, X2)
%KERNEL Beräknar hela kernel-matrisen
%Skapar matris där K(xi, xj) = xi'*xj;
%   xi är den ite kollumnen i X
kx = X1'*X2;

end

