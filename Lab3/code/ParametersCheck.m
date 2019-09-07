clear all; close all; clc;

load('boxing.mat');
load('running.mat');
load('walking.mat');

frames = person01_boxing_d1_uncomp;
mkdir Results_Part1_person01_boxing_d1_uncomp
save_path1 = './Results_Part1_person01_boxing_d1_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person01_boxing_d1_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       %[M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       %fig_hand = figure(1);
       %showDetection(frames,C_HS,10);
       %print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       %close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,10);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end

frames = person01_walking_d2_uncomp;
mkdir Results_Part1_person01_walking_d2_uncomp
save_path1 = './Results_Part1_person01_walking_d2_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person01_walking_d2_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       [M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       fig_hand = figure(1);
       showDetection(frames,C_HS,22);
       print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,22);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end


frames = person01_running_d3_uncomp;
mkdir Results_Part1_person01_running_d3_uncomp
save_path1 = './Results_Part1_person01_running_d3_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person01_running_d3_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       [M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       fig_hand = figure(1);
       showDetection(frames,C_HS,10);
       print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,10);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end

frames = person04_running_d1_uncomp;
mkdir Results_Part1_person04_running_d1_uncomp
save_path1 = './Results_Part1_person04_running_d1_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person04_running_d1_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       [M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       fig_hand = figure(1);
       showDetection(frames,C_HS,10);
       print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,10);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end

frames = person06_boxing_d4_uncomp;
mkdir Results_Part1_person06_boxing_d4_uncomp
save_path1 = './Results_Part1_person06_boxing_d4_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person06_boxing_d4_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       [M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       fig_hand = figure(1);
       showDetection(frames,C_HS,10);
       print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,10);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end

frames = person06_walking_d3_uncomp;
mkdir Results_Part1_person06_walking_d3_uncomp
save_path1 = './Results_Part1_person06_walking_d3_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person06_walking_d3_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       [M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       fig_hand = figure(1);
       showDetection(frames,C_HS,22);
       print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,22);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end

frames = person07_running_d1_uncomp;
mkdir Results_Part1_person07_running_d1_uncomp
save_path1 = './Results_Part1_person07_running_d1_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person07_running_d1_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       [M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       fig_hand = figure(1);
       showDetection(frames,C_HS,10);
       print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,10);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end

frames = person11_walking_d2_uncomp;
mkdir Results_Part1_person11_walking_d2_uncomp
save_path1 = './Results_Part1_person11_walking_d2_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person11_walking_d2_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       [M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       fig_hand = figure(1);
       showDetection(frames,C_HS,70);
       print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,70);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end

frames = person18_boxing_d3_uncomp;
mkdir Results_Part1_person18_boxing_d3_uncomp
save_path1 = './Results_Part1_person18_boxing_d3_uncomp/Harris__%.2f__%.2f.jpg';
save_path2 = './Results_Part1_person18_boxing_d3_uncomp/Gabor__%.2f__%.2f.jpg';
%check for different values of our scales for both methods
for ind=2:0.5:5
    for t=0.5:0.4:2.5
       [M,C_HS] = Harris_Stephens(frames,ind,t,0.005,0.0005);
       fig_hand = figure(1);
       showDetection(frames,C_HS,10);
       print(fig_hand, sprintf(save_path1,ind,t), '-djpeg');
       close all;
       [H,C_G]  = Gabor_Detector(frames,ind,t,0.05);
       fig_hand = figure(1);
       showDetection(frames,C_G,10);
       print(fig_hand, sprintf(save_path2,ind,t), '-djpeg');
       close all;
    end
end
