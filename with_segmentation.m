image = imread('lena.png');
image = rgb2gray(image);

num_clusters = 3;
clustered = reshape(kmeans(double(image(:)),num_clusters), size(image))-1;

[m n] = size(image);
images = zeros(num_clusters,m,n);
sum_images = zeros(num_clusters,1);
num_pixels_images = zeros(num_clusters,1);
avg_pixels_images = zeros(num_clusters,1);

for i=1:m
    for j=1:n
        images(clustered(i,j)+1,i,j) = 1;
        sum_images(clustered(i,j)+1) = double(sum_images(clustered(i,j)+1)) + double(image(i,j));
        num_pixels_images(clustered(i,j)+1) = num_pixels_images(clustered(i,j)+1) + 1;
    end
end

for i=1:num_clusters
    avg_pixels_images(i) = double(sum_images(i))/double(num_pixels_images(i));
end

for i=1:num_clusters
    for j=1:m
        for k=1:n
            if(images(i,j,k) == 1)
                images(i,j,k) = avg_pixels_images(i);
            end
        end
    end
end

output = zeros(size(image));

for i=1:num_clusters
    new_image = reshape(images(i,:,:),size(image));
    output = output + new_image;
end

output = output;
[m n] = size(image);

xdog_image = xdog(image);

figure, imshow(xdog_image)
output = output/256.0;
for i=1:m
    for j=1:n
        output(i,j) = xdog_image(i,j)*output(i,j);
    end
end

figure, imshow(image)
figure, imshow(output)