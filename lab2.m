% ImC = imresize(imread('Mandrill.png'), [500 500]);
% ImG = rgb2gray(ImC);            %G
% ImR1 = ImC(:, :, 1);            %R1
% ImG2 = ImC(:, :, 2);            %G2
% ImB3 = ImC(:, :, 3);            %B3
% 
% ImGs = 0.2989*ImR1 + 0.5870*ImG2 + 0.1140*ImB3;
% 
% X = 500; Y = X;
% Sim = zeros(1, 7);
% Imk = zeros (X, Y);
% Im = repmat({}, 2);
% Im(1,1).image = ImG; 
% Im(1,2).image = ImGs;
% 
% 
% % Similarity Test
% for m = 1 : 1:length(Im)
%     subplot(3,3, m+1);
%     imshow(Im(1,m).image);  
%     if(m == 1); title("ImG"); else; title("ImGs");end
%     subplot(3,3, (m)*3+1);
%     imshow(Im(1,m).image);
%     if(m == 1); title("ImG"); else; title("ImGs");end
%     for k = 1 : 1:length(Im)
%         Imk = Im(1,k).image;
%         Sum = 0;
%         for i = 1 : X
%             for j = 1 : Y
%             Sum = Sum + abs(double(Im(1,m).image(i,j))-double(Imk(i,j)));
%             end
%             Sim(k) = 1 - Sum /(255*X*Y);
%         end
%         subplot(3,3, (m)*3+(k+1));
%         axis off;
%         text(0.5,0.5, sprintf("\\sigma=%0.4f",Sim(k)),"HorizontalAlignment","center");
%         text(0.5,0.5, sprintf("\n\n\\sigma difference =%0.4f",1-Sim(k)),"HorizontalAlignment","center");
%     end
% end


% Im1 = double(imread('Im21.jpg')); 
% Im2 = double(imread('Im22.jpg'));
% for k = 1:5
%     subplot(1,5,k);
%     image_morph = double(zeros(size(Im1)));
%     for l = 1:3
%         for i = 1 :size(Im1,1)
%             for j = 1 :size(Im1,2)
%                 image_morph(i,j,l) = Im2(i,j,l) + (1.0-(k-1.0)/5.0)*(Im1(i,j,l)-Im2(i,j,l));
%             end
%         end
%     end
%     imshow(uint8(image_morph));
%     title(string(k));
% end

% for k = 1:5
%     subplot(1,5,k);
%     for l = 1 : 1:length(Im1Layers)
%         morph = double(zeros(size(Im1)));
%         % allocate space for thresholded image
%         image_morph = double(zeros(size(Im1)));
%         for i = 1 :size(Im1,1)
%             for j = 1 :size(Im1,2)
%                 image_morph(i,j) = Im2Layers(1,l).image(i,j) + (1.0-(k-1.0)/5.0)*(Im1Layers(1,l).image(i,j)-Im2Layers(1,l).image(i,j));
%             end
%         end
%         ImMorph(1,l).image = image_morph;
%         morph = morph+image_morph;
%     end
%     imshow(uint8(morph));
%     title(string(k));
% end

% for k = 1:5
%     subplot(1,5,k);
%         for i = 1 : X
%             for j = 1 : Y
%                 Sum = Sum + abs(double(Im(1,m).image(i,j))-double(Imk(i,j)));
%             end
%             Sim(k) = 1 - Sum /(255*X*Y);
%         end
%     end
% end

% ImMorph = Im1+0.5*(Im2-Im1);
% ImMorph2 = Im2+0.5*(Im1-Im2);

%%
I = imread('Car1.jpg');
INoShadow = I;
INoShadowGray = rgb2gray(I);
[X,Y] = size (INoShadowGray);

SumShadow = 0;
for i = X-13:X-10
    for j = (Y/2):(Y/2)+4
        SumShadow = SumShadow + double(I(i,j));
    end
end
Tshadow = uint8(SumShadow/16);

%background
SumBackground = 0;
for i = X-20:X-11
    for j = Y-60:Y-51
        SumBackground = SumBackground  + double(I(i,j));
    end
end
Tbackground = uint8((SumBackground+50)/100);

for i = 90:180
    for j = 40:280
        if INoShadowGray(i,j) > Tshadow- 40 && INoShadowGray(i,j) < Tshadow 
            INoShadowGray(i,j) = Tbackground;
            INoShadow(i,j,1) = Tbackground;
            INoShadow(i,j,2) = Tbackground;
            INoShadow(i,j,3) = Tbackground;
        end
    end
end

subplot(1,3, 1), imshow("Car1.jpg"), title("Car");
subplot(1,3, 2), imshow(INoShadowGray), title("Shadow Removed (G)");
subplot(1,3, 3), imshow(INoShadow), title("Shadow Removed (C)");


