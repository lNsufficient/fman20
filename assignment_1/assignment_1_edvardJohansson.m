%Assignment 1

%Exc 1
N = 5;

f = @(x,y) 4*x*(1-x);
F = zeros(N,N);

x = linspace(0,1,N);
y = linspace(0,1,N);

for i = 1:N
    for j = 1:N
        F(N+1-j,i) = f(x(i),y(j));
    end;
end;

minF = min(min(F));
F = F - minF;

maxF = max(max(F));

maxQuant = 15;

Ffactor = maxQuant/maxF;
F = F*Ffactor;
F = round(F);

%Exc 2

r = linspace(0,1);
pr = 3/2*sqrt(r);
plot(r,pr);
figure();
T = @(r) r.^(3/2)
plot(r,T(r));

%Exc 4
u = [1, -3; 4, -1];
v = 1/2*[1, 1; -1, -1];
w = 1/2*[1, -1,; 1, -1];

dot = @(x,y) x(:)'*y(:);
nom = @(u) sqrt(dot(u,u));

answers = [nom(u), nom(v), nom(w), dot(u,v), dot(u,w), dot(v,w)];

%Exc 6
fi1 = 1/3*[0 1 0; 1 1 1; 1 0 1; 1 1 1];
fi2 = 1/3*[1 1 1 ; 1 0 1; -1, -1 -1; 0 -1 0];
fi3 = 1/2*[1 0 -1; 1 0 -1; 0 0 0;0 0 0];
fi4 = 1/2*[0 0 0; 0 0 0; 1 0 -1; 1 0 -1];

norms = [nom(fi1); nom(fi2); nom(fi3); nom(fi4)];
scalars  = [dot(fi1,fi2), dot(fi1, fi3), dot(fi1, fi4), dot(fi2, fi3), dot(fi2,fi4), dot(fi3,fi4)];

f = [-2 6 3; 13 7 5; 7 1 8; -3 3 4];

x = [dot(f,fi1), dot(f,fi2), dot(f,fi3), dot(f,fi4)];