fid = fopen('pasword.txt');
tx = fread(fid,'char');
tx1 = tx';
fclose(fid);
inp=input(sprintf('enter dta  %s',name),'s')