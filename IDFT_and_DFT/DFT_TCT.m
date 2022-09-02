function [X_TCT,Xabs_TCT,Xang_TCT]=DFT_TCT(x)
N = length(x);
X_TCT = zeros(length(x),1);
for k = 0:N-1
    for n = 0:N-1
        X_TCT(k+1) =X_TCT(k+1) + x(n+1)*exp(-j*2*pi*k*n/N);
    end
end
Xang_TCT=angle(X_TCT);
Xabs_TCT=abs(X_TCT);

% t = 1:N;
% figure;subplot(221);plot(t,x);xlabel('segundos');ylabel('amplitud');title('dominio del tiempo');
% subplot(222);plot(t,X_TCT);xlabel('Frecuencia');ylabel('modulo ');title('dominio de la frecuencia(img+real)');
% subplot(223);plot(t,Xang_TCT);xlabel('frecuencia');ylabel('fase');title('dominio de la frecuencia(fase)');
% subplot(224);plot(t,fftshift(Xabs_TCT));xlabel('frecuencia');ylabel('fase');title('dominio de la frecuencia(mod como fft)');
end