[x1,fs]=audioread("BASS36.wav");
[x2,fs]=audioread("BASS39.wav");
[x3,fs]=audioread("BASS3639.wav");
%%
%apartado a
X1=fft(x1,4*length(x1))/length(x1);
X1_abs=abs(X1);
f=-fs/2:fs/(length(X1)-1):fs/2;
figure;plot(f,fftshift(X1_abs));xlim([-fs/2 fs/2]);

X2=fft(x2,4*length(x2))/length(x2);
X2_abs=abs(X2);
f=-fs/2:fs/(length(X2)-1):fs/2;
figure;plot(f,fftshift(X2_abs));xlim([-fs/2 fs/2]);

X3=fft(x3,4*length(x3))/length(x3);
X3_abs=abs(X3);
f=-fs/2:fs/(length(X3)-1):fs/2;
figure;plot(f,fftshift(X3_abs));xlim([-fs/2 fs/2]);
%%
%apartado b
f0=100;
fs=16000;
L=1024;
t=0:1/fs:L/fs;
x=cos(2*pi*f0*t);
 %apartado b.a
 
 xw1=x.*ones(L,1);
 xw2=x.*hamming(L);
 xw3=x.*hanning(L);
 figure;plot(t,Xw1);
 hold on;
 plot(t,Xw2);
 hold on;
 plot(t,Xw3);
 hold on;
 plot(t,x);
 hold off;
 
 %apartado b.b
 
Xw1=fft(xw1,16*length(xw1))/length(xw1);
Xw1_abs=abs(Xw1);
f=-fs/2:fs/(length(Xw1)-1):fs/2;
figure;plot(f,20*log10(fftshift(Xw1_abs)));hold on;

Xw2=fft(xw2,16*length(xw2))/length(xw2);
Xw2_abs=abs(Xw2);
f=-fs/2:fs/(length(Xw2)-1):fs/2;
plot(f,20*log10(fftshift(Xw2_abs)));hold on;

Xw3=fft(xw3,16*length(xw3))/length(xw3);
Xw3_abs=abs(Xw3);
f=-fs/2:fs/(length(Xw3)-1):fs/2;
plot(f,20*log10(fftshift(Xw3_abs)));hold off;

%%
% ¿Qué se observa cuando se utiliza la ventana w[n] rectangular? Justifique la
% respuesta atendiendo a criterios de anchura de lóbulo principal, fugas y
% localización espectral
% 
% . ¿Qué se observa cuando se utiliza la ventana w[n] de Hamming? Justifique la
% respuesta atendiendo a criterios de anchura de lóbulo principal, fugas y
% localización espectral

% ¿Qué se observa cuando se utiliza la ventana w[n] de Hanning? Justifique la
% respuesta atendiendo a criterios de anchura de lóbulo principal, fugas y
% localización espectral
%%
% c) Considerado una señal suma de dos sinusoides a f0=100Hz y f1=110Hz como la señal de entrada
% x[n]=cos(2*pi*f0*t) + cos(2*pi*f1*t), fs=16KHz, representar el módulo de la TF de la señal
% xw[n] enventanada con una ventana de hamming de L=1024 muestras mostrando Hz en el eje de 
% 2
f0=100;f1=110;fs=16000;
L=1024;
t=0:1/fs:L/fs;
x=cos(2*pi*f0*t) + cos(2*pi*f1*t);
xW=x.*hamming(L);
XW=fft(xW,4*length(xW))/length(xW);
XW_abs=abs(XW);
f=-fs/2:fs/(length(XW)-1):fs/2;
figure;plot(f,fftshift(XW_abs));
% frecuencias. ¿Qué ocurre? ¿Existe resolución suficiente para detectar los picos espectrales
% existente? ¿Cuál es la resolución en Hz? ¿Cuál es la separación, en Hz, entre los picos
% espectrales de las dos notas musicales? Justifique la respuesta. Para todos los apartados de este
% ejercicio, utilizar una DFT de 4 veces el número de muestras que la señal enventanada.
% a. Representar el módulo de la TF de la señal x[n] enventanada con una ventana de
% hamming de L=512 muestras mostrando Hz en el eje de frecuencias. ¿Qué ocurre
% respecto al apartado c) ? ¿Ha aumentado la resolución? ¿Cuál es la resolución en Hz?
% Justifique la respuesta
% b. Representar el módulo de la TF de la señal x[n] enventanada con una ventana de
% hamming de L=2048 muestras mostrando Hz en el eje de frecuencias. ¿Qué ocurre
% respecto al apartado c) ? ¿Ha aumentado la resolución? ¿Cuál es la resolución en Hz?
% Justifique la respuesta
% c. A partir de la señal enventanada con L=2048 muestras, añada 4096 ceros de modo que
% la nueva señal enventanada presente un tamaño de 6144. Calcule la DFT24576. ¿Cuál es
% la nueva resolución en Hz? ¿Ha aumentado la nueva resolución con respecto a la
% resolución de la señal sin añadir ceros? Justifique la respuesta. c) Considerado una señal suma de dos sinusoides a f0=100Hz y f1=110Hz como la señal de entrada
% x[n]=cos(2*pi*f0*t) + cos(2*pi*f1*t), fs=16KHz, representar el módulo de la TF de la señal
% xw[n] enventanada con una ventana de hamming de L=1024 muestras mostrando Hz en el eje de 
% 2
% frecuencias. ¿Qué ocurre? ¿Existe resolución suficiente para detectar los picos espectrales
% existente? ¿Cuál es la resolución en Hz? ¿Cuál es la separación, en Hz, entre los picos
% espectrales de las dos notas musicales? Justifique la respuesta. Para todos los apartados de este
% ejercicio, utilizar una DFT de 4 veces el número de muestras que la señal enventanada.
% a. Representar el módulo de la TF de la señal x[n] enventanada con una ventana de
% hamming de L=512 muestras mostrando Hz en el eje de frecuencias. ¿Qué ocurre
% respecto al apartado c) ? ¿Ha aumentado la resolución? ¿Cuál es la resolución en Hz?
% Justifique la respuesta
% b. Representar el módulo de la TF de la señal x[n] enventanada con una ventana de
% hamming de L=2048 muestras mostrando Hz en el eje de frecuencias. ¿Qué ocurre
% respecto al apartado c) ? ¿Ha aumentado la resolución? ¿Cuál es la resolución en Hz?
% Justifique la respuesta
% c. A partir de la señal enventanada con L=2048 muestras, añada 4096 ceros de modo que
% la nueva señal enventanada presente un tamaño de 6144. Calcule la DFT24576. ¿Cuál es
% la nueva resolución en Hz? ¿Ha aumentado la nueva resolución con respecto a la
% resolución de la señal sin añadir ceros? Justifique la respuesta. 