%% Ex 1
ImC = imread('Universe.jpg');
ImG = rgb2gray(ImC);
% Define different brightness thresholds
Th1 = 0.3; % for counting all stars
Th2 = 0.6; % for counting all mid-level and first-level stars
Th3 = 0.8; % for counting only first-level stars of brightness in the image
% Convert gray image to binary using each threshold
Imbw1 = im2bw(ImG, Th1);
Imbw2 = im2bw(ImG, Th2);
Imbw3 = im2bw(ImG, Th3);
% Label objects in each binary image
[LabeledIm1, numStars1] = bwlabel(Imbw1, 4);
[LabeledIm2, numStars2] = bwlabel(Imbw2, 4);
[LabeledIm3, numStars3] = bwlabel(Imbw3, 4);
% Display the results
disp(['Number of stars with Th1 = 0.3: ', num2str(numStars1)])
disp(['Number of stars with Th2 = 0.6: ', num2str(numStars2)])
disp(['Number of stars with Th3 = 0.8: ', num2str(numStars3)])

subplot(2,3,1); imshow(ImC); title('ImC');
subplot(2,3,2); imshow(ImG); title('ImG');
subplot(2,3,4); imshow(LabeledIm1); title(['Th1 = 0.3, ', num2str(numStars1), ' stars'])
subplot(2,3,5); imshow(LabeledIm2); title(['Th2 = 0.6, ', num2str(numStars2), ' stars'])
subplot(2,3,6); imshow(LabeledIm3); title(['Th3 = 0.8, ', num2str(numStars3), ' stars'])

%% Ex2
%Case 1: 
% hy = fspecial('gaussian', [7 7], 1); 
% se = strel('square', 5);
% 
% %Case 2:
% hy = fspecial('sobel');
% se = strel('disk', 8);
% 
% %Case 3:
hy = fspecial('sobel');
se = strel('disk', 20);

% Step 1: Input
rgb = imread('Flowers.jpg');
I = rgb2gray(rgb);

% Step 2: Use the Gradient Magnitude as the Segmentation Function
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2); % Generate gradient distribution
L = watershed(gradmag);
Lrgb = label2rgb(L);

% Step 3: Mark the Foreground Objects
Io = imopen(I, se);
Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
Ioc = imclose(Io, se);
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fgm = imregionalmax(Iobrcbr);
I2 = I;
I2(fgm) = 255;
se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 20);
I3 = I;
I3(fgm4) = 255;

% Step 4: Compute Background Markers
bw = imbinarize(Iobrcbr);
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;

% Step 5: Compute the Watershed Transform of the Segmentation Function.
gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);

% Step 6: Visualize the Result
I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');

% Display the results
figure
subplot(2,3,1), imshow(rgb), title('Original Image');
subplot(2,3,2), imshow(bgm), title('Background Markers');
subplot(2,3,3), imshow(fgm4), title('Foreground Markers');
subplot(2,3,4), imshow(gradmag), title('Gradient Magnitude');
subplot(2,3,5), imshow(I4), title('Segmented Image');
subplot(2,3,6), imshow(Lrgb), title('Watershed Lines');

%% Ex 3
% Step 1: Input
I = imread('CoinsG.png');

% Step 2: Use the Gradient Magnitude as the Segmentation Function
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2); % Generate gradient distribution
L = watershed(gradmag);
Lrgb = label2rgb(L);

% Step 3: Mark the Foreground Objects
se = strel('disk', 20);
Io = imopen(I, se);
Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
Ioc = imclose(Io, se);
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fgm = imregionalmax(Iobrcbr);
I2 = I;
I2(fgm) = 255;
se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 20);
I3 = I;
I3(fgm4) = 255;

% Step 4: Compute Background Markers
bw = imbinarize(Iobrcbr);
D = bwdist(bw);
DL = watershed(D);
bgm = DL == 0;

% Step 5: Compute the Watershed Transform of the Segmentation Function.
gradmag2 = imimposemin(gradmag, bgm | fgm4);
L = watershed(gradmag2);

% Step 6: Visualize the Result
I4 = I;
I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
figure
subplot(141), imshow(I), title('Original coins image');
subplot(142), imshow(bgm), title('Watershed lines');
subplot(143), imshow(I4), title('Segmented');
subplot(144), imshow(Lrgb), title('Composed');

%% Ex4
% Load the binary image
ImB = imread('TestShapes.png');

Features = Object_Features_Extraction(ImB);

function [Features] = Object_Features_Extraction(ImB)
  
    [B, L] = bwboundaries(ImB);
    
    % plot object boundaries
    figure; imshow(ImB), hold on;
    for k = 1:length(B)
        boundary = B{k};
        plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
    end
    hold off;
    
    % label objects and plot labels on image
    [L, N] = bwlabel(ImB);
    ImC = label2rgb(L,'hsv',[.5 .5 .5],'shuffle');
    figure; imshow(ImC); hold on;
    for k = 1:N
        boundary = B{k};
        plot(boundary(:,2),boundary(:,1),'w','LineWidth',2);
        text(boundary(1,2)-11,boundary(1,1)+11, num2str(k), ...
            'color','yellow','FontSize',10,'FontWeight','bold');
    end
    hold off;
    
    % extract features for each object
    Stats = regionprops(L,'all');
    Features = uint16(zeros(N,8));
    for k = 1:N
        % compute thinness ratio
        area = Stats(k,1).Area;
        perimeter = Stats(k,1).Perimeter;
        thinness_ratio = 4*pi*area / (perimeter^2);
        
        % compute aspect ratio
        bounding_box = Stats(k,1).BoundingBox;
        aspect_ratio = bounding_box(3) / bounding_box(4);
        
        % save features in matrix
        Features(k,1) = k; % object #
        Features(k,2) = area;
        Features(k,3) = round(Stats(k,1).Centroid(1));
        Features(k,4) = round(Stats(k,1).Centroid(2));
        Features(k,5) = perimeter;
        Features(k,6) = Stats(k,1).EulerNumber;
        Features(k,7) = thinness_ratio;
        Features(k,8) = aspect_ratio;
    end
    
    % Display the Features matrix
    disp('Object# | Area | Centroid(1) | Centroid(2) | Perimeter | EulerNumber | ThinnessRatio | AspectRatio');
    disp(num2str(Features));
end





