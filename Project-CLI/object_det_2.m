%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016

%% ============== Part 3. Load all the descriptors to a matrix ==========
% It loads all the descriptors to a matrix and also stores no. of features
% for each images
% variables ========
features_each = [];
features_category = [];
features_all = [];
% ==================
load('imageSet.mat','imgSets');
no_of_category = length(imgSets);
count = 0;
for i=1:no_of_category
    no_of_images = length(imgSets(:,i).ImageLocation);
    
    for j=1:no_of_images
        file_path = char(imgSets(1,i).ImageLocation(1,j));
        [pathstr,name,ext] = fileparts(file_path);
        load(char(strcat(pathstr,'\',name,'.mat')),'descriptor');
        descriptor = double(descriptor)/255;
        features_all = [features_all; descriptor];
        count = count + size(descriptor,1);
        features_each = [features_each; count];
    end
    features_category = [features_category; count];
end

fprintf('Total no. of features: %9d\n',count);
%% ========== Part 4. K-means clustering ================================
% K-means clustering is an unsupervised learning algorithm. It clusters the
% features into n number of cluster.

clusters = 500;
iteration = 100;

% using library
% [centers, dist_n_val] = vl_kmeans(features_all',clusters,'verbose');
% dist_n_val = double(dist_n_val');
% for i = 2:1002
% dist_n_val(:,i)=dist_n_val(:,1);
% end
% centers = centers';
% ======================

% without using library
[centers, dist_n_val] = kmeans(features_all, clusters, iteration);
% =========================

% save the details
save_cluster_details;
save_features_detail;