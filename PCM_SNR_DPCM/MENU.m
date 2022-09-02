%señal 1

%{
-tiempo del codigo
-snr del ruidoPCM mejor que DPCM

%}
%%                          PCM                                                      senal1
fs=44100;
[senal,fs]=audioread('TDK.wav');
Nbits=input('indique el numero de bits de nuestro cuantificador');
Nb=2^Nbits;
Emax=max(abs(senal));
[A_PCMNb,senalq]=Cuantificador_uniforme_TCT(senal,Nb,Emax);%funcion
audiowrite(['PCMNB' num2str(Nbits) '.wav'],senalq,fs);%señal cuantificada
eq=senal-senalq';
%%
%apartado a
figure;plot(senal,'blue');hold on;plot(senalq,'red');plot(eq,'g');legend('señal original','señal cuantificada','error de cuantificacion');hold off;

%%
%apartado b
%calculo de SNR
if (5==Nbits)
SNR5bits=SNR(senal',senalq');
else
    SNR8bits=SNR(senal,senalq);
end
%{
tenemos 40.95dB de SNR para 5 bits y para 8 obtenemos 82.5dB con lo que
hace que tengamos una mayor calidad de sonido, siendo la misma el doble con
3 bits extra, haciendo una prueba subjetiva, el audio con 5 bits, se nota
que tiene una peor calidad que el de 8 bits, aunque si utilizamos 10 bits,
obtenemos 110dB, pero aun sigue sin ser un sonido limpio, en cambio cuando
usamos por ejemplo 15 bits, conseguimos un sonido limpio, tiene una SNR de
180dB, la verdadera diferncia aqui es que con 5 bits, obtenemos un numero
menor de niveles implicando menos valores de reconstruccion en cambio con
15 bits, obtenemos 3 veces mas valores de reconstruccion, haciendo que a la
hora de asignar un valor con su valor de reconstruccion, se acerque
bastante mas reduciendo el error de cuantificacion
 %}
%{
potN=(increment^2)/12;
potN=sum(eq.^2)/length(senal);
Como vemos tenemos dos maneras de calcular la potencia del ruido
%}

%%                                                                              UNIFORME
%señal 2
fs=44100;
t=10;
senalr=alea(fs,t);
%apartados
Nbits=input('indique el numero de bits de nuestro cuantificador');
Nb=2^Nbits;
Emax=max(abs(senalr));
[A_PCMNb,senalrq]=Cuantificador_uniforme_TCT(senalr,Nb,Emax);
audiowrite('RUIDO.wav',senalrq,fs);
eq=senalr-senalrq;
%apartado a
figure;plot(senalr,'blue');hold on;plot(senalrq,'red');plot(eq,'g');legend('señal original','señal cuantificada','error de cuantificacion');hold off;
%calculo de SNR
px=(senalr*senalr')/length(senalr);
%potencia de error/ruido
peq=(eq*eq')/length(eq);
%calculo SNR
SNRrr=10*log(px/peq);
disp(['la relación señal ruido es de ' num2str(SNRrr) 'dB']);
%SNR 
%68.6131
%autocorrelacion
%xcorr(senalr,senal)
stem(fliplr(xcorr(senalr,senal)));



%%                                  DPCM
%{
aplicamos el cuantificador uniformae, la señal de entrada es el error de
prediccion , vamos a dar dos vueltas, la primera vez es la señal disponible
x, el rango dinamico de la señal x, a la salida tenemos un error de
prediccion , aplicaremos otra vez el DPCM , con el error de precicion de
antes

ro1= normalizado vale RX(1)/RX(0), con esto la ganacia de prediccion va
aser total ro =correlacion en 1 y en 0;y es mi coeficiente optimo

la vamos a calcular la correlacion de la siguiente manera:
Rx(0)>=abs(Rx(O))
cogemos el xcorr()/(el tamaño de la señal que nos salga)


teoricamente la relacion señal ruido, en decibelos es la misma + el 10log
de la ganancia de perdidas incrementando unos db adicionales

Cuando calculamos la funcion de DPCM ,
Dudas que pueden surgir:
yo tengo e de la entrada al predictor y esa xr depende del valor de
prediccion cuantificado y tambien depende del canterior , como inicializo
xe(1)=0 erro de prediccion e=x-xe; 
%}

%%                                                                                      DPCM
fs=44100;
[senal,fs]=audioread('TDK.wav');
senal=senal';
Nbits=input('indique el numero de bits de nuestro cuantificador');
Nb=2^Nbits;
h1=input('indique el coeficiente del predictor');
Emax=max(abs(senal));
[Gp,SNRu,xr]=Cuantificador_DPCM_TCT(senal,Nb,Emax,h1);

%audiowrite(['DPCM' num2str(Nbits) '_a.wav'],xr,fs);%señal cuantificada

%%
%apartado a
figure;subplot(211);plot(senal,'blue');hold on;plot(xr,'red');plot(senal-xr','g');title("h1=0.2");legend('señal original','señal cuantificada','error de cuantificacion');hold off;

%% xcorr

[rx0,tm0]=xcorr(senal);
Rx0=abs(max(rx0));
muestra=find(rx0==Rx0);
Rx1=rx0(muestra+1);
ro=Rx1/Rx0;
[Gp,SNRu,xr]=Cuantificador_DPCM_TCT(senal,Nb,Emax,ro);
subplot(212);plot(senal,'blue');hold on;plot(xr,'red');plot(senal-xr','g');title("h1=ro");legend('señal original','señal cuantificada','error de cuantificacion');hold off;
audiowrite(['DPCM' num2str(Nbits) '_b.wav'],xr,fs);%señal cuantificada
figure;plot(tm0,rx0);title("autocorrelacion");


%%
%apartado C
%calculo de SNR
if (5==Nbits)
SNR5bits=SNR(senal,xr);
disp("la relacion señal ruido para DPCM Nb=5 y h1="+num2str(h1)+" es de :"+num2str(SNR5bits)+" dB");
else
    SNR8bits=SNR(senal,xr);
    disp("la relacion señal ruido para 8 bits y "+num2str(h1)+"es de :"+num2str(SNR8bits)+" dB");
end

%%
%apartado d
%{
calculo empirico
%}
%%
%apartado e
%{
DPCM hace uso de menos bits que PCM para codificar el mismo mensaje, DPCM
hace uso de menor ancho de banda a comparacion de PCM aunque presenta
retroalimentacion,con 5 bits y un coeficiente de 0.1, presenta una SNR de
41dB, en cambio en la misma situacion DPCM presenta 44dB en la misma
situacion, con lo cual, como vemos mejora la relacion SNR haciendo un error
de cuantificacion menor, tambien sabemos que en PCM la señal muestreada
contiene una elevada correlacion entre adyacentes, no cambia
sustancialmente, esto conlleva que la varianza de la señal es menor que la
real de la señal, esto hace que la señal PCM tenga informacion redundante
no indespensable para recuperar, pero con DPCM se tendra una codificacion
mas eficiente


%}
%%
%apartado f
%{
Si presentan una mejora notable en cuanto a nuestra relacion señal ruido,
usando ro nos encontramos con 63.44 dB, vemos que es el coeficiente
optimon ya que nuestra ganancia de prediccion es maxima,ya que el error de
prediccion es minimo 
%}
%%
%apartado g
%{
Si, ya que presentan un menor error de cuantificacion, con los cual la
calidad de la señal cuantificada en comparacion con su original , sera mas
semejante.
%}

%%                                                                            senal 2
fs=44100;
t=10;
senalr=alea(fs,t);
%apartados
Nbits=input('indique el numero de bits de nuestro cuantificador');
Nb=2^Nbits;
h1=input("indique h1=");
Emax=max(abs(senalr));
[A_PCMNb,senalrq]=Cuantificador_DPCM_TCT(senalr,Nb,Emax,h1);
audiowrite('RUIDO.wav',senalrq,fs);
eq=senalr-senalrq;
%apartado a
figure;plot(senalr,'blue');hold on;plot(senalrq,'red');plot(eq,'g');legend('señal original','señal cuantificada','error de cuantificacion');hold off;
%calculo de SNR
px=(senalr*senalr')/length(senalr);
%potencia de error/ruido
peq=sum(eq.^2)/length(eq);
%calculo SNR
SNRrr=10*log(px/peq);
disp(['la relación señal ruido es de ' num2str(SNRrr) 'dB']);
%SNR 
%68.6131
%% xcorr

[rx0,tm0]=xcorr(senalr);
[rx1,tm0]=xcorr(senalr);
Rx0=abs(max(rx0));
muestra=find(rx0==Rx0);
Rx1=rx0(muestra+1);
ro=Rx0/Rx1;
[Gp,SNRu,xr]=Cuantificador_DPCM_TCT(senal,Nb,Emax,ro);
subplot(212);plot(senalr,'blue');hold on;plot(xr,'red');plot(senalr-xr','g');title("h1=ro");legend('señal original','señal cuantificada','error de cuantificacion');hold off;
audiowrite(['DPCM' num2str(Nbits) '_b.wav'],xr,fs);%señal cuantificada
figure;plot(tm0,rx0);title("autocorrelacion");


%%
%autocorrelacion
%xcorr(senalr,senal)
stem(fliplr(xcorr(senalr,senal)));
%%69.31 y -1
