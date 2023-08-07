close all;
clear all;
clc;

% reading the data file
fileName = 'flag.data'; % name of the file
[dat,limit]=importdata(fileName); % reading the data

% splitting the data
data = cell(size(dat,1),1); % initialize the cell array
for ii = 1:size(dat,1)
    data = dat{ii,1};
    seperate = strsplit(data, limit);
    for k = 1:size(seperate,2)
        dat{ii,k} = seperate{1,k};
    end
end

% start the probability calculations (histograms)
prob = cell(1,size(dat,2));

ENTROPY = zeros(1,size(dat,2));
feature = ENTROPY;

for ii = 1:size(dat,2)
    d = dat(:,ii);
    [n,o] = cellhist(d);
    point = n / sum(n);
    % saving probability values:
    for k = 1:size(n,1)
        o{k,2} = n(k,1);
        o{k,3} = point(k,1);
        prob{1,ii} = o;
    end
    % entropy calculations:
    E1 = -sum(point.*log2(point));
    ENTROPY(1,ii) = E1;
end

% start joint entropy calculations:
JENTROPY = zeros(size(dat,2));
for ii = 1:size(dat,2) % first feature
    for k = 1:size(dat,2) % second feature
        sum = 0; % reinitialize sum of joint entropy to zero
        for m = 1:size(prob{1,ii},1)
            for n = 1:size(prob{1,k},1)
                probofX = cell2mat(prob{1,ii}(m,3));
                probofY = cell2mat(prob{1,k}(n,3));
                probofXY = probofX * probofY;
                sum = sum + probofXY * log2(probofXY);
            end
        end
%          assign summation value to joint entropy between these two
%          features currently under study:
        JENTROPY(ii,k) = -sum;
    end
end

% reshaping the joint entropy features into an array:
JntENTROPYVECT = reshape(JENTROPY,[size(dat,2)*size(dat,2),1]);
[order,Index] = sort(JntENTROPYVECT,'descend');

sel = zeros(1,1); %size(data_1,2);
countr = 1; % counter
indCates_cnt = 1; % initialize counter for indices and order
threshold = 10; % threshold value for entropy

while(1)
    ord = order(indCates_cnt,1);
    if ord <= threshold
        break;
    end
    ind = Index(indCates_cnt,1);
    [Ind,Jack] = ind2sub([size(dat,2),size(dat,2)], ind);
    Ind_chk = find(sel == Ind,1);
    if isempty(Ind_chk) == 1
        sel(1,countr) = Ind;
        countr = countr + 1;
    end
    J_chk = find(sel == Jack,1);
    if isempty(J_chk) == 1
        sel(1,countr) = Jack;
        countr = countr + 1;
    end
    indCates_cnt = indCates_cnt + 1; %increment counter
end

% displaying results of feature selection algo
disp('The list of useful features are:');
disp(sel);

list = 1:30;
red = list(1,~ismember(list,sel)); %list of remaining features
disp(' ');
disp('While the list of redundant features are:');
disp(red);
