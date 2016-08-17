%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016


%% ============== Part 8. Check for Mistakes ==========================

fprintf('\n\nSome Questions!!!');
fprintf('\n-------------------\n');
reinf_histogram2 = {};
reinf_histogram2{1,1} = [];
reinf_histogram2{1,2} = [];
flag = 1;           
for i=1:2
    for j=1:2
        fprintf('\n ');
        prompt = strcat('Was image at location ',num2str(i),', ',num2str(j),' detected correctly? [y/n]');
        yesno = input(prompt,'s');
        if(yesno == 'y')
            continue;
        end
        
        fprintf('\n\nWhat was it then?\n');
        fprintf('1. coin\n2. keys\n3. pendrive\n4. none of above\n');
        prompt = 'Choose any one :';
        value = input(prompt);
        flag = 0;
        

        
        reinf_histogram2{1,1} = [reinf_histogram2{1,1};histogram_temp(j+(i-1)*2,:)];
        reinf_histogram2{1,2} = [reinf_histogram2{1,2};value];
        
        
    end
end
    
    if(flag ==0)
        
        file_path = fullfile('objectCategories','reinf_histogram.mat');
        if ~exist(file_path,'file')
            reinf_histogram = reinf_histogram2;
            save(file_path,'reinf_histogram');
            
        else
            load('objectCategories\reinf_histogram');
            reinf_histogram{1,1} = [reinf_histogram{1,1}; ...
                                    reinf_histogram2{1,1}];
            reinf_histogram{1,2} = [reinf_histogram{1,2}; ...
                                    reinf_histogram2{1,2}];
            save(file_path,'reinf_histogram');
            
        end
        
        
        
        
         % learn again
         object_det_4;
 
    end
    
