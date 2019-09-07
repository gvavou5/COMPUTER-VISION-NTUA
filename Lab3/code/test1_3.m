clear all; close all; clc;

% to run this script you have to put it in the directory named material,
% otherwise give the right path.

% you can choose one the given videos on your own
frames = readVideo('./samples/running/person01_running_d3_uncomp.avi',200,0);
frames = im2double(frames);

%%Harris-Stephens Method for points of interest
[M,C_HS]=Harris_Stephens(frames,2,0.7,0.005,0.0005);
showDetection(frames,C_HS);

%%Gabor Method
close all;
[H,C_G]=Gabor_Detector(frames,2,1.5,0.05);
showDetection(frames,C_G);


% end of testing
