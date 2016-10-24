P1 = [3 2 1 0; 2 2 2 0; 2 1 2 1];
P2 = [1 2 2 3 ; 1 1 0 2; 3 1 2 0];
F = [-4 2 -6; 3 0 7; -6 9 1];

a1 = [1; 2];
a2 = [3; 2];
a3 = [0; 3];

b1 = [1; 1];
b2 = [5; 1];
b3 = [-1; -3];

A = [a1 a2 a3; ones(1,3)];
B = [b1 b2 b3; ones(1,3)];

correspond = A'*F*B;
[m, n] = find(correspond == 0);
matches = [m, n] %först kolonnen säger vilken a-punkt, andra kolonnen säger
%vilken b-punkt.