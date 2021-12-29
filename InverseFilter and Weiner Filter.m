function []= tuly_InWfilter2()
%read the image
f=imread('imageforhw3.jpg');
f = im2double(f);
[m n]=size(f);

%As a = 0.1; b = 0.1; T = 1, therefore len=68 and theta=135;
psf=fspecial('motion',68,135);
g=imfilter(f,psf,'circular');%motion blur

%generating white gaussian noise with mean 0 and unit variance
ns=0+sqrt(0.005).*randn(m,n);
g1=g+ns;

a = 0.1; b = 0.1; T = 1;
H=zeros(m,n);
for u=1:m
    for v=1:n
        A = pi.*(u.*a + v.*b);
        H(u,v) = (T./A).*sin(A).*exp(-1i.*A);
    end
end
%calculating FT of original image and noise function
F=fftshift(fft2(f));
%H=fftshift(fft2(psf))
N=fftshift(fft2(ns));
 
%Applying Inverse filter
IF=F+(N./H);
IF_final=ifftshift(ifft2(IF));
%plotting the degraded image
subplot(1,3,1),imshow(log(abs(g1)+1),[]);

%plotting the inverse filtered image
subplot(1,3,2),imshow(log(abs(IF_final)+1),[]);

%wiener filter
G=fftshift(fft2(g1));

%conjugate of N
conN=conj(N);
modN=N.*conN;

%conjugate of F
conF=conj(F);
modF=F.*conF;
k=zeros(688,688)+100;

%conjugate of H
conH=conj(H);
modH=H.*conH;

%w=wiener2(g1,[5 5]);
WF=((1./H).*((modH)./((modH)+k))).*G;
WF_final=ifftshift(ifft2(WF));
subplot(1,3,3),imshow(log(abs(WF_final)+1),[]);

