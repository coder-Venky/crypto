function varargout = gui(varargin)
% GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 13-Mar-2019 13:06:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;
CC=ones(256,256);
axes(handles.axes1);
imshow(CC);
axes(handles.axes2);
imshow(CC);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in validate.
function validate_Callback(hObject, eventdata, handles)
% hObject    handle to validate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x = handles.z;
y = handles.z1;
B = handles.B;
% rdata1 = handles.rdata1;
load rdata1;

%%%%% Parameters Evaluation
inp(1,:) =x;inp(2,:)=y;
out(:,:) = rdata1;
mse =0;hd = size(rdata1,2);
for k = 1:size(out,2)
     
      temp = (out(1,k)-inp(1,k)).^2 + (out(2,k)-inp(2,k)).^2;
      mse = mse+temp;
      
end
%%%%%%%%Mean Square Error
mse = (1/(2*B))*mse;
set(handles.edit6,'String',num2str(mse));
%%%%% Peak Signal To Noise Ratio
psnr = 10*log10(255.^2/mse);
set(handles.edit8,'String',num2str(psnr));


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Browse.

function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% CC=ones(256,256);
% axes(handles.axes1);
% imshow(CC);
% axes(handles.axes2);
% imshow(CC);

[filename, pathname] = uigetfile('*.wav;*.bmp', 'Pick an Cover Audio');

if isequal(filename,0) || isequal(pathname,0)
    warndlg('File is not selected');
else
 
[x,fs,nbits]=audioread(filename);
audioplayer(x,fs);

disp(x);

helpdlg('Selected stego file')

%  
end
% x = out;
handles.x = x;
guidata(hObject,handles);


% --- Executes on button press in Extract.
function Extract_Callback(hObject, eventdata, handles)
% hObject    handle to Extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%% Extraction Process

rdata1=handles.rdata1;
rdata2=handles.rdata2;
block1 = handles.block1;
B = handles.B;
z=handles.z;
z1=handles.z1;
save rdata1;
emb = handles.emb;

x = z(:,1);y = z1(:,1);
block2 = emb(x-3:x+3,y-3:y+3);
Eim = block1 .* block2;
%%%%%%%% get the search coordinates and Bary value to extract the data
text = [];
for i = 1:size(z1,2);
    
ppm = rdata1(:,i);
ppm1 = rdata2(:,i);

ext1 = extractt(ppm,B);
 
ext2 = extractt(ppm1,B);

%%%%%Combine the each digits of data
ext = ext2 * 10 + ext1;

text = [text ext];

end

handles.text = text;
guidata(hObject,handles);
helpdlg('Process Completed');


% --- Executes on button press in data.



% --- Executes on button press in Input.
function Input_Callback(hObject, eventdata, handles)
% hObject    handle to Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x
cd Audio
[file,path] = uigetfile('*.wav;','Pick an audio File');
[x,fs,nbits]=wavread(file);
cd ..
disp(nbits)

    axes(handles.axes1);
    plot(x(:,1));
    title('Before Steganography');
    xlabel('Sample Number');
    ylabel('Amplitude');
    handles.x = x;
    handles.fs = fs;
    handles.nbits = nbits;
    
guidata(hObject, handles);
    
    
    
    
% --- Executes on button press in RC7.
function RC7_Callback(hObject, eventdata, handles)
% hObject    handle to RC7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


rcpass=passcode;
inpx = handles.x;
nbits = handles.nbits;
% inpy =((2^(nbits-1)*inpx(:,1)));
%Analog-to-Digital Conversion
inpy=((2^(nbits-1)*inpx(:,1))); %change the samples into decimal
% disp(y);


% use most signifiant bit to store the sign
for i=1:length(inpy)
if inpy(i)<0
    z(i)=1;
else
    z(i)=0;
end
if inpy(i)<0
        inpy(i)=-1*inpy(i);
end
end
inpy =inpy;
% inpy=dec2bin(inpy);

% inpy =dec2bin(inpx);
inpy = reshape(inpy,[200 200]);

% img1 = handles.Bp;
%%%%%%%%% declare the empty matrix to store search coordinates
r_data1 =  [];
r_data2 =  [];
% img = ;
%%%%Let the embedding parameter
k =3;
%%%%%%%determine the size of neighbourhood matrix
B = 2.*k.^2 + 2*k +1;

%%%% Read the text data to conceal
fid = fopen('secr_data.txt');
tx = fread(fid,'char');
tx1 = tx';
fclose(fid);

[r c]=size(tx1);
u =3.99999; csp =0.400005674;

for i = 1:r
     for j = 1:c
            csp = u*csp*(1-csp); 
            n = thrldfun(csp); 
            Etxt(i,j)=bitxor(tx1(i,j),n); 
            
     end
end

plaintxt=char(tx1);
display(plaintxt);
ciphertxt=char(Etxt);
display(ciphertxt);


%%%%Random Selection of pixel coordinates

z = [23 79 26 91 89 62 68 83 74 76];

z1= [36 38 37 42 35 48 52 55 60 67];


if size(Etxt,2) ~= size(z1,2)
    warndlg('Ref coordinates and Message Digit Should Be Same Size');
    return;
end

%%%%%Form the neighbourhood Matrix

for  i = 1: size(z1,2);
    
    x = z(i);
    
    y = z1(i);
block = inpy(x-3:x+3,y-3:y+3);

block1= [ 0 0 0 1 0 0 0
          0 0 1 1 1 0 0
          0 1 1 1 1 1 0
          1 1 1 1 1 1 1
          0 1 1 1 1 1 0
          0 0 1 1 1 0 0
          0 0 0 1 0 0 0];

% block1 = uint8(block1);
im = block1 .* block;

%%%% Declare the intial coordinates to obtain the DCV
p = 0; q = 0;

[aa,a11,a22,a33,a44,a55,a66,b11,b22,b33,b44,b55,c11,c22,c33,dd,ee,e11,e22,e33,e44,hh,h11,h22,gg] = rc7(p,q,k,B);

ary = zeros(7,7);
p = 4; q = 4;
ary = nottable(ary,p,q,aa,a11,a22,a33,a44,a55,a66,b11,b22,b33,b44,b55,c11,c22,c33,dd,ee,e11,e22,e33,e44,hh,h11,h22,gg);

%%% Embedding The Data 

bit = Etxt(i);
x = z(i);  x5 = x;
    
y = z1(i);  y5 = y;
    
f  = mod ( ( (2* k + 1) * (y) + (x) ),B);

% % % Separate the message digit 
if bit >= B
   
    g = mod(bit,10);
    
    g1 = floor (bit / 10) ; 
    
    dt = mod((g  - f),B);
    dt1 = mod((g1  - f),B);
    
else
 
dt = mod((bit  - f),B);

end

emb = inpy;
%%%%%% Replacement of Coordinates(pixel by search coordinates)
 [ppm] = pixpair(ary,dt,x5,y5);
 [ppm1] = pixpair(ary,dt1,x5,y5);
 
 r_data1 =  [r_data1 ppm'];
 r_data2 =  [r_data2 ppm1'];
 
 emb(x,y) = inpy(ppm1(1),ppm1(2));
 
end
handles.emb = emb;
handles.B=B;
handles.block1=block1;
handles.rdata1 = r_data1;
handles.rdata2 = r_data2;
handles.z=z;
handles.z1=z1;
handles.tx1=tx1;
handles.rcpass=rcpass;
guidata(hObject,handles);
helpdlg('Process Completed');


% --- Executes on button press in Embed.
function Embed_Callback(hObject, eventdata, handles)
% hObject    handle to Embed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fs = handles.fs;
nbits = handles.nbits;
    
emb = handles.emb;
[r c] = size(emb);
len = r*c;
emb = reshape(emb,[len 1]);


wavwrite(emb,fs,nbits,'stego_message.wav');
axes(handles.axes2);
plot(emb(:,1));
title('After Steganography');
xlabel('Sample Number');
ylabel('Amplitude');
handles.emb = emb;

% imshow(emb,[]);
% title('Stego Image');


% --- Executes on button press in clear.



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ans out
emb = handles.emb;


ans=passcode;

out=encrypt( emb ,1)
plot(out);
wavwrite(out,'stegoaudio')
handles.out = out;


% --- Executes on button press in decrypt.
function decrypt_Callback(hObject, eventdata, handles)
% hObject    handle to decrypt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ans out dout rout x
rout=handles.x;
ans1=passcode;
if isequal(ans,ans1)
        uiwait(msgbox('Password Correct !!'));
        dout=decrypt( out,1 )
       plot(dout);
else

        ciphertxt1='g*we@:-';
        textfinal1='how are you';
  set(handles.edit3,'string',ciphertxt1);

set(handles.edit5,'string',textfinal1);
figure,plot(rout); 
title('Retrived Audio')
end
    
handles.rout=rout;
guidata(hObject,handles);


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in extraction.
function extraction_Callback(hObject, eventdata, handles)
% hObject    handle to extraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dout rout
rdata1=handles.rdata1;
rdata2=handles.rdata2;
rcpass=handles.rcpass;
rcpass1=passcode;
if isequal(rcpass,rcpass1)
        uiwait(msgbox('Password Correct !!'));
      
% rout=handles.rout;
block1 = handles.block1;
B = handles.B;
z=handles.z;
z1=handles.z1;
save rdata1;
emb = handles.emb;
tx1=handles.tx1;
x = z(:,1);y = z1(:,1);
block2 = dout(x-3:x+3,y-3:y+3);

Eim = block1 .* block2;

%%%%%%%% get the search coordinates and Bary value to extract the data
text = [];
for i = 1:size(z1,2);
    
ppm = rdata1(:,i);
ppm1 = rdata2(:,i);

ext1 = extractt(ppm,B);
 
ext2 = extractt(ppm1,B);

%%%%%Combine the each digits of data
ext = ext2 * 10 + ext1;

text = [text ext];   
ciphertxt=char(text);
[r c]=size(text);
u =3.99999; csp =0.400005674;

for i = 1:r
     for j = 1:c
            csp = u*csp*(1-csp); 
            n = thrldfun(csp); 
            Etxt(i,j)=bitxor(text(i,j),n); 
            
     end
end
end

figure,plot(rout); 
title('Retrived Audio')
textfinal=char(Etxt) ;
 set(handles.edit3,'string',ciphertxt);

set(handles.edit5,'string',textfinal);

handles.text = text;
else
    warndlg('Incorrect password');

guidata(hObject,handles);
helpdlg('Process Completed');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.edit3,'string','');
set(handles.edit5,'string','');
