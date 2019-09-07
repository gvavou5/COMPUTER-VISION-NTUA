function [x, y, width, height] = boundingBox(I, mean, s)
    I = rgb2ycbcr(I);
    cb = I(:,:,2);	% krataw to kanali Cb
    cr = I(:,:,3);  % krataw to kanali Cr
    % o pinakas C exei to Cb Cr(ta pixels aytwn) kata grammh
    C(:, 1) = reshape(cb, [480*640 1]);	
    C(:, 2) = reshape(cr, [480*640 1]);		
    
    %% Ypologismos Gaussian
    % Apeikonihs Gaussian gia entopismo dermatos
    GaussianSkin = zeros(100);
    u = linspace(0.34, 0.85, 100); % grammikos xwros gia thn apeikonish
    v = linspace(0.2, 0.8, 100);   % grammikos xwros gia thn apeikonish
    for i = 1:100
        for j = 1:100
            GaussianSkin(i, j) = exp(-0.5 * ([v(i) u(j)] - mean) * (s \ ([v(i) u(j)] - mean)')) / (2*pi * sqrt(det(s)));
        end
    end
    GaussianSkin = GaussianSkin/max(max(GaussianSkin)); % normalize sto [0],1]
    figure();
    surf(u, v, GaussianSkin); 
    title('Gaussian Plot');
    print -djpeg GaussianPlot.jpg
    
    P = mvnpdf(C, mean, s);	
    P = reshape(P, [480 640]); % epanaferw tis arxikes diastaseis
    P = P/(max(max(P)));	   % kanw normalize sto [0,1]
    					
    
    %% Euresh perioxhs dermatos
    Itemp = imread(sprintf('./ChalearnUser/U%d.png',1));
    skin = (P >= 0.3) ;	% use a theshold
    figure();
    imshow(skin,[]);
    title('Skin Before Kinect Mask');
    print -djpeg skin_before_kinect_mask.jpg
    skin = skin.*Itemp; % gia na mhn paroume san derma kai la8os pragmata(px ta koutia)
    figure(); 
    imshow(skin, []);
    title('Skin Before Morfological Filters');
    print -djpeg skin_before_morf_filters.jpg
    
    % Opening Calculation
    opdisk  = strel('disk', 1);
    erode   = imerode(skin, opdisk);
    opening = imdilate(erode, opdisk);
    figure();
    imshow(opening,[]);
    title('Skin After Opening');
    print -djpeg opening.jpg
    % Closing Calculation
    cldisk  = strel('disk', 5);
    dilate  = imdilate(opening, cldisk);
    closing = imerode(dilate, cldisk);
    figure(); imshow(closing, []);
    title('Skin After Morfological Filters');
    print -djpeg skin_after_morf_filters.jpg
    
    % Anagnwrish Perioxwn Dermatos
    label = bwlabel(closing);				
    state = regionprops(label, 'BoundingBox');
    C1 =struct2cell(state)';
    C1 = cell2mat(C1);
    [row,~] = find(C1 == min(C1(:,1)));
    x= C1(row,1);
    y= C1(row,2);
    width= C1(row,3);
    height= C1(row,4);
    
    %{
    % B TROPOS ANAGNWRISHS PERIOXWN DERMATOS
    label = bwlabel(closing,4);				
    [ys,xs] = find(label == 1);
    x= min(xs);
    y= min(ys);
    width= max(xs)-x;
    height= max(ys)-y;
    %}
end
