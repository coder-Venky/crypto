function bit1 = extractt (ppm,l)
out = [ppm];

p = out(2);
q = out(1);

hh   =  (((2*3) + 1) * p ) + q;
jj = mod(hh,l);
bit1 = jj;
