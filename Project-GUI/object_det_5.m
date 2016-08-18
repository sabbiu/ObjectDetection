%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016


%% ============== Part 7. Localization =================================


clear all;
load('trained_models');

histogram_temp = [];
levels = 2;
I_color = imread('test_image.jpg');
I = rgb2gray(I_color);
save_values = [];
figure
imshow(I_color);
for i = 2:levels
    division = (2.^(i-1)).^2;
    divs = sqrt(division);
    for j =1: division
        

        row = size(I,1);
        col = size(I,2);
        
        pos_x = ceil(j./divs);
        pos_y = rem(j,divs);
        pos_y(pos_y==0) = divs;
        x_start = floor((pos_x-1)*(row./divs))+1;
        x_stop  = floor(pos_x*(row./divs));
        y_start = floor((pos_y-1)*(col./divs))+1;
        y_stop  = floor(pos_y*(col./divs));
        
        
        imwrite(mat2gray(I(x_start:x_stop,y_start:y_stop)), ...
            'temporary.jpg');
        
        
        [histogram, bounding_rect] = generate_bow('temporary.jpg');
        bounding_rect(1) = bounding_rect(1)+y_start;
        bounding_rect(2) = bounding_rect(2)+x_start;
        
        histogram_temp = [histogram_temp; histogram];
        hold on;
        rectangle('Position',bounding_rect,'EdgeColor','y','LineWidth',4);
         
        [a(1,1),a(2,1)] = svmPredict(trained_models{1}.model,histogram);
        [a(1,2),a(2,2)] = svmPredict(trained_models{2}.model,histogram);
        [a(1,3),a(2,3)] = svmPredict(trained_models{3}.model,histogram);
        
        [m, idx] = max(a,[],2);
        
        if(m(1,:) == 1 )
            disp_text = trained_models{idx(2,:)}.name;
        else
            disp_text = 'Not identified!';
        end
        text(bounding_rect(1)+bounding_rect(3),bounding_rect(2)+bounding_rect(4),disp_text,'FontSize',20 );
          
    end
    
    save(fullfile('objectCategories','histogram_temp.mat'),'histogram_temp');
end



%% check for mistakes
object_det_6;