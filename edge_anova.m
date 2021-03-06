clear all
clc
%definitions -
%mu1 - average of the first horizontal sample space
%mu2 - average of the second horizontal sample space
%mu3 - average of the first vertical sample space
%mu4 - average of the second horizontal sample space
%mu_av - the average of the averages
%varsam - the variance between sample spaces
%samvar - the variance within the sample space
%samvarpool - average of samvar
%F - the F distribution calculation

disp('Choose your image')
image= uigetfile(['*.jpg'],'D:\Desktop');
A=imread(image);
d = A;
d = im2double(d);
%resize is added as a temporary solution to large images
%d=imresize(d,0.5);
[m,n] = size(d);
sampoolthresh = 0.001;
Fnum = 10;
for i = 3:m-2     
    for k = 3:n-2
        %edge detection using variance in the horizontal detection
        mu1(i-2,k-2) = (d(i-2,k-2) + d(i-2,k-1) + d(i-2,k) + d(i-2,k+1) + d(i-2,k+2) + d(i-1,k-2) + d(i-1,k-1) + d(i-1,k) + d(i-1,k+1) + d(i-1,k+2))/10;
        mu2(i-2,k-2) = (d(i+1,k-2) + d(i+1,k-1) + d(i+1,k) + d(i+1,k+1) + d(i+1,k+2) + d(i+2,k-2) + d(i+2,k-1) + d(i+2,k) + d(i+2,k+1) + d(i+2,k+2))/10;
        mu_av(i-2,k-2) = (mu1(i-2,k-2)+mu2(i-2,k-2))/2;
        varsam(i-2,k-2) = 10*((mu1(i-2,k-2)-mu_av(i-2,k-2))^2 + (mu2(i-2,k-2)-mu_av(i-2,k-2))^2);
        samvar1(i-2,k-2) = ((d(i-2,k-2) - mu1(i-2,k-2))^2 + (d(i-2,k-1) - mu1(i-2,k-2))^2 + (d(i-2,k) - mu1(i-2,k-2))^2 + (d(i-2,k+1) - mu1(i-2,k-2))^2 + (d(i-2,k+2) - mu1(i-2,k-2))^2 + (d(i-1,k-2) - mu1(i-2,k-2))^2 + (d(i-1,k-1) - mu1(i-2,k-2))^2 + (d(i-1,k) - mu1(i-2,k-2))^2 + (d(i-1,k+1) - mu1(i-2,k-2))^2 + (d(i-1,k+2) - mu1(i-2,k-2))^2)/9;
        samvar2(i-2,k-2) = ((d(i+1,k-2) - mu2(i-2,k-2))^2 + (d(i+1,k-1) - mu2(i-2,k-2))^2 + (d(i+1,k) - mu2(i-2,k-2))^2 + (d(i+1,k+1) - mu2(i-2,k-2))^2 + (d(i+1,k+2) - mu2(i-2,k-2))^2 + (d(i+2,k-2) - mu2(i-2,k-2))^2 + (d(i+2,k-1) - mu2(i-2,k-2))^2 + (d(i+2,k) - mu2(i-2,k-2))^2 + (d(i+2,k+1) - mu2(i-2,k-2))^2  + (d(i+2,k+2) - mu2(i-2,k-2))^2)/9;
        
		%edge detection using variance in the vertical detection
        mu3(i-2,k-2) = (d(i-2,k-2) + d(i-2,k-1) + d(i-1,k-2) + d(i-1,k-1) + d(i,k-2) + d(i,k-1) + d(i+1,k-2) + d(i+1,k-1) + d(i+2,k-2) + d(i+2,k-1))/10;
        mu4(i-2,k-2) = (d(i-2,k+1) + d(i-2,k+2) + d(i-1,k+1) + d(i-1,k+2) + d(i,k+1) + d(i,k+2) + d(i+1,k+1) + d(i+1,k+2) + d(i+2,k+1) + d(i+2,k+2))/10;
        mu_avh(i-2,k-2) = (mu3(i-2,k-2)+mu4(i-2,k-2))/2;
        varsamh(i-2,k-2) = 10*((mu3(i-2,k-2)-mu_avh(i-2,k-2))^2 + (mu4(i-2,k-2)-mu_avh(i-2,k-2))^2);
		
        samvar3(i-2,k-2) = ((d(i-2,k-2) - mu3(i-2,k-2))^2 + (d(i-2,k-1) - mu3(i-2,k-2))^2 + ...
			(d(i-1,k-2) - mu3(i-2,k-2))^2 + (d(i-1,k-1) - mu3(i-2,k-2))^2 +...
            (d(i,k-2) - mu3(i-2,k-2))^2 + (d(i,k-1) - mu3(i-2,k-2))^2 + ...
            (d(i+1,k-2) - mu3(i-2,k-2))^2 + (d(i+1,k-1) - mu3(i-2,k-2))^2 + ...
            (d(i+2,k-2) - mu3(i-2,k-2))^2 + (d(i+2,k-1) - mu3(i-2,k-2))^2)/9;
			
        samvar4(i-2,k-2) = ((d(i-2,k+1) - mu4(i-2,k-2))^2 + (d(i-2,k+2) - mu4(i-2,k-2))^2 + ...
            (d(i-1,k+1) - mu4(i-2,k-2))^2 + (d(i-1,k+2) - mu4(i-2,k-2))^2 + ...
            (d(i,k+1) - mu4(i-2,k-2))^2 + (d(i,k+2)  - mu4(i-2,k-2))^2 + ...
            (d(i+1,k+1) - mu4(i-2,k-2))^2 + (d(i+1,k+2) - mu4(i-2,k-2))^2 + ...
            (d(i+2,k+1)- mu4(i-2,k-2))^2 + (d(i+2,k+2) - mu4(i-2,k-2))^2)/9;
			
        %check to see if the horizontal pooled variance is too small or close to zero
        samvarpool(i-2,k-2) = (samvar1(i-2,k-2) + samvar2(i-2,k-2))/(2);
		
        %if its large enough ...
        
		if samvarpool(i-2,k-2)>sampoolthresh
           F(i-2,k-2) = varsam(i-2,k-2)/samvarpool(i-2,k-2);
        else
           %if not, the variance was small so set the F number to zero 
           F(i-2,k-2) = 0;
        end
		
        %check to see if the vertical pooled variance is too small or close to zero
        samvarpoolh(i-2,k-2) = (samvar3(i-2,k-2) + samvar4(i-2,k-2))/(2);
		
        %if its large enough ...
        if samvarpoolh(i-2,k-2)>sampoolthresh
           Fh(i-2,k-2) = varsamh(i-2,k-2)/samvarpoolh(i-2,k-2);
        else
           %if not, the variance was small so set the F number to zero 
           Fh(i-2,k-2) = 0;
        end
    end
end
[m1,n1]=size(samvar1);
%create holding image
hol = zeros(m1,n1);
ind1 = find(F>Fnum);
ind2 = find(Fh>Fnum);
hol(ind1)=1;
hol(ind2)=1;
%thin out the edge
hol = bwmorph(hol,'thin',10);
%make egde image the same size as the original
final = zeros(m,n);

final(3:m-2,3:n-2) = hol;

[a,b]=size(final);
c=b/3;
for i=1:a
    for k=1:c
    f1(i,k)=final(i,k);
    f2(i,k)=final(i,k+c);
    f3(i,k)=final(i,k+2*c);
    end
end
final = f1 + f2 + f3;


%WITHOUT ANOVA
% I=A;
% threshold = 0.01;
% BW1=im2bw(I,threshold);
% BW2=bwperim(BW1);

figure,imshow(A),title('Original Image','FontSize',16,'FontWeight','bold')
% figure,imshow(BW2),title(['WITHOUT ANOVA with Threshold ',num2str(threshold)],'FontSize',16,'FontWeight','bold')
figure,imshow(final),title(['ANOVA Algorithm with Threshold ',num2str(sampoolthresh)],'FontSize',16,'FontWeight','bold')