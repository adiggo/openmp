clc;
clear all;

pathToFolder = '/Users/iamrick86/Desktop/serial';
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

Temp = zeros(3,22);

for i=1:20
    J = data1{i};
    for k = 1: 22
        for x = 1:3
          
            Temp(x, k) = Temp(x,k) + J(x,k); 
        end
    end
end
mean = Temp/20; 
for c = 1:22
        mean(2,c) = mean(2,c)/1000000
end

new = zeros(2,22);
for c = 1:22
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
for j = 1 : 11
%     sfilter(j) = y(2*j-1);
%     
%     sdata(j) = y(2*j);
	filterlength(j) = x(2*j);
    sfilter(j) = 512*512*128*filterlength(j)/y(2*j-1);
    
    sdata(j) = 512*512*128*filterlength(j)/(2*j);
    
end

%%%%%%%%%%%%%%%this part for plotting standard running time
% plot(filterlength,sfilter,'r',filterlength,sdata,'g');
% 
% xlabel('filter length');
% ylabel('running time');
% title('serialfilterfirst compare with serialdatafirst(green is filter first)');



%%%%%%%%%%%%%%%%%%% this part for normalized run time
% plot(filterlength,sfilter,'r', filterlength,sdata,'g');
% xlabel('filter length');
% ylabel('operation per second');
% title('serialfilterfirst compare with serialdatafirst(green is filter first)');

for j = 1 : 11
%     sfilter(j) = y(2*j-1);
%     
   relative (j) = sdata(j)/sfilter(j);
   
end
plot(filterlength,relative);
xlabel('filter length');
ylabel('relative performace:data/filter');
title('Relative performace');




%data = cat(3,data{:});
%mn = mean(data(:,5,:),3)    %# mean of 5th col across 100 files
