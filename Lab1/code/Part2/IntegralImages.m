function [ IntBlobs, R] = IntegralImages(I,J,sigma,thBlob,vis)
    %Calculation Integral Image
    IntI = cumsum(J);
    IntI = cumsum(IntI,2);
    n=2*ceil(3*sigma)+1;
    dimH=4*floor(n/6)+1;
    dimL=2*floor(n/6)+1;
    %thelw to dimH na einai pollaplasio tou 3 kai malista me peritto
    %syntelesth
    %proteinetai edw: (gia na efarmozontai aneta ta box filters me ton
    %tropo pou didontai sthn ekfwnhsh)
    %http://dsp.stackexchange.com/questions/13577/understanding-surf-features-calculation-process
    
    if (mod(dimH,3)==1)
        dimH=dimH+2;
            if (mod(dimH,2)==0)
                dimH=dimH+3;
            end
    elseif (mod(dimH,3)==2)
        dimH= dimH+1;
            if (mod(dimH,2)==0)
                dimH=dimH+3;
            end
    end
    
    black = dimH/3;
    %Apply the necessary padding to my image
    IntIpad = padarray(IntI,[3*dimL 3*dimL],'replicate');
    %Lxx
    %arxika tha ypologisoume me circ_shifts to a8roisma olou tou 
    %box (kai aytou me syntelesth -2)
    %kai sth synexeia 8a afairesoume pali me circ_shifts 3 fores to 
    %tmhma tou filtrou pou exei syntelesth -2
    %wste kathe pixel na exei th swsth timh tou
    sh_x=[+(dimH-1)/2 -(dimH-1)/2 +(dimH-1)/2 -(dimH-1)/2];
    sh_y=[+(dimL-1)/2 +(dimL-1)/2 -(dimL-1)/2 -(dimL-1)/2];            
    for i=1:4
         if i==1
             Lxx=circshift(IntIpad,[sh_x(i) sh_y(i)]);
         elseif i==4
             Lxx=Lxx+circshift(IntIpad,[sh_x(i) sh_y(i)]);
         else
             Lxx=Lxx-circshift(IntIpad,[sh_x(i) sh_y(i)]);
         end
    end
    
    sh_x=[+(black-1)/2 -(black-1)/2 +(black-1)/2 -(black-1)/2];
    sh_y=[+(dimL-1)/2 +(dimL-1)/2 -(dimL-1)/2 -(dimL-1)/2];
    
    for i=1:4
        if i==1 | i==4
            Lxx=Lxx-3*circshift(IntIpad,[sh_x(i) sh_y(i)]);
        else
            Lxx=Lxx+3*circshift(IntIpad,[sh_x(i) sh_y(i)]);
        end       
    end
    
    
    %omoiws twra gia to Lyy    
    %Lyy
    sh_x=[+(dimL-1)/2 -(dimL-1)/2 +(dimL-1)/2 -(dimL-1)/2];
    sh_y=[+(dimH-1)/2 +(dimH-1)/2 -(dimH-1)/2 -(dimH-1)/2];            
    for i=1:4
         if i==1
             Lyy=circshift(IntIpad,[sh_x(i) sh_y(i)]);
         elseif i==4
             Lyy=Lyy+circshift(IntIpad,[sh_x(i) sh_y(i)]);
         else
             Lyy=Lyy-circshift(IntIpad,[sh_x(i) sh_y(i)]);
         end
    end
    
    sh_y=[+(black-1)/2 -(black-1)/2 +(black-1)/2 -(black-1)/2];
    sh_x=[+(dimL-1)/2 +(dimL-1)/2 -(dimL-1)/2 -(dimL-1)/2];
    
    for i=1:4
        if i==1 | i==4
            Lyy=Lyy-3*circshift(IntIpad,[sh_x(i) sh_y(i)]);
        else
            Lyy=Lyy+3*circshift(IntIpad,[sh_x(i) sh_y(i)]);
        end       
    end
    
    
    %Lxy
    sh_x=[-dimL -dimL -dimL -dimL;-1 -1 -1 -1;+1 +1 +1 +1;+dimL +dimL +dimL +dimL];
    sh_y=[-dimL -1 +1 +dimL;-dimL -1 +1 +dimL;-dimL -1 +1 +dimL;-dimL -1 +1 +dimL];
    %take all the critical points starting from
    %up-left going to down-right row by row    
    for i=1:4
        for j=1:4
            if (i==1 & j==1)
                Lxy=circshift(IntIpad,[sh_x(i,j) sh_y(i,j)]);
            elseif (i==1 | i==4)
                if (j==1 | j==4)
                    Lxy=Lxy+circshift(IntIpad,[sh_x(i,j) sh_y(i,j)]);
                else
                    Lxy=Lxy-circshift(IntIpad,[sh_x(i,j) sh_y(i,j)]);
                end
            else
                if (j==2 | j==3)
                    Lxy=Lxy+circshift(IntIpad,[sh_x(i,j) sh_y(i,j)]);
                else
                    Lxy=Lxy-circshift(IntIpad,[sh_x(i,j) sh_y(i,j)]);
                end
            end  
        end
    end
Lxx = Lxx(3*dimL+1:3*dimL+size(IntI,1),3*dimL+1:3*dimL+size(IntI,2));
Lyy = Lyy(3*dimL+1:3*dimL+size(IntI,1),3*dimL+1:3*dimL+size(IntI,2));
Lxy = Lxy(3*dimL+1:3*dimL+size(IntI,1),3*dimL+1:3*dimL+size(IntI,2));
ns = 2*ceil(3*sigma)+1;
B_sq = strel('disk', ns); 
R = Lxx.*Lyy-(0.9*Lxy).^2;
Rmax = max(max(max(R)));

Cond1 = ( R==imdilate(R,B_sq) );
Cond2 = (R > thBlob*Rmax);
IntBlobs = Cond1 & Cond2;
[row,col] = find(IntBlobs);
S=size(row);
mysigma=repmat(sigma,[S,1]);
C=[col row mysigma];
if vis==1
    interest_points_visualization(I,C);
end
    
end

