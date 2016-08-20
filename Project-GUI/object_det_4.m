%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016

%% ============== Part 5. Manage the training sets ====================
% Here, the training sets are managed so that it is ready to be trained
% with SVM (SMO)
function [trained_models] =  object_det_4()
load('imgSets.mat','imgSets');

X = []; % stores the features
Y = []; % stores the category
Z = []; % stores the names
    
for i=1:size(imgSets,2)
    
    for j = 1:imgSets(1,i).Count
        file_path = char(imgSets(1,i).ImageLocation(1,j));
        [pathstr,name,ext] = fileparts(file_path);
        load(char(strcat(pathstr,'\histograms\',name,'hist.mat')),'histogram');
        X = [X; histogram];
        Y = [Y; i];
        
    end
    
   
    Z = [Z; {imgSets(1,i).Description}];
end

file_path = fullfile('objectCategories','reinf_histogram.mat');
if exist(file_path,'file')
    load('objectCategories\reinf_histogram');
    
    X = [X; reinf_histogram{1,1}];
    Y = [Y; reinf_histogram{1,2}];
    
    
    
end


%% ============== Part 6. Train using SVM ==============================
% just
trained_models = {};
for i = 1:size(Z,1)
    Y_new = Y;
    
    Y_new(Y_new ~= i) = 0;
    Y_new(Y_new == i) = 1;
    
    C = 0.1; sigma = 0.1;
    model = svmTrain(X, Y_new, C, @(x1,x2) gaussianKernel(x1,x2, sigma));
% save('xmat.mat','X');
%     save('ymat.mat','Y_new');
    [p,q] = svmPredict(model, X);
    
    trained_models{i} = struct('model',model, ...
                         'name',Z(i));
    
end

end