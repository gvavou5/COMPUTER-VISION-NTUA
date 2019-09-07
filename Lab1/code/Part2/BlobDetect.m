function [] = BlobDetect(I,Ibw,sigma,thBlob)
%I         : original rgb image
%Ibw       : grayscaled original image 
%sigma     : tupikh apoklish(klimaka diaforishs)
%thBlob    : katwfli(threshold)

ns=ceil(3*sigma)*2+1;
B_sq = strel('disk',ns);

Gs = fspecial('gaussian',ns,sigma);
Is = imfilter(Ibw,Gs,'conv','symmetric');

[Fx1,Fy1] = gradient(Is);
[Fx2,Fy2] = gradient(Fx1);
[Fx3,Fy3] = gradient(Fy1);

Lxx = Fx2;
Lxy = Fy2;
Lyy = Fy3;

R = Lxx.*Lyy - Lxy.^2;
Rmax = max(max(max(R)));

figure();
imshow(R,[]);
title('Cornerness Criterion for BlobDetect');
print -djpeg CornernessCriterionBlobDetect.jpeg

Cond1 = ( R==imdilate(R,B_sq) );
Cond2 = (R > thBlob*Rmax);
Blobs = Cond1 & Cond2;
[row,col] = find(Blobs);
S=size(row);
mysigma=repmat(sigma,[S,1]);
C=[col row mysigma];
interest_points_visualization(I,C);

end

