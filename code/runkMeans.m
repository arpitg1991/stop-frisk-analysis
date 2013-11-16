data = csvread('../data/kmeans/clusterCountFoodStamps.csv');
%%
[idx4,c4,sumd4] = kmeans(data,4,'MaxIter',1000);
[idx5,c5,sumd5] = kmeans(data,5);
[idx10,c10,sumd10] = kmeans(data,10);
[idx2,c2,sumd2] = kmeans(data,2);
%%
[cidx4,cc4,csumd4] = kmeans(data,4,'distance','hamming');
[cidx5,cc5,csumd5] = kmeans(data,5,'distance','hamming');
[cidx10,cc10,csumd10] = kmeans(data,10,'distance','hamming');
[cidx2,cc2,csumd2] = kmeans(data,2,'distance','hamming');
%%
idx = [idx4 idx5 idx10 idx2 cidx4 cidx5 cidx10 cidx2];
%idx = [cidx4 cidx5 cidx10 cidx2];
k = [4 5 10 2 4 5 10 2];
feat = zeros(sum(k),25);
for i = 1:length(k)
    for j = 1:k(i)
        feat(sum(k(1:i-1)) + j,1:25) = sum(data(idx(:,i) == j,1:25) ) ; 
    end
end
csvwrite('featuresKMeans.csv',feat)
%%
csvwrite('kMeans.csv',idx);