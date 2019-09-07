function [ desc_gr,desc_opt ] = Descriptors( C,scale,Grad,Opt,height,width,length )
%4xscale windows -> central pixel is our interest point and we create a
%square around it 4xscale X 4xscale 
nbins = 8;
desc_opt = cell(size(C,1)-sum(C(:,4)==200),1);
desc_gr = cell(size(C,1),1);
n=4;
m=4;
k = 0; %interest points on the last frame dont have optical flow
%we assign optical flow i->i+1 frame to {i}  
for i=1:size(C,1)    
    if (C(i,1)-ceil(2*scale)>0 && C(i,1)+ceil(2*scale)<=height && C(i,2)-ceil(2*scale)>0 && C(i,2)+ceil(2*scale)<=width)
        Gx = Grad{C(i,4),1}(C(i,2)-ceil(2*scale):C(i,2)+ceil(2*scale),C(i,1)-ceil(2*scale):C(i,1)+ceil(2*scale));
        Gy = Grad{C(i,4),2}(C(i,2)-ceil(2*scale):C(i,2)+ceil(2*scale),C(i,1)-ceil(2*scale):C(i,1)+ceil(2*scale));
        desc_gr{i,1} = OrientationHistogram(Gx,Gy,nbins,[n m],0,0);
        
        if (C(i,4)~=length)
            Gx = Opt{C(i,4),1}(C(i,2)-ceil(2*scale):C(i,2)+ceil(2*scale),C(i,1)-ceil(2*scale):C(i,1)+ceil(2*scale));
            Gy = Opt{C(i,4),2}(C(i,2)-ceil(2*scale):C(i,2)+ceil(2*scale),C(i,1)-ceil(2*scale):C(i,1)+ceil(2*scale));
            desc_opt{i-k,1} = OrientationHistogram(Gx,Gy,nbins,[n m],0,0);
            k=0;
        else
            k = k+1;
        end
        
    else
            dim1 = C(i,2)-ceil(2*scale):C(i,2)+ceil(2*scale);
            dim2 = C(i,1)-ceil(2*scale):C(i,1)+ceil(2*scale);
            if (C(i,2)-ceil(2*scale)<=0)
                dim1=(1:ceil(2*scale));
            end
            if (C(i,1)-ceil(2*scale)<=0)
                dim2=(1:ceil(2*scale));
            end
            if (C(i,2)+ceil(2*scale)>120)
                dim1=(120-ceil(2*scale):120);
            end
            if (C(i,1)+ceil(2*scale)>160)
                dim2=(160-ceil(2*scale):160);
            end
            Gx = Grad{C(i,4),1}(dim1,dim2);
            Gy = Grad{C(i,4),2}(dim1,dim2);
            desc_gr{i,1} = OrientationHistogram(Gx,Gy,nbins,[n m],0,0);
            
            if (C(i,4)~=length)
                Gx = Opt{C(i,4),1}(dim1,dim2);
                Gy = Opt{C(i,4),2}(dim1,dim2);
                desc_opt{i-k,1} = OrientationHistogram(Gx,Gy,nbins,[n m],0,0);
                k=0;
            else
                k=k+1;
            end
            
    end      
end


end

