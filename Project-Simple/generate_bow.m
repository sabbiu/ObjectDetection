%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016

%% ================ function that generates bag of words ==============
function [ histogram, bounding_rect] = generate_bow( image )
%generates bow for new image
bagg = 500;
    
    I = imread(image);
    level = graythresh(I);
    bw = im2bw(I,level);
    se = strel('line',11,90);
    erodedBW = imerode(imcomplement(bw),se);
    dilatedBW = imdilate(erodedBW,se);
    
    col_info = any(dilatedBW,1);
    row_info = any(dilatedBW,2);
  
    min_x = 1; min_y = 1;
    
    for i=1:size(col_info,2)
        if(col_info(1,i) == 1)
            if(min_x ==1 )
                min_x = i;
            end
            max_x = i;
        end
    end
    for i=1:size(row_info,1)
        if(row_info(i,1) == 1)
            if(min_y ==1 )
                min_y = i;
            end
            max_y = i;
        end
    end
    bounding_rect = [min_x,    min_y,  max_x-min_x,    max_y-min_y];
    
    I = imcrop(I,[min_x,    min_y,  max_x-min_x,    max_y-min_y]);
    
    imwrite(mat2gray(I),'temporary_crop.jpg');
    descriptors = features_SIFT('temporary_crop.jpg');
    load('cluster_centers.mat','centers');
    descriptors = double(descriptors)/255;
    % variable that stores cluster no.
    cluster_no = [];
    histogram = zeros(1,bagg);
    
    for i=1:size(descriptors,1)
        minimum = norm(descriptors(i,:)-centers(1,:));
        index = 1;
        for j=2:size(centers,1)
            if(minimum > norm(descriptors(i,:)-centers(j,:)))
                minimum = norm(descriptors(i,:)-centers(j,:));
                index = j;
            end
        end
        
       
        cluster_no = [cluster_no; index];
    end
    
    for i=1:size(cluster_no,1)
        histogram(1,cluster_no(i,1)) = histogram(1,cluster_no(i,1)) + 1;
    end
    
    histogram = histogram/norm(histogram);
    
   
end

