function [x4]=CONVCIR_TCT(x,h)
N=max(length(x),length(h));%buscamos el maximo
x=[x,zeros(1,N-length(x))];%reajustamos nuestras longitudes 
h=[h,zeros(1,N-length(h))];
X=DFT_TCT(x);
H=DFT_TCT(h);
CCONV=X.*H;%las convertimos a la frec y operamos
x4=real(IDFT_TCT_(CCONV));%calculamos nuestra idft 
figure;stem(x4);title('convolution of x(n) & h(n) mi fundcion');xlabel('---->n');ylabel('---->y(n)');grid;

end
