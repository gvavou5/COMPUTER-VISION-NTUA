function [ d_x , d_y ] = lk_ms( I1 , I2 , rho , epsilon , scales )
    %calculation of my pyramids 
    I1pyr = cell(1, scales); 
    I2pyr = cell(1, scales); 
    I1pyr{1}=I1;
    I2pyr{1}=I2;                                
    for i=2:scales
        %filtrarisma eikonas me va8yperato filtro
        %gaussian me typikh apoklish 3 prin thn ypodeigmatolhpsia
        I1pyr{i}=impyramid(imgaussfilt(I1pyr{i-1},3),'reduce');
        I2pyr{i}=impyramid(imgaussfilt(I2pyr{i-1},3),'reduce');
    end
    
    d_x_i = zeros(size(I1pyr{scales},1),size(I1pyr{scales},2)); 
    d_y_i = zeros(size(I1pyr{scales},1),size(I1pyr{scales},2));
    for i=scales:-1:1
        [d_x,d_y]= lk(I1pyr{i}, I2pyr{i}, rho, epsilon , d_x_i,d_y_i);
        if (i~=1)
            %katallhlo resizing
            d_x_i = 2*imresize(d_x,[size(I1pyr{i-1},1),size(I1pyr{i-1},2)]);
            d_y_i = 2*imresize(d_y,[size(I1pyr{i-1},1),size(I1pyr{i-1},2)]);
        end
    end
    
    d_x = d_x_i;
    d_y = d_y_i;
    
end

