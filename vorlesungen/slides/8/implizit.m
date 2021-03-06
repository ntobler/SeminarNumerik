#
# implizit.m
#
# (c) 2020 Prof Dr Andreas Müller, Hochschule Rapperswil
#

hx = 0.1
ht = 0.1
kappa = 1

N = 101;
M = 50;

A = eye(N);
A = shift(A,-1) - 2 * A + shift(A,1);
A = eye(N) + A * (kappa * ht/(hx^2));
A(1,:) = A(2,:);
A(N,1) = A(N-1,:);
a=eig(A);
max(e)
min(e)

B = inverse(eye(N)-A);
e = eig(B);
max(e)
min(e)
spectralradius = max(abs(eig(B)))

s = 3;

u = zeros(N,1);

for i = (-5:5)
	u(round(N/2)+i,1) = s;
endfor

fn = fopen("implizit.inc", "w");

for t = (0:M-1)
	uneu = B * u;
	for x = (1:N-1)
		fprintf(fn, "triangle { \n");
		fprintf(fn, "\t<%.4f,%.4f,%.4f>,\n",
			x    * hx, u(x  , 1),  t    * ht);
		fprintf(fn, "\t<%.4f,%.4f,%.4f>,\n",
			(x+1) * hx, u(x+1, 1),  t    * ht);
		fprintf(fn, "\t<%.4f,%.4f,%.4f>\n}\n",
			x    * hx, uneu(x  , 1), (t+1) * ht);
		fprintf(fn, "triangle { \n");
		fprintf(fn, "\t<%4f,%4f,%4f>,\n",
			(x+1) * hx, u(x+1, 1),  t    * ht);
		fprintf(fn, "\t<%4f,%4f,%4f>,\n",
			x    * hx, uneu(x  , 1), (t+1) * ht);
		fprintf(fn, "\t<%4f,%4f,%4f>\n}\n",
			(x+1) * hx, uneu(x+1, 1), (t+1) * ht);
	endfor
	u = uneu;
endfor

fclose(fn);

