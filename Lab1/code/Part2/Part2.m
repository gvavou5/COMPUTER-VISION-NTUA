%% MEROS 2
clear all;
close all;
%{ AN 8ELEIS NA TREKSEIS TON KWDIKA BALE TIS GRAMMES 37-50 SE SXOLIA GIA NA MHN SOU VGALEI POLLA PLOTS %}
%{ TO IDIO MPOREIS NA KANEIS KAI GIA TIS 24-27 THS BLOBDETECT %}
%{ TO IDIO MPOREIS NA KANEIS KAI GIA TIS 31-34 THS CORNERDETECT %}

%reading the image
Iorg = imread('sunflowers.png');
I = im2double(Iorg); %convert the intensity image I to double precision
Ibw= im2double(rgb2gray(Iorg)); % grayscale intensity image used for l+,l-
figure();
imshow(I);
title('Original Image');
print -djpeg OriginalImage.jpeg 


%% 2.1 Anixneush Gwniwn
% klhsh CornerDetect me tis endeiktikes parametrous.
% Ta erwthmata 2.1.1, 2.1.2 kai 2.1.3 ulopoiountai mesa sthn
% CornerDetect
[lplus,lminus,~] = CornerDetect(I,Ibw,2,2.5,0.05,0.005);
figure();
imshow(lplus,[]);
title('Grayscale Image for l+');
print -djpeg GrayscaleL+.jpeg
figure();
imshow(lminus,[]);
title('Grayscale Image for l-');
print -djpeg GrayscaleL-.jpeg

%klhsh CornerDetect me alles parametrous(tis beltistes pou vrhka me diafora peiramata)
%[~,~,~]=CornerDetect(I,Ibw,0.7,1.1,0.1,0.008);


%metabolh ths tupikhs apoklishs sigma
[~,~,~] = CornerDetect(I,Ibw,0.5,2.5,0.05,0.005); %lower
[~,~,~] = CornerDetect(I,Ibw,3.5,2.5,0.05,0.005); %higher

%metabolh ths tupikhs apoklishs ?
[~,~,~] = CornerDetect(I,Ibw,2,1,0.05,0.005); %lower
[~,~,~] = CornerDetect(I,Ibw,2,3,0.05,0.005); %higher

%metabolh tou k
[~,~,~] = CornerDetect(I,Ibw,2,2.5,0.01,0.005); %lower
[~,~,~] = CornerDetect(I,Ibw,2,2.5,0.09,0.005); %higher

%metabolh ths thetaCorner
[~,~,~] = CornerDetect(I,Ibw,2,2.5,0.05,0.001); %lower
[~,~,~] = CornerDetect(I,Ibw,2,2.5,0.05,0.009); %higher

%% 2.2 Polyklimakwth Anixneysh Gwniwn
N=6;    %endeiktika
s=1.5;  %endeiktika
s0 = 2; 
r0=2.5; 

%create and detect edges with various sigma values
%2.2.1
Corners=[];
for i=1:N
    sigma = s^(i-1) * s0; 
    ro = s^(i-1) * r0;
    %2.2.2
    [Corners(:,:,i),~,~,~,~]=CornerDetectNoVis(I,Ibw,sigma,ro,0.05,0.005);
    ns = ceil(3*sigma)*2+1;
    LoG = fspecial('log',ns,sigma);
    LoGI(:,:,i) = (sigma^2) * abs(imfilter(Ibw,LoG,'conv','symmetric'));
end
for i=1:N
    if i==1
        accepted(:,:,i) = (LoGI(:,:,i) >= LoGI(:,:,i+1)) & (Corners(:,:,i) == 1); 
    elseif i==N
        accepted(:,:,i) = (LoGI(:,:,i) >= LoGI(:,:,i-1)) & (Corners(:,:,i) == 1);  
    else 
        accepted(:,:,i) = (Corners(:,:,i) == 1) & (LoGI(:,:,i) >= LoGI(:,:,i-1)) & (LoGI(:,:,i) >= LoGI(:,:,i+1));
    end
end    
C=[];
for i=1:N
   [row,col] = find (accepted(:,:,i));
   S = size(row);
   mysigma=repmat(s^(i-1) * s0,[S,1]);
   C = [C;col row mysigma];   
end
interest_points_visualization(I,C);

%% 2.3 Anixneush Blobs
%klhsh BlobDetect me tis endeiktikes parametrous
BlobDetect(I,Ibw,3,0.005);


%% 2.4 Polyklimakwth Anixneysh Blobs
N=5;    %endeiktika
s=1.5;  %endeiktika
s0 = 2; 
r0=2.5; 

Blobs=[];
for i=1:N
    sigma = s^(i-1) * s0; 
    ro = s^(i-1) * r0;
    [Blobs(:,:,i)]=BlobDetectNoVis(I,Ibw,sigma,0.005);
    ns = ceil(3*sigma)*2+1;
    LoG = fspecial('log',ns,sigma);
    LoGI(:,:,i) =(sigma^2) * abs(imfilter(Ibw,LoG,'conv','symmetric'));
end
for i=1:N
    if i==1
        accepted(:,:,i) = (LoGI(:,:,i) >= LoGI(:,:,i+1)) & (Blobs(:,:,i) == 1); 
    elseif i==N
        accepted(:,:,i) = (LoGI(:,:,i) >= LoGI(:,:,i-1)) & (Blobs(:,:,i) == 1);  
    else 
        accepted(:,:,i) = (Blobs(:,:,i) == 1) & (LoGI(:,:,i) >= LoGI(:,:,i-1)) & (LoGI(:,:,i) >= LoGI(:,:,i+1));
    end
end    
C=[];
for i=1:N
   [row,col] = find (accepted(:,:,i));
   S = size(row);
   mysigma=repmat(s^(i-1) * s0,[S,1]);
   C = [C;col row mysigma];   
end
interest_points_visualization(I,C);


%% 2.5 Epitaxunsh me thn xrhsh Box Filters kai Oloklhrwtikwn Eikonwn 

thBlob = 0.005;
sigma=2;
IntegralImages(I,Ibw,sigma,thBlob,1);
sigma=3;
[~,ind]=IntegralImages(I,Ibw,sigma,thBlob,1);
figure();
imshow(ind,[]);
title('Cornerness Criterion for Boxfilters');
sigma=5;
IntegralImages(I,Ibw,sigma,thBlob,1);
sigma=9;
IntegralImages(I,Ibw,sigma,thBlob,1);

N=8; %endeiktika
s=1.5; %endeiktika
s0 =2; %s0 = 2
r0=2.5; %ro0=2.5

BlobsInt=[];
for i=1:N
    sigma = s^(i-1) * s0; 
    ro = s^(i-1) * r0;
    [BlobsInt(:,:,i),~]=IntegralImages(I,Ibw,sigma,0.005,0);
    ns = ceil(3*sigma)*2+1;
    LoG = fspecial('log',ns,sigma);
    LoGI(:,:,i) = (sigma^2)*abs(imfilter(Ibw,LoG,'conv','symmetric'));
end
for i=1:N
    if i==1
        accepted(:,:,i) = (LoGI(:,:,i) >= LoGI(:,:,i+1)) & (BlobsInt(:,:,i) == 1); 
    elseif i==N
        accepted(:,:,i) = (LoGI(:,:,i) >= LoGI(:,:,i-1)) & (BlobsInt(:,:,i) == 1);  
    else 
        accepted(:,:,i) = (BlobsInt(:,:,i) == 1) & (LoGI(:,:,i) >= LoGI(:,:,i-1)) & (LoGI(:,:,i) >= LoGI(:,:,i+1));
    end
end    
C=[];
for i=1:N
   [row,col] = find (accepted(:,:,i));
   S = size(row);
   mysigma=repmat(s^(i-1) * s0,[S,1]);
   C = [C;col row mysigma];   
end
interest_points_visualization(I,C);


