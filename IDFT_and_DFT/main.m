%{
vamos a realizar la convolucion circular a distintas señales normalmente
seran de audio, calculo de DFT
x(k)=sum(x[n]*e^(j*(2pi/N)*k*n))
si no me dicen nada , tenemos que calcular el numero de muestras que tiene
la señal, como parametro de entrada, se proporciona 
[X_TCT,Xabs_TCT,Xang_TCT]=DFT_TCT(x);
salida=
    1=dft compleja
    2=modulo
    3=fase
el coste computacional alto: vamos a implemetar 2 for, 1 for anidado que
recorra indices anidados y el segundo recorre el sumatorio
x[n]=1/N sum(X(k)e^(j*(2pi/N)*k*n)), tenemos que quedarnos con la parte
real, tenemos dos comandos, real o por modulo y fase o el modulo por el
coseno de la fase, la aplicamos para tener una señal en el dominio real

laIDFT SOLAMENTE TENEMOS QUE TENEREN CUENTA EL FACTOR DE PONDERACION DE n Y
LA PARTE IMAGINARIA 
Comprobar con fft y ifft
cogemos las dos señales, calculamos N luego la DFT , las multiplicamos en
frecuencia y tenemos nuestra señal de saluda o sea la convolucion lineal de
nuestro sistema 
TENEMOS UN CONJUNTO DE EXPONENCIALES EQUIDISTANCIADAS ENTRE SI , REPARTIDAS
ENTRE SI A LA MISMADISTANCIA ,EL PRIMER COEFICIENTE ES EL MAS PEQUEÑO YA
QUE LA FRECUENCIA SERA MAYOR CUANDO VAYAMOS AUMENTANDO 
%}
%%   parte 1
%definimos nuestra señal
f=100;
fs=1000;
t=0:1/fs:5;
x=3*sin(f*2*pi*t);
%calculos
[X_TCT,Xabs_TCT,Xang_TCT]=DFT_TCT(x);
[x1]=IDFT_TCT_(X_TCT);

%comprobante
X=fft(x,length(x))/length(x);
figure;subplot(121);plot(fftshift(abs(X)));title('FFT');
subplot(122);plot(ifft(X)*length(x));title(' IFFT(señal original)');
figure;plot(x,'o');hold on;plot(ifft(X)*length(x));plot((x1),'x');legend('señal original','señal con ifft','señal calculada');hold off
% X=ifft(x,length(x))/length(x);
% figure;plot(fftshift(abs(X)));title('nuestra IFFT');

%%  parte 2
%convolucion lineal
x1 = [1 0 6];
x2 = [2 1 0];
x3=CONVLIN_TCT(x1,x2);%mi convolucion 
x4=conv(x1,x2);
figure;stem(x4);title('convolution of x(n) & h(n) is :');xlabel('---->n');ylabel('---->y(n)');grid;


figure;plot(abs(x3),'x');hold on;plot(x4,'o');legend('señal convolucionada formula','conv');hold off;

%convolucion circular
x1 = [1 2 -1 1 5 8]; x2 = [1 1 2 1 2 2 1 1]; 
x3=CONVCIR_TCT(x1,x2);

N=max(length(x1),length(x2));
x4=cconv(x1,x2,N);
figure;stem(x4);title('convolution of x(n) & h(n) is :');xlabel('---->n');ylabel('---->y(n)');grid;
figure;plot(abs(x3),'x');hold on;plot(x4,'o');legend('señal convolucionada formula','conv');grid;hold off;

%%   parte 3
load h.mat;
[x,fx]=audioread('Scarecrow.wav');%cargamos nuestro fichero inicial de audio
x=x';
fs=16000;%frecuencia de muestra

[H_filter,~,~]=DFT_TCT(h);%calculamos nuestra DFT del filtro
f=-fs/2:fs/(length(h)-1):fs/2;%vector frecuencias
%figure;plot(f,fftshift(Habs_TCT));xlabel('frecuencia');ylabel('fase');title('dominio de la frecuencia(mod como fft)');
L=(max(512,2.^nextpow2(length(h))));%L=al maximo entre 512 y la potencia de 2^nºsegmento
t1=clock;%empieza el reloj
y1=OVERLAPADD_TCT(x,h,L);%Fun.
t2=clock;%termina el reloj
ttof=etime(t2,t1);
disp("tiempo de codificacion"+ttof+"s");
t=0:1/fs:length(x)/fs;
figure;plot((y1),'x');hold on;plot(x);legend('Señal OVERLAPADD','Señal original');hold off;

audiowrite('Scarecrow_conv.wav',(y1),fs);

t1=clock;
y2=conv(x,h);%funcion conv
t2=clock;
ttof=etime(t2,t1);
figure;plot((y1),'o');hold on;plot(y2,'x');legend('OVERLAPADD','CONV');hold off

%{
¿Qué diferencias encuentra entra la señal de audio de entrada y la señal de audio de
salida del filtrado? 
El tamaño de las señales, tambien, el sonido que se ha conseguido, que
se asemeja a la linea telefonica 
%}

%{
tiempo de codificacion con mi funcion:
238.894s-283s

conv:
0.787s
%}
