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
%%
dataK = data(:,2:size(data,2)) ; 

for k = 1: size(dataK,2) 
    dataK(:,k) = dataK(:,k) / max(dataK(:,k)) ; 
end
[idx4,c4,sumd4] = kmeans(dataK,4,'MaxIter',1000,'start','cluster','Replicates',10);
[idx3,c3,sumd3] = kmeans(dataK,3,'MaxIter',1000,'start','cluster','Replicates',10);
[idx2,c2,sumd2] = kmeans(dataK,2,'MaxIter',1000,'start','cluster','Replicates',10);

idx4 = [data(:,1) idx4];
idx3 = [data(:,1) idx3];
idx2 = [data(:,1) idx2];
dlmwrite('../data/Racek-4.csv',idx4,'delimiter',',','precision',7);
dlmwrite('../data/Racek-3.csv',idx3,'delimiter',',','precision',7);
dlmwrite('../data/Racek-2.csv',idx2,'delimiter',',','precision',7);
%%
dataK = data(:,[2:11 17:size(data,2)]);
%%
for k = 1: size(dataK,2) 
    dataK(:,k) = dataK(:,k) / max(dataK(:,k)) ; 
end
[idx4,c4,sumd4] = kmeans(dataK,4,'MaxIter',1000,'start','cluster','Replicates',10);
[idx3,c3,sumd3] = kmeans(dataK,3,'MaxIter',1000,'start','cluster','Replicates',10);
[idx2,c2,sumd2] = kmeans(dataK,2,'MaxIter',1000,'start','cluster','Replicates',10);

idx4 = [data(:,1) idx4];
idx3 = [data(:,1) idx3];
idx2 = [data(:,1) idx2];
%%
dlmwrite('../data/NoRacek-4.csv',idx4,'delimiter',',','precision',7);
dlmwrite('../data/NoRacek-3.csv',idx3,'delimiter',',','precision',7);
dlmwrite('../data/NoRacek-2.csv',idx2,'delimiter',',','precision',7);
%%
%race with factor analysis
dataK = data(:,2:size(data,2)) ; 
dataK = dataK(:,[1:5 7 9:13 15 18:22 26]);
for k = 1: size(dataK,2) 
    dataK(:,k) = dataK(:,k) / max(dataK(:,k)) ; 
end
[idx4,c4,sumd4] = kmeans(dataK,4,'MaxIter',1000,'start','cluster','Replicates',10);
[idx3,c3,sumd3] = kmeans(dataK,3,'MaxIter',1000,'start','cluster','Replicates',10);
[idx2,c2,sumd2] = kmeans(dataK,2,'MaxIter',1000,'start','cluster','Replicates',10);

idx4 = [data(:,1) idx4];
idx3 = [data(:,1) idx3];
idx2 = [data(:,1) idx2];
dlmwrite('../data/Factor-Racek-4.csv',idx4,'delimiter',',','precision',7);
dlmwrite('../data/Factor-Racek-3.csv',idx3,'delimiter',',','precision',7);
dlmwrite('../data/Factor-Racek-2.csv',idx2,'delimiter',',','precision',7);
%%
%%
%race with factor analysis
dataK = data(:,2:size(data,2)) ; 
dataK = dataK(:,[1:5 7 9:10  15 18:23 25 26]); 
for k = 1: size(dataK,2) 
    dataK(:,k) = dataK(:,k) / max(dataK(:,k)) ; 
end
[idx4,c4,sumd4] = kmeans(dataK,4,'MaxIter',1000,'start','cluster','Replicates',10);
[idx3,c3,sumd3] = kmeans(dataK,3,'MaxIter',1000,'start','cluster','Replicates',10);
[idx2,c2,sumd2] = kmeans(dataK,2,'MaxIter',1000,'start','cluster','Replicates',10);

idx4 = [data(:,1) idx4];
idx3 = [data(:,1) idx3];
idx2 = [data(:,1) idx2];
dlmwrite('../data/Factor-NoRacek-4.csv',idx4,'delimiter',',','precision',7);
dlmwrite('../data/Factor-NoRacek-3.csv',idx3,'delimiter',',','precision',7);
dlmwrite('../data/Factor-NoRacek-2.csv',idx2,'delimiter',',','precision',7);






