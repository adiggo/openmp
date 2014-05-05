clc;
clear all;

pathToFolder = '/Users/iamrick86/Desktop/speedup';
files = dir( fullfile(pathToFolder,'*.txt') );

%# read all files
data1 = cell(numel(files),1);

for i=1:numel(files)
    fid = fopen(fullfile(pathToFolder,files(i).name), 'rt');
    
    
    % get the information from text file
    H = textscan(fid, '%s %s %s %s %d %s %s %d %s %s %s %d %s %s %s %d');

    fclose(fid);
    % 
    A = H{5}; 
    B = H{8};
    C = H{12};
    D = H{16};
    data1{i} = [A';B';C';D'];
end

Temp = zeros(4,6);

for i=1:20
    J = data1{i};
    for k = 1: 6
        for x = 1:4
          
            Temp(x, k) = Temp(x,k) + J(x,k); 
        end
    end
end
mean = Temp/20; 
for c = 1:6
        mean(2,c) = mean(2,c)/1000000;
end

new = zeros(2,6);
for c = 1:6
    for l = 1:2
        if (l == 1)
        new(l,c) = mean(l,c) + mean(l+1,c);
        else
            new(l,c) = mean(l+1,c);
        end
    end
end
y = new(1,:);
x = new (2, :);
plot(x,y);
xlabel('number of thread');
ylabel('running time');
title('speedup figure for data first(zero point is serial process)');



%data = cat(3,data{:});
%mn = mean(data(:,5,:),3)    %# mean of 5th col across 100 files