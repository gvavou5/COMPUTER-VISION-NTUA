function [lplus,lminus,R] = CornerDetect(I,Ibw,sigma,ro,k,thCorner)
%I         : original rgb image
%Ibw       : grayscaled original image 
%sigma     : tupikh apoklish(klimaka diaforishs)
%ro        : klimaka oloklhrwshs
%k         : mikrh 8etikh sta8era
%thCorner  : katwfli(threshold)

ns=ceil(3*sigma)*2+1;
nr=ceil(3*ro)*2+1;
B_sq = strel('disk',ns);

%% 2.1.1 : Ypologismos J1,J2,J3
Gs = fspecial('gaussian',ns,sigma);
Gr = fspecial('gaussian',nr,ro);
Is = imfilter(Ibw,Gs,'conv','symmetric');
[Idx,Idy] = gradient(Is);
J1 = Idx.^2;
J1 = imfilter(J1,Gr,'conv','symmetric');
J2 = Idx.*Idy;
J2 = imfilter(J2,Gr,'conv','symmetric');
J3 = Idy.^2;
J3 = imfilter(J3,Gr,'conv','symmetric');

%% 2.1.2 : Ypologismos l+,l-
lplus = 0.5*(J1+J3+sqrt((J1-J3).^2+4*J2.^2));
lminus = 0.5*(J1+J3-sqrt((J1-J3).^2+4*J2.^2));

%% 2.1.3 : Ypologismos R , Krithriou gwniothtas
R = lplus.*lminus-k*((lminus+lplus).^2);
figure();
imshow(R,[]);
title('Cornerness Criterion');
print -djpeg CornernessCriterion.jpeg
%synthiki 1
Cond1 = ( R==imdilate(R,B_sq) );
Rmax = max(max(max(R)));
%synthiki 2
Cond2 = (R > thCorner*Rmax);
Corners = Cond1 & Cond2;
[col,row] = find(Corners);
S=size(row);
mysigma=repmat(sigma,[S,1]);
C=[row col mysigma];
interest_points_visualization(I,C);

end


