function[BOF_tr]=MyBagOfWords(data_train)
	%data_train -> cell array which we want to convert to a compatible simple array with values
    %to take our samples
    %choose 1000 as number of center for our algorithm
    centers = 50;
	%data train--> cell array with 1 line
    %we convert it into a column vector
    %to implement cell2mat 
    %because all the inside-cell-arrays
    %have now the same 2nd dimensions
    %and are able to be merged
    my_train = (data_train)';
    %synenwsh perigrafhtwn tou synolou ekpaideyshs se ena dianysma 
    %xarakrhtistikwn aneksarthta apo thn klash sthn opoia anhkoun
	my_train = cell2mat(my_train); 
    %now we have a simple array with fixed number of columns
	%initialization of my result matrices
	%at the correct size
    S_tr=size(data_train,2);    
    BOF_tr(1:S_tr,1:centers) = 0;   	
	%take 50% of my samples randomly
    half = ceil(size(my_train,1)/2);
    samples = datasample(my_train,half,'Replace',false);
	%kmeans algorithm implementation,
    [~, kmRes] = kmeans(samples, centers);
    reps = size(kmRes,1);
    %% Data_Train
    for i = 1:S_tr %for each array in cell arrays//image
        %histogram for data_train cell array        
        for j = 1:size(data_train{i}, 1)
            A=data_train{i}(j,:);
            I_pix = repmat(A, reps, 1);%replication of my current matrix
            eucl_dist = sqrt(sum((kmRes-I_pix).^2,2)); %get the appropriate distance
            [~, min_eucl_ind] = min(eucl_dist); %find the index of the minimum distance
            BOF_tr(i, min_eucl_ind) = BOF_tr(i, min_eucl_ind) + 1; %add 1 to the appropriate index of BOF_tr
        end      
    end
    %% Normalization for data_train
    for i = 1:S_tr
        L2 = norm(BOF_tr(i,:));
        BOF_tr(i,:) = BOF_tr(i,:) / L2 ;
    end
end
