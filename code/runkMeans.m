data1 = csvread('../data/kmeans/clusterCountFoodStamps.csv');
%data2 = csvread('../data/kmeans/clusterIdCountFoodStamps.csv');
%data3 = csvread('../data/kmeans/clusterIdCountIncome.csv');
data4 = csvread('../data/kmeans/clusterCountIncome.csv');

%%
[idx4,c4,sumd4] = kmeans(data1,4,'MaxIter',1000,'start','cluster','Replicates',10);
[idx3,c3,sumd3] = kmeans(data1,3,'MaxIter',1000,'start','cluster','Replicates',10);
[idx2,c2,sumd2] = kmeans(data1,2,'MaxIter',1000,'start','cluster','Replicates',10);
%%
csvwrite('Income4.csv',idx4 ) ;
%%

[iidx4,ic4,isumd4] = kmeans(data4,4,'MaxIter',1000,'start','cluster','Replicates',10);
[iidx3,ic3,isumd3] = kmeans(data4,3,'MaxIter',1000,'start','cluster','Replicates',10);
[iidx2,ic2,isumd2] = kmeans(data4,2,'MaxIter',1000,'start','cluster','Replicates',10);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%frisk with almost everything in 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = csvread('../data/friskCounts.csv');
dataInd = data(:,1);
dataK = data(:,2:size(data,2)) ; 
%%
for k = 1: size(dataK,2) 
    dataK(:,k) = dataK(:,k) / max(dataK(:,k)) ; 
end
[idx4,c4,sumd4] = kmeans(dataK,4,'MaxIter',1000,'start','cluster','Replicates',10);
[idx3,c3,sumd3] = kmeans(dataK,3,'MaxIter',1000,'start','cluster','Replicates',10);
[idx2,c2,sumd2] = kmeans(dataK,2,'MaxIter',1000,'start','cluster','Replicates',10);



