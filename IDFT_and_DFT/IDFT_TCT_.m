function [x]=IDFT_TCT_(X_TCT)
N = length(X_TCT);%sacamos el tamaño de nuestro vector
x= zeros(length(X_TCT),1);%reservamos la memoria de nuestra salida
for k = 0:N-1
    for n = 0:N-1
        x(k+1) = (x(k+1) + X_TCT(n+1)*exp(j*2*pi*k*n/N));
    end
end
% t = 1:N;
x=real((x)/N);
%figure;plot(t,(x));title('señal reconstruida con nuestra formula IDFT');
end