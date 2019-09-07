%{
    Auto to script exei san skopo na parei eksetasei thn epidrash twn parametrwn
    r kai e sto apotelesma pou dinoyn. Mas dinei 4 grafikes(tis apo8hkeuei se katallhlo directory)
    oi opoies auto pou deixnoun einai thn epidrash twn parametrwn autwn sthn anixneysh mas. Oi arxikes
    grafikes pou dinei einai idies me autes pou mas dinei kai to main_script kai
    tis afhsa apla gia na uparxoun.
%}


clear all;
close all;
clc;

load('skinSamplesRGB.mat');
SkinSamples = im2double(skinSamplesRGB); 
ycbcrSample = rgb2ycbcr(SkinSamples);  

mean_vector = [mean(mean(ycbcrSample(:,:,2))) mean(mean(ycbcrSample(:,:,3)))];	

Sarray = cov(ycbcrSample(:,:,2), ycbcrSample(:,:,3));							

I1 = im2double(imread(sprintf('./Chalearn/%d.png', 1)));

[x, y, width, height] = boundingBox(I1, mean_vector, Sarray);

mkdir ParametersEffects;

height=height+30;
width=width+30;
x = x-15;
y = y-15;
file_pat = './Chalearn/%d.png';


for i=1:61
	I{i} = im2double(rgb2gray(imread(sprintf(file_pat,i)))); %eikones se grayscale
end

d_0 = zeros(height+1, width+1); 
    
I1_w = I{1}(round(y):round(y)+height,round(x):round(x)+width);
I2_w = I{2}(round(y):round(y)+height,round(x):round(x)+width);

[dx, dy] = lk(I1_w, I2_w, 2.5, 0.008, d_0, d_0);
d_x_r = imresize(dx,0.3);
d_y_r = imresize(dy,0.3);
fig_flow = figure(2);
quiver(-d_x_r, -d_y_r);
cd ParametersEffects/;
title('Lower R');
print -djpeg Lower_R.jpg;
cd ../

[dx, dy] = lk(I1_w, I2_w, 14.5, 0.008, d_0, d_0);
d_x_r = imresize(dx,0.3);
d_y_r = imresize(dy,0.3);
fig_flow = figure(2);
quiver(-d_x_r, -d_y_r);
cd ParametersEffects/;
title('Higher R');
print -djpeg Higher_R.jpg;
cd ../

[dx, dy] = lk(I1_w, I2_w, 8.9, 0.0008, d_0, d_0);
d_x_r = imresize(dx,0.3);
d_y_r = imresize(dy,0.3);
fig_flow = figure(2);
quiver(-d_x_r, -d_y_r);
cd ParametersEffects/;
title('Lower e');
print -djpeg Lower_e.jpg;
cd ../

[dx, dy] = lk(I1_w, I2_w, 8.9, 0.08, d_0, d_0);
d_x_r = imresize(dx,0.3);
d_y_r = imresize(dy,0.3);
fig_flow = figure(2);
quiver(-d_x_r, -d_y_r);
cd ParametersEffects/;
title('Higher e');
print -djpeg Higher_e.jpg;
cd ../

