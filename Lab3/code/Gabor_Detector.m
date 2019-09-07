function [ H,C ] = Gabor_Detector( frames,sigma,taf,thCorner )
%filter with 2d gaussian in space for smoothing
ns=ceil(3*sigma)*2+1;
Gs = fspecial('gaussian',ns,sigma);
frames = imfilter(frames,Gs,'conv','replicate');
%construct our gabor filters
t_norm=ceil(taf);

wmega = 4/taf;
%take the ceil of 2*t to crate the dimensions of our window
nt = ceil(2*taf);
t = linspace(-nt,nt,2*nt+1);
%our filter should be at the third dimension -> time

h_ev_for_norm = -1*cos(2*pi*t*wmega).*exp((-1*t.^2)/(2*taf^2));
h_od_for_norm = -1*sin(2*pi*t*wmega).*exp((-1*t.^2)/(2*taf^2)); 
L1_h_ev = norm(h_ev_for_norm,1);
L1_h_od = norm(h_od_for_norm,1);
%figure(1);
%plot(h_ev_for_norm/L1_h_ev);
%sum(h_ev_for_norm/L1_h_ev)
%figure(2);
%plot(h_od_for_norm/L1_h_od);
h_ev(1,1,:)=(-1*cos(2*pi*t*wmega).*exp((-1*t.^2)/(2*taf^2)))/L1_h_ev;
h_od(1,1,:)=(-1*sin(2*pi*t*wmega).*exp((-1*t.^2)/(2*taf^2)))/L1_h_od;

H1 = imfilter(frames,h_ev,'conv','replicate');
H2 = imfilter(frames,h_od,'conv','replicate');
H = H1.^2 + H2.^2;
maxH = max(max(max(H)));

%%local maxima
B_sq = strel('sphere',2);
Cond1 = (H == imdilate(H, B_sq));
Cond2 = (H > maxH*thCorner);
CondTotal = Cond1 & Cond2;
H=H.*CondTotal; %hold only local maxima above a threshold

[sortedValues,sortIndex] = sort(H(:),'descend'); 
if (sum(sum(sum(CondTotal)))<600)
    maxValues = sortedValues(1:sum(sum(sum(CondTotal))));  %# Get all the largest values
else
    maxValues = sortedValues(1:600); %or 600 largest values
end
maxIndex = ismember(H,maxValues);     %# Get a logical index of all values
[row , col , fr] = ind2sub(size(maxIndex),find(maxIndex));
S=size(row);
myro=repmat(sigma,[S,1]);
C=[col row myro fr];

end

