function [d_x,d_y] = lk(I1,I2,rho,epsilon,d_x0,d_y0)
%Lucas-Kanade algorithm
%Authors : Dimitrios Stavrakakis-Georgios Vavouliotis

%ypologismos plegmatos + merikwn paragwgwn ths I(n-1)
[x_0,y_0] = meshgrid(1:size(I1,2),1:size(I1,1));
[Idx,Idy] = imgradientxy(I1);

%dhmiourgia ths Gp (synarthsh parathyrwshs)
nr = ceil(3*rho)*2+1;
Gp = fspecial('gaussian',nr,rho);

%arxikopoihsh apotelesmatos
dx_i = d_x0;
dy_i = d_y0;

%epanalhpseis ews th sygklish vazoume megalo arithmo gia na eimaste
%sigouroi kai kanoume tis prakseis pinakwn grhgora wste na mh mas trwei
%poly xrono
for i=1:80
     
     % xrhsimopoiw thn interp2 opws leei h ekfwnhsh  
     I_inter  = interp2(I1,x_0+dx_i,y_0+dy_i,'linear',0);
     I_xinter = interp2(Idx,x_0+dx_i,y_0+dy_i,'linear',0);
     I_yinter = interp2(Idy,x_0+dx_i,y_0+dy_i,'linear',0);
     
     E_x = I2 - I_inter; %E(x) = In - In-1(x+di)
     
     A1=I_xinter;
     A2=I_yinter;
     
     %ypologismos tou u
     array1_11 = imfilter(A1.^2,Gp,'symmetric','conv')+epsilon; 
     array1_12 = imfilter(A1.*A2,Gp,'symmetric','conv');
     array1_21 = imfilter(A1.*A2,Gp,'symmetric','conv');
     array1_22 = imfilter(A2.^2,Gp,'symmetric','conv')+epsilon;
     
     array2_1  = imfilter(A1.*E_x,Gp,'conv','symmetric');
     array2_2  = imfilter(A2.*E_x,Gp,'conv','symmetric');
         
     %eyresh antistrofoy 1ou pinaka
     %1/det * [a22,-a21 ; -a12,a11]
     det = array1_11 .* array1_22 - array1_12 .* array1_21 ; %se ka8e 8esh vrisketai h antistoixh orizousa
     ux = (array1_22 .* array2_1 - array1_21 .* array2_2 )./det;
     uy = (-array1_12 .* array2_1 + array1_11 .* array2_2 )./det;
     
     dx_i = dx_i + ux;   
     dy_i = dy_i + uy;
    
end
d_x= dx_i;
d_y= dy_i;


end

