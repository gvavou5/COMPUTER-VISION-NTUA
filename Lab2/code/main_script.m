clear all; 
close all;
clc;

%% MEROS 1 : Anixneush Dermatos Xrhsth

load('skinSamplesRGB.mat');
SkinSamples = im2double(skinSamplesRGB); %converts the intensity image to double precision
figure(1);
imshow(SkinSamples,[]);
print -djpeg SkinSamples.jpg
ycbcrSample = rgb2ycbcr(SkinSamples); % go to YCBCR color space 

% upologismos 1x2 dianusmatos meshs timhs afou den mas endiaferei h plhroforia
% tou kanaliou Y ths fwteinothtas pou einai h prwth diastash tou 3d pinaka
% sample
mean_vector = [mean(mean(ycbcrSample(:,:,2))) mean(mean(ycbcrSample(:,:,3)))];	

% ypologismos tou 2x2 pinaka syndiakumanshs me xrhshs ths etoimhs
% synarthshs cov
Sarray = cov(ycbcrSample(:,:,2), ycbcrSample(:,:,3));							

% take the first frame of the video
I1 = im2double(imread(sprintf('./Chalearn/%d.png', 1)));

% euresh boundingBox 1ou frame
[x, y, width, height] = boundingBox(I1, mean_vector, Sarray);

% gia na exw kalutero kentrarisma sthn anixneysh aukswmeiwnw ta
% x,y,height,width katallhla opws fainetai parakatw
height=height+30;
width=width+30;
x = x-15;
y = y-15;

% Apeikonizw to 1o frame me thn anixneush tou xeriou 
hand_fig = figure(2); 
imshow(I1, []);
title('HandDetectFirstFrame');
hold on;
% draw a rectangular in the right position with color green
rectangle('Position', [x, y, width, height], 'EdgeColor', 'g');
hold off;
print -djpeg hand_detect_first.jpg

%% Meros 2 : Parakolou8hsh Xeriou

file_pat = './Chalearn/%d.png';
file_pat2 = './ChalearnUser/U%d.png';
save_pat1 = './results-handrec/%d.jpg';
save_pat2 = './results-opticalflow/%d-%d.jpg';
save_pat3 = './results-energy/%d-%d.jpg';

%diavasma olwn twn eikonwn se rgb kai grayscale kai twn maskwn
for i=1:61
    Irgb{i} = im2double(imread(sprintf(file_pat,i))); %eikones se rgb
	I{i} = im2double(rgb2gray(imread(sprintf(file_pat,i)))); %eikones se grayscale
	U{i} = im2double(imread(sprintf(file_pat2,i))); % maskes
end

I_init = I{1}; %1h eikona
d_0 = zeros(height+1, width+1); %arxikh timh ths proseggishs
for i=1:60
    
	I1_w = I{i}(round(y):round(y)+height,round(x):round(x)+width);
    I2_w = I{i+1}(round(y):round(y)+height,round(x):round(x)+width);
	[dx, dy] = lk(I1_w, I2_w, 8.9, 0.008, d_0, d_0);
	
	d_x_r = imresize(dx,0.3);%upodeigmatolhpsia optikhs rohs gia thn apeikonish ths
    d_y_r = imresize(dy,0.3);
	fig_flow = figure(2);
    quiver(-d_x_r, -d_y_r);
    print(fig_flow, sprintf(save_pat2, i, i+1), '-djpeg');
	
	Energy = dx.^2+dy.^2; % ypologismos energeias
    fig_ener = figure(7);
    imshow(Energy, []);   % apeikonish energeias
    print(fig_ener, sprintf(save_pat3, i, i+1), '-djpeg');
	
	[displ_x,displ_y] = displ(dx,dy); %ypologismos telikou dianismatos metatopishs
    
    %ananewsh dianusmatos 8eshs xeriou
    x = x - displ_x;             
    y = y - displ_y;
	
	fig_hand = figure(1);											
    imshow(Irgb{i+1},[]);
    hold on;
    rectangle('Position', [x, y, width, height], 'EdgeColor', 'g','Linewidth',2);
    print(fig_hand, sprintf(save_pat1, i+1), '-djpeg');
    hold off;   

end

