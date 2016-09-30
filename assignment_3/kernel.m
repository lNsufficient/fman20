function kx = kernel(X)
%KERNEL Beräknar hela kernel-matrisen
%Skapar matris där K(xi, xj) = xi'*xj;
%   xi är den ite kollumnen i X
kx = X'*X;

end

