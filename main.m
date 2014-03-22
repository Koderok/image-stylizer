function main(input, num_colors)

image = imread(input);
bw_image = rgb2gray(image);

%  
% filter = fspecial('gaussian', 3, 1);
% bw_image = conv2(double(bw_image), filter, 'same');
% image(:, :, 1) = conv2(double(image(:, :, 1)), filter, 'same');
% image(:, :, 2) = conv2(double(image(:, :, 2)), filter, 'same');
% image(:, :, 3) = conv2(double(image(:, :, 3)), filter, 'same');
% 

xdog_output = xdog(bw_image);
quant_result = median_cut(image,num_colors)/256.0;
bw_quant_result = bw_median_cut(image, num_colors)/256.0;

filter = fspecial('gaussian', 15, 3);
bw_quant_result = conv2(bw_quant_result, filter, 'same');
quant_result(:, :, 1) = conv2(quant_result(:, :, 1), filter, 'same');
quant_result(:, :, 2) = conv2(quant_result(:, :, 2), filter, 'same');
quant_result(:, :, 3) = conv2(quant_result(:, :, 3), filter, 'same');


[m n] = size(bw_image);
output = zeros(m,n,3);
bw_output = zeros(m, n);
for i=1:m
    for j=1:n
        bw_output(i, j) = xdog_output(i,j)*bw_quant_result(i,j);
        for k=1:3
            output(i,j,k) = xdog_output(i,j)*quant_result(i,j,k);
        end
    end
end

figure, imshow(image);
figure, imshow(output);
% figure, imshow(bw_output);