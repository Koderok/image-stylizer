function [ output ] = dog( image )
image = double(image);
tao = 0.9;
eps = 3;
phi = 20/255.0;

filter1 = fspecial('gaussian', 20, 6);
filter2 = fspecial('gaussian', 20, 1.5);

image1 = conv2(image, filter1, 'same');
image2 = conv2(image, filter2, 'same');
result = image2 - tao*image1;

[m n] = size(result);
output = zeros(m,n);

min = 1;

for i=1:m
    for j=1:n
        if(result(i,j) >= eps)
            output(i,j) = 1;
        else
            output(i,j) = 1 + tanh(phi*(result(i,j)-eps));
        end
    end
end
% 
% figure, imshow(output)
% 
% for i=1:m
%     for j=1:n
%         output(i,j) = image(i,j)*output(i,j)/256.0;
%     end
% end
end