function  [ppm] = pixpair(ary,dt,x5,y5)

if dt==0
    r = y5;
    c = x5;
    ppm = [x5 y5];
    return;
else
[r c] = find(ary==dt);
end

i=1;
r1(i) = c;
c1(i) = r;

      
if r1(i) ==4 & c1(i) ==1
    ppm = [x5 - 3 y5];
elseif   c1(i) ==2 & r1(i) ==3
    ppm = [x5-2 y5-1];
    
   elseif   c1(i) ==2 & r1(i) ==4
    ppm = [x5-2 y5]; 
    
   elseif   c1(i) ==2 & r1(i) ==5
    ppm = [x5-2 y5+1]; 
    
    elseif   c1(i) ==3 & r1(i) ==2
    ppm = [x5-1 y5-2];
    
    elseif   c1(i) ==3 & r1(i) ==3
    ppm = [x5-1 y5-1];
    elseif   c1(i) ==3 & r1(i) ==4
    ppm = [x5-2 y5];
    elseif   c1(i) ==3 & r1(i) ==5
    ppm = [x5-1 y5+1];
    elseif   c1(i) ==3 & r1(i) ==6
    ppm = [x5-1 y5+2];
    
    elseif   c1(i) ==4 & r1(i) ==1
    ppm = [x5 y5-3];
    elseif   c1(i) ==4 & r1(i) ==2
    ppm = [x5 y5-2];
    elseif   c1(i) ==4 & r1(i) ==3
    ppm = [x5 y5-1];
    elseif   c1(i) ==4 & r1(i) ==4
    ppm = [x5 y5];
    elseif   c1(i) ==4 & r1(i) ==5
    ppm = [x5 y5+1];
    elseif   c1(i) ==4 & r1(i) ==6
    ppm = [x5 y5+2];
    elseif   c1(i) ==4 & r1(i) ==7
    ppm = [x5 y5+3];
    
    
    
    
    elseif   c1(i) ==5 & r1(i) ==2
    ppm = [x5+1 y5-2];
    elseif   c1(i) ==5 & r1(i) ==3
    ppm = [x5+1 y5-1];
    elseif   c1(i) ==5 & r1(i) ==4
    ppm = [x5+1 y5];
    elseif   c1(i) ==5 & r1(i) ==5
    ppm = [x5+1 y5+1];
    elseif   c1(i) ==5 & r1(i) ==6
    ppm = [x5+1 y5+2];
    
    
    
    elseif   c1(i) ==6 & r1(i) ==3
    ppm = [x5+2 y5-1];
    elseif   c1(i) ==6 & r1(i) ==4
    ppm = [x5+2 y5];
    elseif   c1(i) ==6 & r1(i) ==5
    ppm = [x5+2 y5+1];
    
    
    elseif   c1(i) ==7 & r1(i) ==4
    ppm = [x5+3 y5];
end
    
 