function [a,a1,a2,a3,a4,a5,a6,b1,b2,b3,b4,b5,c1,c2,c3,d,e,e1,e2,e3,e4,h,h1,h2,g] = array(p,q);


%%%%%%%   Center Line   a .... a6 

a  = [p q];
a1 = [p q-1];
a2 = [p q-2];
a3 = [p q-3];
a4 = [p q+1];
a5 = [p q+2];
a6 = [p q+3];



%%%%%%%  First Left Line    b1 ...... b5 

b1 = [p-1 q];
b2 = [p-1,q-1];
b3 = [p-1,q-2];
b4 = [p-1,q+1];
b5 = [p-1,q+2];



%%%%%%%  2 nd  Left Line    c1 ...... c3 


c1 = [p-2,q];
c2 = [p-2,q-1];
c3 = [p-2,q+1];


%%%%%%%  3 rd  Left Line    d ...... d 

d = [p-3 q];


%%%%%%%  1 st  right  Line    e ...... e4


e  = [p+1 q];
e1 = [p+1 q-1];
e2 = [p+1 q-2];
e3 = [p+1 q+1];
e4 = [p+1 q+2];


%%%%%%%  2 nd   right  Line    f ...... f4

h  = [p+2 q];
h1 = [p+2 q-1];
h2 = [p+2 q+1];


%%%%%%%  3 rd   right  Line    g .... g


g = [p+3 q];



%%%%%%% k = 3  Notational array 


%   f(p1,q1) = mod ( ( (2*k + 1) * p + q ),l);  formula 