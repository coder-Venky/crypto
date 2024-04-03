function ary = nottable(ary,p,q,aa,a11,a22,a33,a44,a55,a66,b11,b22,b33,b44,b55,c11,c22,c33,dd,ee,e11,e22,e33,e44,hh,h11,h22,gg);
ary(p,q) = aa;
ary(q-1,p) = a11;
ary(q-2,p) = a22;
ary(q-3,p) = a33;
ary(q+1,p) = a44;
ary(q+2,p) = a55;
ary(q+3,p) = a66;


ary(q,p-1) = b11;
ary(q-1,p-1) = b22;
ary(q-2,p-1) = b33;
ary(q+1,p-1) = b44;
ary(q+2,p-1) = b55;


ary(q,p-2) = c11;
ary(q-1,p-2) = c22;
ary(q+1,p-2) = c33;

ary(q,p-3) = dd;


ary(q,p+1) = ee;
ary(q-1,p+1) = e11;
ary(q-2,p+1) = e22;
ary(q+1,p+1) = e33;
ary(q+2,p+1) = e44;


ary(q,p+2) = hh;
ary(q-1,p+2) = h11;
ary(q+1,p+2) = h22;

ary(q,p+3) = gg;