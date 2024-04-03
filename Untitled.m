
clc
clear all;
fid = fopen('pasword.txt');
tx = fread(fid,'char');
tx1 = tx';
fclose(fid);

z=input('enter uyi:');
if isequal(tx,z)
    uiwait(msgbox('Password Correct !!'));
else
    uiwait(msgbox('Password inCorrect'));
end
    

