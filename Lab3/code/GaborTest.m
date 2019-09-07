clear all; close all; clc;

load('boxing.mat');
load('running.mat');
load('walking.mat');

mkdir person01_boxing_d1_uncomp ;
frames = person01_boxing_d1_uncomp;
[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person01_boxing_d1_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person01_boxing_d1_uncomp;
print -djpeg s-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person01_boxing_d1_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person01_boxing_d1_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person01_boxing_d1_uncomp;
print -djpeg t+.jpg
cd ../

%%%%%%%%%

mkdir person01_running_d3_uncomp ;
frames = person01_running_d3_uncomp;
[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person01_running_d3_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person01_running_d3_uncomp;
print -djpeg s-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person01_running_d3_uncomp;
print -djpeg s+.jpg
cd ../


[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person01_running_d3_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person01_running_d3_uncomp;
print -djpeg t+.jpg
cd ../

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mkdir person01_walking_d2_uncomp ;
frames = person01_walking_d2_uncomp;

[H,C_G]  = Gabor_Detector(frames,2,1.6,0.05);
showDetection(frames,C_G,55);
cd person01_walking_d2_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.6,0.05);
showDetection(frames,C_G,55);
cd person01_walking_d2_uncomp;
print -djpeg s-.jpg
cd ../


[H,C_G]  = Gabor_Detector(frames,3,1.6,0.05);
showDetection(frames,C_G,55);
cd person01_walking_d2_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,55);
cd person01_walking_d2_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,55);
cd person01_walking_d2_uncomp;
print -djpeg t+.jpg
cd ../

%%%%%%%%%%

mkdir person06_boxing_d4_uncomp ;
frames = person06_boxing_d4_uncomp;

[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg s-.jpg
cd ../


[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg t+.jpg
cd ../


%%%%%%%%%%%%%%%%%%

mkdir person06_boxing_d4_uncomp ;
frames = person06_boxing_d4_uncomp;

[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg s-.jpg
cd ../


[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person06_boxing_d4_uncomp;
print -djpeg t+.jpg
cd ../


%%%%%%%%%%%%%%%%%%



mkdir person04_running_d1_uncomp ;
frames = person04_running_d1_uncomp;

[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person04_running_d1_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person04_running_d1_uncomp;
print -djpeg s-.jpg
cd ../


[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person04_running_d1_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person04_running_d1_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person04_running_d1_uncomp;
print -djpeg t+.jpg
cd ../

%%%%%%%%%%%%

mkdir person06_walking_d3_uncomp ;
frames = person06_walking_d3_uncomp;

[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_walking_d3_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_walking_d3_uncomp;
print -djpeg s-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person06_walking_d3_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person06_walking_d3_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person06_walking_d3_uncomp;
print -djpeg t+.jpg
cd ../


%%%%%%%

mkdir person11_walking_d2_uncomp ;
frames = person11_walking_d2_uncomp;

[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person11_walking_d2_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person11_walking_d2_uncomp;
print -djpeg s-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person11_walking_d2_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person11_walking_d2_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person11_walking_d2_uncomp;
print -djpeg t+.jpg
cd ../

%%%%%%%%%


mkdir person18_boxing_d3_uncomp;
frames = person18_boxing_d3_uncomp;

[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person18_boxing_d3_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person18_boxing_d3_uncomp;
print -djpeg s-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person18_boxing_d3_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person18_boxing_d3_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person18_boxing_d3_uncomp;
print -djpeg t+.jpg
cd ../

%%%%%%%%%%  

mkdir person07_running_d1_uncomp;
frames = person07_running_d1_uncomp;

[H,C_G]  = Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G,15);
cd person07_running_d1_uncomp;
print -djpeg good.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,1,1.5,0.05);
showDetection(frames,C_G,15);
cd person07_running_d1_uncomp;
print -djpeg s-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,3,1.5,0.05);
showDetection(frames,C_G,15);
cd person07_running_d1_uncomp;
print -djpeg s+.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,1,0.05);
showDetection(frames,C_G,15);
cd person07_running_d1_uncomp;
print -djpeg t-.jpg
cd ../

[H,C_G]  = Gabor_Detector(frames,2,2,0.05);
showDetection(frames,C_G,15);
cd person07_running_d1_uncomp;
print -djpeg t+.jpg
cd ../


