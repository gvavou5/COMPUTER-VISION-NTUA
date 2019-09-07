%%Meros 1
clear all;
close all;
clc;
disp('start')
%read my videos
video=cell(9,1);
video{1,1} = readVideo('./samples/boxing/person01_boxing_d1_uncomp.avi',200,0);
video{2,1} = readVideo('./samples/boxing/person06_boxing_d4_uncomp.avi',200,0);
video{3,1} = readVideo('./samples/boxing/person18_boxing_d3_uncomp.avi',200,0);
video{4,1} = readVideo('./samples/running/person01_running_d3_uncomp.avi',200,0);
video{5,1} = readVideo('./samples/running/person04_running_d1_uncomp.avi',200,0);
video{6,1} = readVideo('./samples/running/person07_running_d1_uncomp.avi',200,0);
video{7,1} = readVideo('./samples/walking/person01_walking_d2_uncomp.avi',200,0);
video{8,1} = readVideo('./samples/walking/person06_walking_d3_uncomp.avi',200,0);
video{9,1} = readVideo('./samples/walking/person11_walking_d2_uncomp.avi',200,0);

%%Harris-Stephens Method for points of interest
close all;
space_scale_HS = 2;
time_scale_HS = 0.7;
k_HS = 0.005;
threshold_percentage_HS = 0.0005;
C_HS_global = cell(9,1);
for i=1:9
    frames=video{i,1};
    frames=im2double(frames);
    [M,C_HS]=Harris_Stephens(frames,space_scale_HS,time_scale_HS,k_HS,threshold_percentage_HS);
    %showDetection(frames,C_HS);
    C_HS_global{i,1}=C_HS;
end
%disp('telos o Harris')

%%Gabor method
close all;
space_scale_Gabor = 2;
time_scale_Gabor = 1.5;
threshold_percentage_Gabor = 0.05;%0.05
C_G_global = cell(9,1);

for i=1:9
    frames=video{i,1};
    frames=im2double(frames);
    [H,C_G]=Gabor_Detector(frames,space_scale_Gabor,time_scale_Gabor,threshold_percentage_Gabor);
    %showDetection(frames,C_G);
    C_G_global{i,1}=C_G;
end
%disp('telos o Gabor')

%%Part 2.1
%calculation of gradient and optical flow
%we will hold gradient and optical flow 
%of every frame in two separate cell arrays
%this procedure takes some time though
Grad_global = cell(9,1);
Opt_global = cell(9,1); 
desc_G_gr_global=cell(9,1); 
desc_G_opt_global=cell(9,1); 
desc_HS_gr_global=cell(9,1); 
desc_HS_opt_global=cell(9,1); 
%disp('mphka stous descriptors')
for j=1:9
    frames=video{j,1};
    frames=im2double(frames);
    Opt = cell(200,2);
    Grad = cell(200,2);
    d_0 = zeros(size(frames(:,:,1),1), size(frames(:,:,1),2)); %arxikh timh ths proseggishs
    for i=1:(size(frames,3)-1)
        [dx,dy]=lk(frames(:,:,i),frames(:,:,i+1),8,0.008,d_0,d_0);
        Opt{i,1}=dx;
        Opt{i,2}=dy;
        [Ix,Iy] = imgradient(frames(:,:,i));
        Grad{i,1} = Ix;
        Grad{i,2} = Iy;
    end
    [Ix,Iy] = imgradient(frames(:,:,size(frames,3)));
    Grad{size(frames,3),1} = Ix;
    Grad{size(frames,3),2} = Iy;
    [desc_G_gr,desc_G_opt]=Descriptors(C_G_global{j,1},space_scale_Gabor,Grad,Opt,size(frames(:,:,1),2),size(frames(:,:,1),1),size(frames,3));
    [desc_HS_gr,desc_HS_opt]=Descriptors(C_HS_global{j,1},space_scale_HS,Grad,Opt,size(frames(:,:,1),2),size(frames(:,:,1),1),size(frames,3));
    desc_G_gr_global{j,1}=desc_G_gr;
    desc_G_opt_global{j,1}=desc_G_opt;
    desc_HS_gr_global{j,1}=desc_HS_gr;
    desc_HS_opt_global{j,1}=desc_HS_opt;
end    

%%2.3BAG OF VISUAL WORDS CREATION
data_train=cell(1,9);
for i=1:9
    A = cell2mat(desc_HS_gr_global{i,1});
    data_train_HS_HOG{1,i} = A;
    A = cell2mat(desc_HS_opt_global{i,1});
    data_train_HS_HOF{1,i} = A;
    A = cell2mat(desc_G_gr_global{i,1});
    data_train_G_HOG{1,i} = A;
    A = cell2mat(desc_G_opt_global{i,1});
    data_train_G_HOF{1,i} = A;
    A = [cell2mat(desc_G_gr_global{i,1});cell2mat(desc_HS_opt_global{i,1})];
    data_train_G_HOG_HOF{1,i} = A;
    A = [cell2mat(desc_HS_gr_global{i,1});cell2mat(desc_HS_opt_global{i,1})];
    data_train_HS_HOG_HOF{1,i} = A;
end
data_label = [1;1;1;2;2;2;3;3;3];

[BOF_tr_HS_HOG] = MyBagOfWords(data_train_HS_HOG);
[BOF_tr_HS_HOF] = MyBagOfWords(data_train_HS_HOF);
[BOF_tr_G_HOG] = MyBagOfWords(data_train_G_HOG);
[BOF_tr_G_HOF] = MyBagOfWords(data_train_G_HOF);
[BOF_tr_HS_HOG_HOF] = MyBagOfWords(data_train_HS_HOG_HOF);
[BOF_tr_G_HOG_HOF] = MyBagOfWords(data_train_G_HOG_HOF);

link_HS_HOG = linkage(BOF_tr_HS_HOG,'centroid','@distChiSq');
link_HS_HOF = linkage(BOF_tr_HS_HOF,'centroid','@distChiSq');
link_G_HOG = linkage(BOF_tr_G_HOG,'centroid','@distChiSq');
link_G_HOF = linkage(BOF_tr_G_HOF,'centroid','@distChiSq');
link_HS_HOG_HOF = linkage(BOF_tr_HS_HOG_HOF,'centroid','@distChiSq');
link_G_HOG_HOF = linkage(BOF_tr_G_HOG_HOF,'centroid','@distChiSq');
disp('now the dendrograms will be presented')
figure();
dendrogram(link_HS_HOG);
title('HS-HOG');
figure();
dendrogram(link_HS_HOF);
title('HS-HOF');
figure();
dendrogram(link_G_HOG);
title('G-HOG');
figure();
dendrogram(link_G_HOF);
title('G-HOF');
figure();
dendrogram(link_HS_HOG_HOF);
title('HS-HOG-HOF');
figure();
dendrogram(link_G_HOG_HOF);
title('G-HOG-HOF');