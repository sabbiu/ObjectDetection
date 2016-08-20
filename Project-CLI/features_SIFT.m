%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016


%% ================ SIFT_features function ===========================
function [ descriptor ] = features_SIFT( image_loc )
% This function returns descriptor for image using SIFT

    peak_thresh = 0;    % increase to limit; default is 0 
    edge_thresh = 10;   % decrease to limit; default is 10 

    I = imread(image_loc);
%     figure
%     imshow(I);
    if size(I,3)>1
        I = rgb2gray(I);  
    end
    
    I = single(I);  % Convert to single precision floating point
    [feature, descriptor] = vl_sift(I, ...     
        'PeakThresh', peak_thresh, ...     
        'edgethresh', edge_thresh ); 
    
%     perm = randperm(size(feature,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(feature(:,sel)) ;
% h2 = vl_plotframe(feature(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;

    descriptor = transpose(descriptor);
end

