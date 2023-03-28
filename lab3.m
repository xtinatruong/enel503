%% Ex1a
Im = imread('LennaGNoise.jpg');
Mask = [1/9 1/9 1/9; 1/9 1/9 1/9; 1/9 1/9 1/9];
% Uniform mask
Conv = imfilter (Im, Mask,'full','conv');
Corl = imfilter (Im, Mask,'full','corr');

subplot(1,3, 1), imshow(Im), title("Original");
subplot(1,3, 2), imshow(Conv), title("Convulution");
subplot(1,3, 3), imshow(Corl), title("Correlation");

%% Ex1b
A = imread('Moon.tif');
A = uint8(rgb2gray(A));

% Create a symmetric structuring element
B_symmetric = strel('disk', 2);
% Create an unsymmetric structuring element
B_unsymmetric = strel('line', 11, 90);

% Dilate A with B symmetric
AB_symmetricDilate = imdilate(A, B_symmetric);
% Dilate A with B unsymmetric
AB_unsymmetricDilate = imdilate(A, B_unsymmetric);

% Dilate the transpose of B with the transpose of A
B_symmetricADilate = imdilate(A', B_symmetric')';
% Dilate the transpose of B with the transpose of A
B_unsymmetricADilate = imdilate(A', B_unsymmetric')';

% Compare the results
isDilationCommutative = isequal(AB_symmetricDilate, B_symmetricADilate);
isDilationUnsymmetricCommutative = isequal(AB_unsymmetricDilate, B_unsymmetricADilate);


% Erode A with B symmetric
AB_symmetricErode = imerode(A, B_symmetric);
% Dilate A with B unsymmetric
AB_unsymmetricErode = imerode(A, B_unsymmetric);

% Dilate the transpose of B with the transpose of A
B_symmetricAErode = imerode(A', B_symmetric')';
% Dilate the transpose of B with the transpose of A
B_unsymmetricAErode = imerode(A', B_unsymmetric')';

% Compare the results
isErodeCommutative = isequal(AB_symmetricErode, B_symmetricAErode);
isErodeUnsymmetricCommutative = isequal(AB_unsymmetricErode, B_unsymmetricAErode);

subplot(4,3, 1), imshow(B_symmetricADilate), title("A⊕B where B is symmetrical ");
subplot(4,3, 2), imshow(AB_symmetricDilate), title("B⊕A where B is symmetrical");
subplot(4,3, 3), axis off, text(0.5,0.5, "A⊕B=B⊕A ? " + string(isDilationCommutative), "HorizontalAlignment","center");


subplot(4,3, 4), imshow(B_unsymmetricADilate), title("A⊕B where B is unsymmetrical ");
subplot(4,3, 5), imshow(AB_unsymmetricDilate), title("B⊕A where B is unsymmetrical");
subplot(4,3, 6), axis off, text(0.5,0.5, "A⊕B=B⊕A ? " + string(isDilationUnsymmetricCommutative), "HorizontalAlignment","center");

subplot(4,3, 7), imshow(B_symmetricAErode), title("A⊖B where B is symmetrical ");
subplot(4,3, 8), imshow(AB_symmetricErode), title("B⊖A where B is symmetrical");
subplot(4,3, 9), axis off, text(0.5,0.5, "A⊖B=B⊖A ? " + string(isErodeCommutative), "HorizontalAlignment","center");

subplot(4,3, 10), imshow(B_unsymmetricAErode), title("A⊖B where B is unsymmetrical ");
subplot(4,3, 11), imshow(AB_unsymmetricErode), title("B⊖A where B is unsymmetrical");
subplot(4,3, 12), axis off, text(0.5,0.5, "A⊖B=B⊖A ? " + string(isErodeUnsymmetricCommutative), "HorizontalAlignment","center");

%% 2
% Read the input image
Im = imread('Moon.tif');

% Add Gaussian noise to the input image
Inoi = imnoise(Im, 'gaussian', 0.01);

% Apply average filter to the noisy image
Fblur = fspecial('average', 5);
Iblur = imfilter(Inoi, Fblur);

% Compute the sharpened image using the algebraic model
SharpIm = (Im - Iblur) + Im;

% Display the original, noisy, blurred, and sharpened images
subplot(2, 2, 1);
imshow(Im);
title('Original Image');

subplot(2, 2, 2);
imshow(Inoi);
title('Noisy Image');

subplot(2, 2, 3);
imshow(Iblur);
title('Blurred Image');

subplot(2, 2, 4);
imshow(SharpIm);
title('Sharpened Image');

%% 3a
Im = imread('Statue.png');

%create mask
se = strel('disk', 2);

%create top and bottom hat images
ImTophat = imtophat(Im, se);
ImBottomhat = imbothat(Im, se);

%enhance image
ImEnhance = Im + ImTophat - ImBottomhat;

% Algorithm 2
closing = imclose(Im, se);
opening = imopen(Im, se);
temp = imsubtract(Im, opening);
enhanced2 = imadd(closing, temp);

% Display the input and enhanced images for both algorithms
figure;
subplot(1,3,1); imshow(Im); title('Input Image');
subplot(1,3,2); imshow(ImEnhance); title('Algorithm 1');
subplot(1,3,3); imshow(enhanced2); title('Algorithm 2');
%% 4
% Read the noisy image
Im = imread('LennaGNoise.jpg');

% Denoise using imgaussfilt
sigma = 2;
Ig = imgaussfilt(Im, sigma);

% Denoise using imfilter
kernel = fspecial('gaussian', [3 3], sigma);
If = imfilter(Im, kernel);
figure; 
% Display the original image
subplot(1,3,1); imshow(Im); title('Original Image');
subplot(1,3,2); imshow(Ig); title('Denoised Image - imgaussfilt');
subplot(1,3,3); imshow(If); title('Denoised Image - imfilter');

%% 5a
% Define the input string
Str = 'Hello World! This is my barcode.';

% Convert the string to ASCII code
ASCII = uint8(Str);

% Convert each ASCII code to an 8-bit binary representation
Bin = dec2bin(ASCII, 8);

% Reshape the binary representation into a 16x16 matrix of zeros and ones
Barcode = reshape(Bin.'-'0', 16, []);

% Display the barcode as an image
imshow(Barcode, 'InitialMagnification', 'fit');
%%
Barcode_string = char(bin2dec(reshape(char(Barcode+'0'), 8,[]).'));
subplot(1,1,1), axis off, text(0.5,0.5, Barcode_string, "HorizontalAlignment","center");

