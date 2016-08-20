%% Object Detection

% Sabbiu Shah, Sagar Adhikari, Samip Subedi
% Department of Electronics and Computer Engineering
% IOE, Pulchowk Campus
% 2016


%==================== K-means function ==============================
function [ center, number ] = kmeans( features, clusters, KMI )
%It is the implementation of kmeans algorithm
F = features;
K = clusters;
CENTS = F( ceil(rand(K,1)*size(F,1)) ,:);              % Cluster Centers
cents_old = CENTS;
DAL   = zeros(size(F,1),K+2);                          % Distances and Labels
fprintf('Doing...%2d',1);
for n = 1:KMI
        fprintf('\b\b%2d',n);
   for i = 1:size(F,1)
      for j = 1:K  
        DAL(i,j) = norm(F(i,:) - CENTS(j,:));      
      end
      [Distance, CN] = min(DAL(i,1:K));                % 1:K are Distance from Cluster Centers 1:K 
      DAL(i,K+1) = CN;                                 % K+1 is Cluster Label
      DAL(i,K+2) = Distance;                           % K+2 is Minimum Distance
   end
   for i = 1:K
      A = (DAL(:,K+1) == i);                           % Cluster K Points
      CENTS(i,:) = mean(F(A,:));                       % New Cluster Centers
      if sum(isnan(CENTS(:))) ~= 0                     % If CENTS(i,:) Is Nan Then Replace It With Random Point
         NC = find(isnan(CENTS(:,1)) == 1);            % Find Nan Centers
         for Ind = 1:size(NC,1)
         CENTS(NC(Ind),:) = F(randi(size(F,1)),:);
         end
      end
   end
   
   
   check = cents_old - CENTS;
   cents_old = CENTS;
   check = abs(check);
   val = max(max(check));
   if(abs(val)<0.00001)
       break;
   end
   
   

end

center = CENTS;
number = DAL;
fprintf('\n');
end

