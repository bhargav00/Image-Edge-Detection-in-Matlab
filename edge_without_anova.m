disp('Choose your image')
image= uigetfile(['*.jpg'],'D:\Desktop');
I=imread(image);
% threshold = 0.001;
% BW1=im2bw(I,threshold);
% BW2=bwperim(BW1);
% figure,imshow(BW2),title(['WITHOUT ANOVA with Threshold ',num2str(threshold)],'FontSize',16,'FontWeight','bold')
figure,imshow(edge(I,'roberts')),title(['Roberts EDGE'],'FontSize',16,'FontWeight','bold');
figure,imshow(edge(I,'canny')),title(['CANNY EDGE'],'FontSize',16,'FontWeight','bold');