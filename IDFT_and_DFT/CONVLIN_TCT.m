function [x3]=CONVLIN_TCT(x,h)
%definimos parametros iniciales, reserva de memoria, longitudes...
L=length(x);
P=length(h);
x=[x,zeros(1,P+L-1-length(x))];%realmente es (1,P-1) ya que L se va con length(x)
h=[h,zeros(1,L+P-1-length(h))];
%calculamos la transformada de nuestra entrada y nuestro filtro
[X_TCT,~,~]=DFT_TCT(x);
[H_TCT,~,~]=DFT_TCT(h);
X3_TCT=X_TCT.*H_TCT;%operamos en frecuencia
x3=((IDFT_TCT_(X3_TCT)));%calculamos la antitransformada para dejarlo en dominio del tiempo


%figure;stem(x3);title('convolution of x(n) & h(n) is :');xlabel('---->n');ylabel('---->y(n)');grid;
%{
for i=1:L+P-1
x3(i)=0;
for j=1:L+P-1
if(j<i+1)
x3(i)=x3(i)+x(j)*h(i-j+1);
end
end
end
subplot(3,1,3);stem(x3);title('convolution of x(n) & h(n) is :');xlabel('---->n');ylabel('---->y(n)');grid;
%}
end


