% %1a) Load the six color images from directory folder
% Im = repmat({}, 6);
% Im1 = Im;
% Im1(1,1).image = imread('Fig1.jpg'); 
% Im1(1,2).image = imread('Fig2.jpg');
% Im1(1,3).image = imread('Fig12.jpg');
% Im1(1,4).image = imread('Rand1.jpg');
% Im1(1,5).image = imread('Rand2.jpg');
% Im1(1,6).image = imread('Mandrill.png');
% 
% %gray image array
% Im1G = repmat({}, 6);
% 
% %image names array to save as
% ImName = {'Fig1.jpg','Fig2.jpg','Fig12.jpg','Rand1.jpg','Rand2.jpg','Mandrill.png'};
% 
% %iterate to apply resizing and gray scale to each image
% for k = 1:length(Im1)
%     %1b) convert the given images into grayscale.
%     Im1G(1,k).image = rgb2gray(Im1(1,k).image);
% 
%     %1c) unify the sizes of the given images to 500 x 500 pixels 
%     Im1G(1,k).image = imresize(Im1G(1,k).image, [500 500]);
% 
%     %1c) Save onto hard disk. Naming files with "gray-" in the beginning 
%     %since if it's saved with the original name, grayscale conversion will
%     %give error on second run since the image is already gray
%     imwrite(Im1G(1,k).image, strcat("gray-",string(ImName(k))));
% 
%     %1c) plot the six normalized gray images
%     subplot(2,3,k);
% 
%     %1c) suitable titles
%     imshow(Im1G(1,k).image);
%     title(string(ImName(k)));
% end

% %2 convert Mandrill.png into the following 7 formats: C/G/B/SC/R1/G2/B3
% ImC = imread('Mandrill.png');   %C
% ImG = rgb2gray(ImC);            %G
% ImB = imbinarize(ImG, 0.4);     %B
% ImSC = grayslice(ImG, 16);      %SC
% ImRed = ImC(:, :, 1);           %R1
% ImGreen = ImC(:, :, 2);         %G2
% ImBlue = ImC(:, :, 3);          %B3
% 
% figure
% subplot (2,4,1), imshow (ImC), title('Color(RGB)');
% subplot (2,4,2), imshow (ImG), title('Gray');
% subplot (2,4,3), imshow (ImB), title('Binary');
% subplot (2,4,4), imshow (ImSC, jet(10)), title('Pseudocolor Image');
% subplot (2,4,5), imshow (ImC), title('Color(RGB)');
% subplot (2,4,6), imshow (ImRed), title('Red');
% subplot (2,4,7), imshow (ImGreen), title('Green');
% subplot (2,4,8), imshow (ImBlue), title('Blue');

% 3
% function [Kappa] = CharacteristicValues
% X = 500; Y = X;
% Kappa = zeros(1, 6);
% Imk = zeros (X, Y);
% Im = repmat({}, 6);
% % resize to 500x500 and turn it gray
% Im(1,1).image = imresize(rgb2gray(imread('Fig12.jpg')), [500 500]); 
% Im(1,2).image = imresize(rgb2gray(imread('Fig1.jpg')), [500 500]);
% Im(1,3).image = imresize(rgb2gray(imread('Fig2.jpg')), [500 500]);
% Im(1,4).image = imresize(rgb2gray(imread('Rand1.jpg')), [500 500]);
% Im(1,5).image = imresize(rgb2gray(imread('Rand2.jpg')), [500 500]);
% Im(1,6).image = imresize(rgb2gray(imread('Mandrill.png')), [500 500]);

% calculate kappa
% for k = 1 : 1:length(Im)
%     Sum = 0;
%     for i = 1 : X
%         for j = 1 : Y
%         Sum = Sum + abs(double(Im(1,k).image(i,j)));
%         end
%     end
%     Kappa(k) = Sum /(255*X*Y);
%     %plot the six normalized gray images
%     subplot(2,3,k);
% 
%     %suitable titles of Kappa
%     imshow(Im(1,k).image);
%     title(strcat("\kappa = ", string(round(Kappa(k),4))));
% end


%4 
function [Sim] = SimilarityDetermination
% Load Fig1, Fig2, and Fig12
X = 500; Y = X;
Sim = zeros(1, 7);
Imk = zeros (X, Y);
Im = repmat({}, 7);
Im(1,1).image = imresize(rgb2gray(imread('Fig1.jpg')), [500 500]); 
Im(1,2).image = imresize(rgb2gray(imread('Fig2.jpg')), [500 500]);
Im(1,3).image = imresize(rgb2gray(imread('Fig12.jpg')), [500 500]);
Im(1,4).image = imresize(rgb2gray(imread('Mandrill.png')), [500 500]);
Im(1,5).image = imresize(rgb2gray(imread('Rand1.jpg')), [500 500]);
Im(1,6).image = imresize(rgb2gray(imread('Rand2.jpg')), [500 500]);

% Similarity Test
for m = 1 : 1:length(Im)
    subplot(7,7, m+1);
    imshow(Im(1,m).image);
    subplot(7,7, (m)*7+1);
    imshow(Im(1,m).image);
    for k = 1 : 1:length(Im)
        Imk = Im(1,k).image;
        Sum = 0;
        for i = 1 : X
            for j = 1 : Y
            Sum = Sum + abs(double(Im(1,m).image(i,j))-double(Imk(i,j)));
            end
            Sim(k) = 1 - Sum /(255*X*Y);
        end
        subplot(7,7, (m)*7+(k+1));
        axis off;
        text(0.5,0.5, sprintf("\\sigma=%0.4f",Sim(k)),"HorizontalAlignment","center");
    end
end

% for i = 1:6
%      subplot(7,7, (i)*7+1);
%      imshow(Im);
%      subplot(7,7, i+1);
%      imshow(Im);
% %      [dims0, dims1] = size(im0);
% %      for ii = 1:6
% %          sum = 0;
% %          im1 = resized(1,ii).image;
% %          [dims2, dims3] = size(im1);
% %          % check to make sure the dimensions are the same
% %          if any([dims0, dims1] - [dims2, dims3])
% %          fprintf("Image dimensions for image %i and %i are not equal\n", i, ii);
% %          end
% %          for j = 1:dims0
% %              for k = 1:dims1
% %              sum = sum + abs(double(im1(j,k))-double(im0(j,k)));
% %              end
% %          end
% %          sigma = 1-sum/(255.0*dims0*dims1);
% %          subplot(7,7, (i)*7+(ii+1));
% %          axis off;
% %          text(0.5,0.5, sprintf("\\sigma=%0.4f",sigma),"HorizontalAlignment","center");
% %      end
% end

