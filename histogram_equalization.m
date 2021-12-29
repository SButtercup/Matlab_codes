function [] = tuly_histeq()

[path,~]=imgetfile();%opens a file explorer prompt for choosing an image
A=imread(path);%reads an image

if (size(A,3)==3)%converts rgb to grayscale if the image is in rgb
    A=rgb2gray(A);
end
figure,imshow(A);    %shows original image
Img=A;               %copy image to keep the original one          


%Window size
disp('Enter the window size :')
wr=input('no of rows '); %takes input for row no of window 
wc=input('no of columns '); %takes input for column no of window 
    
%Find the number of rows and columns to be padded with zero
mid=round((wr*wc)/2);
count=0;
for k=1:wr
    for j=1:wc
        count=count+1;
        if(count==mid)
            PM=k-1;  %number of rows to be padded 
            PN=j-1;  %number of columns to be padded
            break;
        end
    end
end

%Padding all sides with zero
B=padarray(A,[PM,PN]);
imshow(B);

[M,N]=size(B);  % determining the size of the padded image

for k= 1:M-((PM*2)+1) 
    for j=1:size(B,2)-((PN*2)+1)
        cdf=zeros(256,1); %a column vector to store the no of occurance of an intesity level
        count=1;          % for tracking the number of pixels traversed
        for x=1:wr
             for y=1:wc
                %traversing the pixel in the window and record the
                 %occurance of an intesity
                dis=B(k+x-1,j+y-1)+1;
                cdf(dis)=cdf(dis)+1;
              %find the middle pixel and its intensity
                if(count==mid)
                    center_iLevel=B(k+x-1,j+y-1)+1;
                end
                count=count+1;
             end
        end
                
        %computing cdf for a window
        for p=1:255
            cdf(p+1)=cdf(p)+cdf(p+1);
        end
        %{
        determining the new intensity and assigning it to the respective
        point in the original image
        for k=0 to center_iLevel, find s=T(r)
        %}
        Img(k,j)=round(cdf(center_iLevel)/(wr*wc)*255);           
    end
end
figure,imshow(Img);

end
     
  
