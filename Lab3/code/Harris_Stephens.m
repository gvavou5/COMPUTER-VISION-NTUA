function [  H,C] = Harris_Stephens( frames,sigma,taf,k,thCorner )
%calculation of derivatives
kernelX = [-1,0,1];
framesX = imfilter(frames,kernelX,'symmetric');
%figure();
%imshow(framesX(:,:,1),[]);
kernelY = kernelX';
framesY = imfilter(frames,kernelY,'symmetric');
%figure();
%imshow(framesY(:,:,1),[]);
kernelT = zeros(1,1,3);
kernelT(1,1,1) = -1;
kernelT(1,1,2) = 0;
kernelT(1,1,3) = 1;
framesT = imfilter(frames,kernelT,'symmetric');
%[framesX, framesY, framesT] = gradient(frames);
Ix2 = framesX.*framesX;
Iy2 = framesY.*framesY;
It2 = framesT.*framesT;
Ixy = framesX.*framesY;
Ixt = framesX.*framesT;
Iyt = framesY.*framesT;

%ro = 2; 
ns=ceil(3*sigma)*2+1;
Gs = fspecial('gaussian',ns,sigma);

%apply 2d filter first
Ix2 = imfilter(Ix2,Gs,'conv','symmetric');
Iy2 = imfilter(Iy2,Gs,'conv','symmetric');
It2 = imfilter(It2,Gs,'conv','symmetric');
Ixy = imfilter(Ixy,Gs,'conv','symmetric');
Ixt = imfilter(Ixt,Gs,'conv','symmetric');
Iyt = imfilter(Iyt,Gs,'conv','symmetric');
%apply 1d gaussian for the t-space
%first create the 1d gaussian

%taf = 2; %%%%%%%%%
nt=ceil(3*taf)*2+1;
G1 = zeros(1,1,nt);
G1(1,1,:) = fspecial('gaussian',[1 nt],taf);

Ix2 = imfilter(Ix2,G1,'conv','symmetric');
Iy2 = imfilter(Iy2,G1,'conv','symmetric');
It2 = imfilter(It2,G1,'conv','symmetric');
Ixy = imfilter(Ixy,G1,'conv','symmetric');
Ixt = imfilter(Ixt,G1,'conv','symmetric');
Iyt = imfilter(Iyt,G1,'conv','symmetric');

%now we have to calculate the det for each matrix of each voxel
%to have our final formula for our criteria
H = abs(Ix2.*(Iy2.*It2 - Iyt.*Iyt) - Ixy.*(Ixy.*It2 - Iyt.*Ixt) + Ixt.*(Ixy.*Iyt - Ixt.*Iy2)-k*((Ix2.*Iy2.*It2).^3));
%B_sq = strel('disk',nr);
maxH = max(max(max(H)));

%check for local maximum and the value to be above the threshold
B_sq = strel('sphere',2);
Cond1 = (H == imdilate(H, B_sq));
Cond2 = (H > maxH*thCorner);
CondTotal = Cond1 & Cond2;
H=H.*CondTotal; %hold only local maxima

[sortedValues,sortIndex] = sort(H(:),'descend'); 
if (sum(sum(sum(CondTotal)))<600)
    maxValues = sortedValues(1:sum(sum(sum(CondTotal))));  %# Get all largest values
else
    maxValues = sortedValues(1:600); %Get 600 largestvalues
end
maxIndex = ismember(H,maxValues);     %# Get a logical index of all values
[row , col , fr] = ind2sub(size(maxIndex),find(maxIndex));
S=size(row);
myro=repmat(sigma,[S,1]);
C=[col row myro fr];
end

