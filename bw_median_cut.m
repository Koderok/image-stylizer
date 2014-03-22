function [ result ] = median_cut( image,iterations )
[m n] = size(image);

intensities = [];

for i=1:m
    for j=1:n
        intensities = [intensities image(i,j)];
    end
end

bins = [1 m*n];

sorted_val = sort(intensities);

for i=1:iterations
    [x y] = size(bins);
    max = 0;
    max_index = 0;
    for j=1:x
        if((bins(j,2)-bins(j,1)+1) > max)
            max = bins(j,2)-bins(j,1)+1;
            max_index = j;
        end
    end
    start = bins(max_index,1);
    fin = bins(max_index,2);
    mid = floor((start+fin)/2);
    bins(max_index,:) = [];
    bins(x,:) = [start mid];
    bins(x+1,:) = [mid+1 fin];
end

corr_inten = zeros(256,1);
for i=1:256
    corr_inten(i) = i-1;
end

[m n] = size(bins);
for i=1:m
    sum_val = double(0);
    for j=bins(i,1):bins(i,2)
        sum_val = double(sum_val)+double(sorted_val(j));
    end
    avg = ceil(sum_val/(bins(i,2)-bins(i,1)+1));
    for j=bins(i,1):bins(i,2)
        corr_inten(sorted_val(j)+1) = avg;
    end
end

[m n] = size(image);

result = zeros(m,n);
for i=1:m
    for j=1:n
        result(i,j) = corr_inten(image(i,j)+1);
    end
end

end