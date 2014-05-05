clc;
clear all;

pathToFolder = '/Users/iamrick86/Desktop/scaleup/scaleup';
files = dir( fullfile(pathToFolder,'*.txt') );

%# read all files
data1 = cell(numel(files),1);

for i=1:numel(files)
    fid = fopen(fullfile(pathToFolder,files(i).name), 'rt');
    
    
    % get the information from text file
    H = textscan(fid, '%s %s %s %s %d %s %s %d %s %s %s %s %d');

    fclose(fid);
    % 
    A = H{5}; 
    B = H{8};
    C = H{13};
   
    data1{i} = [A';B';C'];
end

Temp = zeros(3,10);

for i=1:20
    J = data1{i};
    for k = 1: 10
        for x = 1:3
          
            Temp(x, k) = Temp(x,k) + J(x,k); 
        end
    end
end

%get the average of the data

mean = Temp/20; 

%normalize microsecond to seconds
for c = 1:10
        mean(2,c) = mean(2,c)/1000000
end

new = zeros(2,10);
for c = 1:10
    for l = 1:2
        if(l ==1)
        new(l,c) = mean(l,c) + mean(l+1,c);
        else
            new(l,c) = mean(l+1,c);
        end
    end
end
y = new(1,:);
x = new (2, :);
for j = 1 : 5
   sfilter(j) = y(2*j-1);
%     
     sdata(j) = y(2*j);
  
    
end


    filterlength(1) = 1;
    filterlength(2) =2;
    filterlength(3) =4;
    filterlength(4) =8;
    filterlength(5) =16;
    
%%%%%%%%%%%%%%%this part for plotting standard running time
plot(log(filterlength),sfilter,'g',log(filterlength),sdata,'r');

xlabel('scale:datasize and thread(log)');
ylabel('running time');
title('scaleup(green is filter first)');







%data = cat(3,data{:});
%mn = mean(data(:,5,:),3)    %# mean of 5th col across 100 files