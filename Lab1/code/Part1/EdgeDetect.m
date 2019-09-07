function D = EdgeDetect(I,sn,ThetaEdge,LaplacType)
% sn : variance
% I : original image
% theta : a given parameter
% LaplacType : 0-->(linear) or 1--->(non-linear)  
% D : The outpout of this function is the edges of the input image
n=2*ceil(3*sn) + 1;
B = strel('disk',1);
Gaussian = fspecial('Gaussian',n,sn);
LOG = fspecial('log',n, sn);
Ismooth = imfilter(I,Gaussian,'symmetric','conv');

if (LaplacType == 0)
    % linear
    L = imfilter(I,LOG,'symmetric','conv');
elseif (LaplacType == 1)
    % non linear
    L = imdilate(Ismooth,B) + imerode(Ismooth,B) - 2*Ismooth;
else
end
%zero-crossings
X = (L >= 0);
Y = imdilate(X,B) - imerode(X,B);  %proseggish paragwgou
[gradient_x, gradient_y] = gradient(Ismooth);%gradient is a 2dim array, not a vector
norm = sqrt(gradient_x.^2 + gradient_y.^2);  %euresh klishs 
max_of_norm = max(max(norm));
D = ((Y == 1) & (norm > ThetaEdge*max_of_norm));
end


