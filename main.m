clc;
close all;
clear all;



%% input frames
cd 'frames'
[fileip path] = uigetfile('*.bmp','pick any frame');
if fileip == 0
    warndlg('select any image');
else
    ip = imread(fileip);
    R = ip(:,:,1);
    G = ip(:,:,2);
    B = ip(:,:,3);
end
title('input image');
imshow(B);
title('B-panel image');
temp = ip;
cd ..
pascode=importdata('pasword.txt')
inp=input(sprintf('enter dta  %s'name),'s')
if isequal(ans,ans1)
        uiwait(msgbox('Password Correct !!'));
        dout=decrypt( out,1 )
       
else

break;
end
%%keygener=zeros(8,8);
key=[0 0 1 0 ;0 0 1 1 ;0 1 0 1; 0 1 1 1; 1 0 0 0; 1 0 1 0; 1 1 0 1; 1 0 1 1];
key1=[0 0 1 0 0 0 1 0 ;0 0 1 1 0 0 1 1 ;0 1 0 1 0 1 0 1; 0 1 1 1 0 1 1 1];
keygener(1:8,5:8)=key;
keygener(5:8,1:8)=key1;
orig_key=keygener;
Y1 =B;
%%%%% Select the text file to conceal
[file path]=uigetfile('*.txt','choose txt file');

 data1=fopen(file,'r');
 F=fread(data1);
 F = F';
 fclose(data1);

[r c]=size(F);
u =3.99999; csp =0.400005674;

for i = 1:r
     for j = 1:c
            csp = u*csp*(1-csp); 
            n = thrldfun(csp); 
            Etxt(i,j)=bitxor(F(i,j),n); 
            
     end
end



len=length(Etxt);
count=1;
totalbits=8*len;
a=128;
k=1;
[r c]=size(B);
for i=1:8:r-7;
    for j=1:8:c-7;
        block3=B(i:i+7,j:j+7);
        for ii=1:8
            for jj=1:8;
                if orig_key(ii,jj)==1;
                    coeff=abs(block3(ii,jj));
                    [ block3(ii,jj),a,k,count]=embed(coeff,a,k,Etxt,totalbits,count,len);
                    if count>totalbits;
                        break;
                    end
                end
                if count>totalbits;
                    break;
                end
            end
            if count>totalbits;
                break;
            end
        end
        Y1(i:i+7,j:j+7)=block3;
        Y1=abs(Y1);
        if count>totalbits;
            break;
        end
    end
    if count>totalbits;
        break;
    end
end
outpu_t=Y1;

embededimage= outpu_t;


%% logo
cd 'inp_logo'
[file path] = uigetfile('*.*','pick any frame');
if file == 0
    warndlg('select any image');
else
    l = imread(file);
    l = imresize(l,[256 256]);
    [r c p] = size(l);
    if p == 3
        l = rgb2gray(l);
    end
end 
subplot(2,2,3);imshow(l);
title('logo image');
cd ..

%% Apply SVD for cover image
B = double(B);
[u s v] = svd(B);
[m n] = size(s);

for i =1:m
        sip(i,1) = s(i,i);
end

%% Apply SVD for logo image
l = double(l);
[u1 s1 v1] = svd(l);
[m1 n1] = size(s1);

for k = 1:m1
    sL(k,1) = s1(k,k);
end

%% Watermarking process
alpha = 0.01;

for i = 1:m
     swi(i,1) = sip(i,1)+(sL(i,1)*alpha);
end

for i =1:size(u,1)
    sW(i,i) = swi(i,1);
end

Watermarked = u*sW*v';
Watermarked = uint8(Watermarked);
subplot(2,2,4);imshow(Watermarked);
title('watermarked image');
impixelinfo;

%% qr image
cd qr_image
[file path] = uigetfile('*.*','pick any frame');
if file == 0
    warndlg('select any image');
else
    q = imread(file);
    q = imresize(q,[256 256]);
    [r1 c1 p1] = size(q);
    if p1 == 3
        q = rgb2gray(q);
    end
end
figure(2);
subplot(2,2,2);imshow(q);
title('qr image');
cd ..

%% dwt for qr image
[ll lh hl hh] = dwt2(q,'haar');
out = [ll lh;hl hh];
subplot(2,2,3);imshow(out);
title('watermarked dwt image');

%% dwt for watermarked image
[ll1 lh1 hl1 hh1] = dwt2(Watermarked,'haar');
out1 = [ll1 lh1;hl1 hh1];
subplot(2,2,1);imshow(out1,[]);
title('watermarked dwt image');

%% embedding
alpha1 = 0.01;
qri = out(:);
wi = out1(:);
[r c] = size(wi);
for i = 1:r
    for j = 1:c
        fi(i,j) = wi(i,j)+(alpha1*qri(i,j));
    end
end
fo = reshape(fi,[r1 c1]);
g = r1/2;
for i = 1:r1/2
    for j = 1:c1/2
        LL(i,j) = fo(i,j);
        LH(i,j) = fo(i,j+g);
        HL(i,j) = fo(i+g,j);
        HH(i,j) = fo(i+g,j+g);
    end
end
re = idwt2(LL,LH,HL,HH,'haar');
subplot(2,2,4);imshow(re,[]);
title('watermarked image');
impixelinfo;

%% color reconstruction
rec(:,:,1) = R;
rec(:,:,2) = G;
rec(:,:,3) = re;
cd frames
imwrite(uint8(rec),fileip);
cd ..
figure(3);
imshow(rec,[]);
title('Reconstructed image');
impixelinfo;

fil_e=rec;

a=128;
jjj=1;
count=1;
k=0;
[r c]=size(rec);
for i=1:8:r-7;
    for j=1:8:c-7;
        block9=fil_e(i:i+7,j:j+7);
        for ii=1:8
            for jj=1:8;
                if orig_key(ii,jj)==1;
                    coeff=abs(block9(ii,jj));
                    g=coeff;
                    if g>=64;
                        bits=6;

                        h=32;
                    elseif g<64 & g>=32;
                        bits=5;

                        h=16;
                    elseif g<32 & g>=16;
                        bits=4;

                        h=8;
                    elseif g<16
                        bits=3;
                        h=4;
                    end
                    l=bits;
                    for iii=1:l;
                        if bitand(g,h)==h;
                            k= bitor(k,a);
                        end
                        count=count+1;
                        a=a/2;
                        h=h/2;
                        if a<1;
                            etxt(jjj)=k;
                            jjj=jjj+1;
                            k=0;
                            a=128;
                        end
                        if count>totalbits;
                            break;
                        end
                    end
                    if count>totalbits;
                        break;
                    end
                end
                if count>totalbits;
                    break;
                end
            end
            if count>totalbits;
                break;
            end
        end
        if count>totalbits;
            break;
        end
    end
    if count>totalbits;
        break;
    end
end




%% validation
input=double(B);
Embedded=double(re);
MSE = sum(sum((Embedded-input).^2))/(r*c);
disp(sprintf('MSE:%f',MSE));
RMSE = sqrt(MSE);
disp(sprintf('RMSE:%f',RMSE));
PSNR = 10*log10(255*255/MSE);
disp(sprintf('PSNR:%f',PSNR));

%% extraction
ipf = temp(:,:,3);
cd frames
wim = imread(fileip);
cd ..
wimg = wim(:,:,3);
% wimg = re;
[r2 c2] = size(wimg);

%% logo extraction
wimg = double(wimg);
[u2 s2 v2] = svd(wimg);
[m n] = size(s);

for i =1:m
        os(i,1) = s2(i,i);
end

alpha = 0.01;

for i = 1:m
   Wt2(i,1) = (os(i,1) - sip(i,1))./alpha;
end

for k = 1:m
    ST2(k,k) = Wt2(k,1);
end

logo = u1*ST2*v1';
figure(5);
subplot(1,3,1);
imshow(logo,[]);
title('extracted logo');

%% qr extraction
% dwt for orginal image
[ll2 lh2 hl2 hh2] = dwt2(ipf,'haar');
out2 = [ll lh;hl hh];
org = out2(:);

%% dwt for final watermarked image
[ll3 lh3 hl3 hh3] = dwt2(wimg,'haar');
out3 = [ll1 lh1;hl1 hh1];
fwid = out3(:);

[r c] = size(fwid);
for i = 1:r
    for j = 1:c
        qrig(i,j) = (fwid(i,j)-org(i,j))./alpha;
    end
end
eqri = reshape(qrig,[r2 c2]);
subplot(1,3,2);imshow(eqri,[]);
title('extracted qr image in dwt form');

%% idwt
g = r2/2;
for i = 1:r2/2
    for j = 1:c2/2
        LL1(i,j) = eqri(i,j);
        LH1(i,j) = eqri(i,j+g);
        HL1(i,j) = eqri(i+g,j);
        HH1(i,j) = eqri(i+g,j+g);
    end
end
qr_i = idwt2(LL1,LH1,HL1,HH1,'haar');
qr_i = imcomplement(qr_i);
imwrite(qr_i,'extqr.bmp');
qre = imread('extqr.bmp');
subplot(1,3,3);imshow(qre,[]);
title('extracted qr image');
impixelinfo;


