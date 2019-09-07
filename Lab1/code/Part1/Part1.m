%% MEROS 1

%{
AN 8ELEIS NA TREKSEIS TON KWDIKA PHGAINE STHN GRAMMH 
115, 116 KAI BALE STO LINSPACE ANTI GIA 20 10 H MIKROTERO
GIA NA TREKSEI PIO GRHGORA
%}
clear all;
close all;

I = imread('edgetest_16.png');
I = im2double(I); %convert the intensity image I to double precision
figure();
imshow(I);
%title('Original Image');
title('Original Image')
print -djpeg OriginalImage.jpeg


% maximum and minimum element of the original image 
maxel=max(max(I)); 
minel=min(min(I));

%% PSNR = 20 
sn1 = (maxel - minel)/(10^(20/20));
sn1 = sn1*sn1;
I1 = imnoise(I,'gaussian',0,sn1);
figure();
imshow(I1);
title('Noisy Image with PSNR=20db');
print -djpeg NoisyImagePSNR20.jpeg


% edge detect for given parameters 
D1 = EdgeDetect(I1,1.5,0.2,0); % 0 ---> linear detection
D2 = EdgeDetect(I1,1.5,0.2,1); % 1 ---> non-linear detection

figure();
imshow(D1);
title('Linear Detection of Image`s Edges with PSNR=20db');
print -djpeg linear_psnr20_given_parameters.jpeg

figure();
imshow(D2);
title('Non-Linear Detection of Image`s Edges with PSNR=20db');
print -djpeg non_linear_psnr20_given_parameters.jpeg


%%  PSNR = 10 
sn2 = (maxel - minel)/(10^(10/20));
sn2 = sn2*sn2;
I2 = imnoise(I,'gaussian',0, sn2);
figure();
imshow(I2);
title('Noisy Image with PSNR=10db'); 
print -djpeg NoisyImagePsnr10.jpeg


% edge detect for given parameters 
D11 = EdgeDetect(I2,3,0.2,0); % 0 ---> linear detection
D22 = EdgeDetect(I2,3,0.2,1); % 1 ---> non-linear detection

figure();
imshow(D11);
title('Linear Detection of Image`s Edges with PSNR=10db');
print -djpeg linear_psnr10_given_parameters.jpeg


figure();
imshow(D22);
title('Non-Linear Detection of Image`s Edges with PSNR=10db');
print -djpeg non_linear_psnr10_given_parameters.jpeg


%% Entopismos Alh8inwn Akmwn (ths original image)
B = strel('disk',1);
M = imdilate(I,B) - imerode(I,B);
T = (M > 0.2); % pairnw thn eikona alh8inwn akmwn
figure();
imshow(T);
title('Edges of Original Image');
print -djpeg EdgesOfOriginalImage.jpeg


%% Posotikh Aksiologish Gia tis Dosmenes Parametrous

% PSNR = 20
x1 = D1 & T;
C1L = sum(x1(:))/sum(T(:)) + sum(x1(:))/sum(D1(:));
C1L = C1L/2;

x2 = D2 & T;
C1NL = sum(x2(:))/sum(T(:)) + sum(x2(:))/sum(D2(:));
C1NL = C1NL/2;

% PSNR = 10
x3 = D11 & T;
C2L = sum(x3(:))/sum(T(:)) + sum(x3(:))/sum(D11(:));
C2L = C2L/2;

x4 = D22 & T;
C2NL = sum(x4(:))/sum(T(:)) + sum(x4(:))/sum(D22(:));
C2NL = C2NL/2;

%% Eksagwgh Suberasmatwn Gia Diafores Times Twn Parametrwn ThetaEdge Kai sn

% Dhmiourgw duo pinakes aksiologishs gia ka8e PSNR , dhladh sunolika 4 pinakes:
% Cl1 kai Cnl1 gia PSNR = 20 kai Cl2 kai Cnl2 gia PSNR = 10. Apo tous
% pinakes autous 8a brw to megisto stoixeio tous, dhladh ekei pou exoyn thn
% kaluterh aksiologish apotelesmatos kai gi auth thn aksiologish 8a vrw 
% poia einai ta sn kai ThetaEdge pou thn paragoun. Etsi vriskw to kalutero
% apotelesma gia ka8ena apo ta PSNR kai gia kathe tupo proseggishs ths
% Laplacian.

sn = linspace(0.6, 8, 20); 
ThetaEdge = linspace(0, 0.7, 20);
index1= 1; index2 = 1;
for i = sn
    for j = ThetaEdge
        % PSNR = 20
        D1 = EdgeDetect(I1, i, j, 0); % linear
        D2 = EdgeDetect(I1, i, j, 1); % non-linear
        x1 = D1 & T;
        xn1 = D2 & T;
        %posotikh aksiologish
        Cl1(index1,index2) = (sum(x1(:))/sum(T(:)) + sum(x1(:))/sum(D1(:)))/2;
        Cnl1(index1,index2) = (sum(xn1(:))/sum(T(:)) + sum(xn1(:))/sum(D2(:)))/2;
        
        % PSNR = 10
        D11 = EdgeDetect(I2, i, j, 0); % linear
        D22 = EdgeDetect(I2, i, j, 1); %non-linear
        x2 = D11 & T;
        xn2 = D22 & T;
        %posotikh aksiologish
        Cl2(index1,index2) = (sum(x2(:))/sum(T(:)) + sum(x2(:))/sum(D11(:)))/2;
        Cnl2(index1,index2) = (sum(xn2(:))/sum(T(:)) + sum(xn2(:))/sum(D22(:)))/2;
        
        index2 = index2 +1;
    end
    index1 = index1 +1;
    index2 = 1;
end

% 3D plots to see where C arrays have max
[U,UU] = meshgrid(ThetaEdge,sn);
figure(); 
surf(U,UU,Cl1);
title('PSNR = 20, Linear');
print -djpeg SURF_20_LINEAR.jpeg


[V,VV] = meshgrid(ThetaEdge,sn);
figure(); 
surf(V,VV,Cnl1);
title('PSNR = 20, Non Linear');
print -djpeg SURF_20_NON_LINEAR.jpeg


[M,MM] = meshgrid(ThetaEdge,sn);
figure(); 
surf(M,MM,Cl2);
title('PSNR = 10, Linear');
print -djpeg SURF_10_LINEAR.jpeg


[L,LL] = meshgrid(ThetaEdge,sn);
figure(); 
surf(L,LL,Cnl2);
title('PSNR = 10, Non Linear');
print -djpeg SURF_10_NON_LINEAR.jpeg


% Euresh kaluterhs aksilogishs gia ka8e psnr kai tupo proseggishs laplacian
max_element = max(max(Cl1));
% to megisto stoixeio-aksiologish mporei na uparxei parapanw apo mia fores mesa ston
% ka8e pinaka, gi' auto vriskw olous tous deiktes a,b pou to dinoun.
[a1,b1] = find(Cl1 == max_element,1); % arkei na vreis mono ton prwto deikth pou exeis megisth aksilogish
[a_all1,b_all1] = find(Cl1 == max_element); % vriskw kai olous tous deiktes megisths aksiologishs gia na eimai plhrhs
s1l = sn(a1);
th1l = ThetaEdge(b1);
Inew1= EdgeDetect(I1,s1l,th1l,0); % best linear detection for psnr=20
figure();
imshow(Inew1);
title('BEST LINEAR EDGE DETECTION FOR PSNR=20db');
print -djpeg BEST_LINEAR_PSNR20.jpeg


max_element = max(max(Cnl1));
[a2,b2] = find(Cnl1 == max_element,1); % arkei na vreis mono ton prwto deikth pou exeis megisth aksilogish
[a_all2,b_all2] = find(Cnl1 == max_element); % vriskw kai olous tous deiktes megisths aksiologishs gia na eimai plhrhs
s1nl = sn(a2);
th1nl = ThetaEdge(b2);
Inew2= EdgeDetect(I1,s1nl,th1nl,1); % best non-linear detection for psnr=20
figure();
imshow(Inew2);
title('BEST NON LINEAR EDGE DETECTION FOR PSNR=20db');
print -djpeg BEST_NON_LINEAR_PSNR20.jpeg


max_element = max(max(Cl2));
[a3,b3] = find(Cl2 == max_element,1); % arkei na vreis mono ton prwto deikth pou exeis megisth aksilogish
[a_all3,b_all3] = find(Cl2 == max_element); % vriskw kai olous tous deiktes megisths aksiologishs gia na eimai plhrhs
s2l = sn(a3);
th2l = ThetaEdge(b3);
Inew3= EdgeDetect(I2,s2l,th2l,0); % best linear detection for psnr=10
figure();
imshow(Inew3);
title('BEST LINEAR EDGE DETECTION FOR PSNR=10db');
print -djpeg BEST_LINEAR_PSNR10.jpeg


max_element = max(max(Cnl2));
[a4,b4] = find(Cnl2 == max_element,1); % arkei na vreis mono ton prwto deikth pou exeis megisth aksilogish
[a_all4,b_all4] = find(Cnl2 == max_element); % vriskw kai olous tous deiktes megisths aksiologishs gia na eimai plhrhs
s2nl = sn(a4);
th2nl = ThetaEdge(b4);
Inew4= EdgeDetect(I2,s2nl,th2nl,1); % best non linera detection for psnr 10
figure();
imshow(Inew4);
title('BEST NON LINEAR EDGE DETECTION FOR PSNR=10db');
print -djpeg BEST_NON_LINEAR_PSNR10.jpeg


%% Epidrash Metabolhs Parametrwn Sto Apotelesma

% PSNR = 20 

% for ThetaEdge
Ic1= EdgeDetect(I1,s1l,0.40,0); % 0.40 > th1l
Ic2= EdgeDetect(I1,s1l,0.10,0); % 0.10 < th1l
Ic3= EdgeDetect(I1,s1l,0.35,1); % 0.35 > th1nl
Ic4= EdgeDetect(I1,s1l,0.10,1); % 0.10 < th1nl

% for sn
Ic5= EdgeDetect(I1,3.0,th1l,0); % s1l < 3.0
Ic6= EdgeDetect(I1,0.5,th1l,0); % s1l > 0.5
Ic7= EdgeDetect(I1,2.5,th1nl,1); % s1l < 2.5
Ic8= EdgeDetect(I1,0.5,th1nl,1); % s1l > 0.5

figure();
subplot(2,2,1),imshow(Ic1,[]),title('LINEAR,HIGHER THETA');
subplot(2,2,2),imshow(Ic2,[]),title('LINEAR,LOWER THETA');
subplot(2,2,3),imshow(Ic3,[]),title('NON-LINEAR,HIGHER THETA');
subplot(2,2,4),imshow(Ic4,[]),title('NON-LINEAR,LOWER THETA');
print -djpeg subplotTHETA20_th.jpeg


figure();
subplot(2,2,1),imshow(Ic5,[]),title('LINEAR,HIGHER SN');
subplot(2,2,2),imshow(Ic6,[]),title('LINEAR,LOWER SN');
subplot(2,2,3),imshow(Ic7,[]),title('NON-LINEAR,HIGHER SN');
subplot(2,2,4),imshow(Ic8,[]),title('NON-LINEAR,LOWER SN');
print -djpeg subplotSN20_th.jpeg



% PSNR = 10

% for ThetaEdge
Ic11= EdgeDetect(I2,s2l,0.45,0); % 0.45 > th2l
Ic22= EdgeDetect(I2,s2l,0.15,0); % 0.15 < th2l
Ic33= EdgeDetect(I2,s2nl,0.40,1); % 0.4 > th2nl
Ic44= EdgeDetect(I2,s2nl,0.10,1); % 0.10 < th2nl

% for sn 
Ic55= EdgeDetect(I2,3.0,th2l,0); % s2l < 3.0
Ic66= EdgeDetect(I2,0.5,th2l,0); % s2l > 0.5
Ic77= EdgeDetect(I2,3.0,th2nl,1); % s2nl < 3.0
Ic88= EdgeDetect(I2,0.5,th2nl,1); % s2nl > 0.5


figure();
subplot(2,2,1),imshow(Ic11,[]),title('LINEAR,HIGHER THETA');
subplot(2,2,2),imshow(Ic22,[]),title('LINEAR,LOWER THETA');
subplot(2,2,3),imshow(Ic33,[]),title('NON-LINEAR,HIGHER THETA');
subplot(2,2,4),imshow(Ic44,[]),title('NON-LINEAR,LOWER THETA');
print -djpeg subplotTHETA10_th.jpeg


figure();
subplot(2,2,1),imshow(Ic55,[]),title('LINEAR,HIGHER SN');
subplot(2,2,2),imshow(Ic66,[]),title('LINEAR,LOWER SN');
subplot(2,2,3),imshow(Ic77,[]),title('NON-LINEAR,HIGHER SN');
subplot(2,2,4),imshow(Ic88,[]),title('NON-LINEAR,LOWER SN');
print -djpeg subplotSN10_th.jpeg

