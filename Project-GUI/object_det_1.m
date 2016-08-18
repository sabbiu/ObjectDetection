%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016

%% Clear Memory & Command Window
clear all;
close all;
clc;

%% ============= Part 1. Loading the images in a matrix ==================
% This loads all the images containing in the folder named
% 101_ObjectCategories/<categories_folder> into a matrix imgSets

rootfolder = fullfile('objectCategories');

imgSets = [ imageSet(fullfile(rootfolder, 'coins')), ...
            imageSet(fullfile(rootfolder, 'keys')), ...
            imageSet(fullfile(rootfolder, 'pendrive')), ...
           % imageSet(fullfile(rootfolder, 'watch')), ...
            ];

%% ============ Part 2. Extract features for each images using SIFT ======
% Now, it first runs/setups vl_sift for extracting SIFT descriptors for all
% images in imgSets and saves it to respective *.mat file
fprintf('Setting up vl_SIFT ...');
run('vlfeat-0.9.20\toolbox\vl_setup');
fprintf('Done!');

no_of_category = length(imgSets);

for i=1:no_of_category
    no_of_images = length(imgSets(:,i).ImageLocation);
    
    fprintf(strcat('\n\nImage Category\t',num2str(i),':\t ',imgSets(:,i).Description));
    fprintf('\nNo. of images = %4d',no_of_images);
    fprintf('\nExtracting SIFT features...\t %4d/%4d',1,no_of_images);
    for j=1:no_of_images
        fprintf('\b\b\b\b\b\b\b\b\b%4d/%4d',j,no_of_images);
        file_path = char(imgSets(1,i).ImageLocation(1,j));
        [pathstr,name,ext] = fileparts(file_path);
        descriptor = features_SIFT(file_path);
        save(char(strcat(pathstr,'\',name,'.mat')),'descriptor');
    end
end

fprintf('\n\nSIFT features Extracted!!!\n\n');
save('imageSet.mat','imgSets');