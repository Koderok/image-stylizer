function [ result ] = median_cut( image,iterations )
[m, n, ~] = size(image);

colors = zeros(3, m*n);
colors(1, :) = reshape(image(:, :, 1), 1, m*n);
colors(2, :) = reshape(image(:, :, 2), 1, m*n);
colors(3, :) = reshape(image(:, :, 3), 1, m*n);

bins{1} = [colors];

for i=1:iterations
    [~, nBins] = size(bins);
    maxDimValue = 0;
    splitDim = 0;
    max_index = 0;
    % Find the bin to split(bin with largest dimension)
    for j=1:nBins
        tmpDimsArr = [(max(bins{j}(1, :))-min(bins{j}(1, :))), (max(bins{j}(2, :))-min(bins{j}(2, :))), (max(bins{j}(3, :))-min(bins{j}(3, :)))];
        [tmpMaxDim, tmpSplitDim] = max(tmpDimsArr);
        if(tmpMaxDim > maxDimValue)
            maxDimValue = tmpMaxDim;
            max_index = j;
            splitDim = tmpSplitDim;
        end
    end
    
    % Got the bin to split(bins{j}). Now do the splitting.
    [~, numCols] = size(bins{max_index});
    arrT = bins{max_index}';
    [~, idx] = sort(arrT(:, splitDim));     % Sort by the channel "splitDim"
    sortedArr = arrT(idx, :)';
    splitIdx = floor(numCols/2);
    newBin1 = sortedArr(:, 1:splitIdx);
    newBin2 = sortedArr(:, (splitIdx+1):numCols);
    bins(max_index) = [];                  % Delete the previous(splitted) bin
    bins{nBins} = newBin1;
    bins{nBins+1} = newBin2;
end


newColors = zeros(256, 3);
% Find representative colors for each bin
[~, nBins] = size(bins);
for i=1:nBins
    arr = bins{i};
    [~, nCols] = size(arr);
    r_sum_val = double(0);  g_sum_val = double(0);  b_sum_val = double(0);
    for j=1:nCols
        r_sum_val = double(r_sum_val)+double(arr(1, j));
        g_sum_val = double(g_sum_val)+double(arr(2, j));
        b_sum_val = double(b_sum_val)+double(arr(3, j));
    end
    r_avg = ceil(r_sum_val/nCols);
    g_avg = ceil(g_sum_val/nCols);
    b_avg = ceil(b_sum_val/nCols);
    
    for j=1:nCols
       newColors(arr(1, j)+1, 1) = r_avg;
       newColors(arr(2, j)+1, 2) = g_avg;
       newColors(arr(3, j)+1, 3) = b_avg;
    end
end

[m n dummy3] = size(image);
result = zeros(m,n,3);
for i=1:m
    for j=1:n
        for k=1:3
            result(i, j, k) = newColors(image(i,j,k)+1, k);
        end
    end
end

end