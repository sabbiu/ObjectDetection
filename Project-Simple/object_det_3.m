%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016

%% ============== Part 5. Creating Histogram for each image =============
% This Step creates histogram and saves it to its respective folder
clear all;
bagg=500;
load('cluster_centers','centers');
load('cluster_values','dist_n_val');
load('features_all','features_all');
load('features_each','features_each');
load('features_category','features_category');
load('imageSet.mat','imgSets');

img_cnt = 1;
img_each = 0;
category_cnt = 1;
histogram = zeros(1,bagg);

% file_path = char(imgSets(1,category_cnt).ImageLocation(1,img_cnt));
% [pathstr,name,ext] = fileparts(file_path);
% save(char(strcat(pathstr,'\',name,'hist.mat')),'histogram');
        
for i=1:size(features_all,1)
    
    location = dist_n_val(i,bagg+1);
    histogram(1,location) = histogram(1,location) + 1;
    if(i == features_each(img_cnt,1))
        histogram = histogram/norm(histogram);
        file_path = char(imgSets(1,category_cnt).ImageLocation(1,img_cnt-img_each));
        [pathstr,name,ext] = fileparts(file_path);
        save(char(strcat(pathstr,'\histograms\',name,'hist.mat')),'histogram');
        
        
        if(i == features_category(category_cnt,1))
            img_each = img_cnt;
            category_cnt = category_cnt + 1;
        end
        
        img_cnt = img_cnt + 1;
        histogram = zeros(1,bagg);
        
    end
    
end
    