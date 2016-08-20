%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016

%% ================ function that generates bag of words ==============
function [histogram] = generate_bow( image )
%generates bow for new image
bagg = 500;
    
   
    descriptors = features_SIFT(image);
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

