function [Gp,SNRu,xr]=Cuantificador_DPCM_TCT(x,Nb,Emax,h1)
t1=clock;
%calculo de DPCM
e=zeros(length(x),1);
xe=zeros(length(x)+1,1);
xr=zeros(length(x),1);
eq=zeros(length(x),1);
for i=1:length(x)
     e(i)=x(i)-xe(i);
    [A_PCMNb,eq(i)]=Cuantificador_uniforme_TCT(e(i),Nb,Emax);
     xr(i)=xe(i)+eq(i);
      xe(i+1)=h1.*xr(i);    
end
Emax=max(abs(e));
e=zeros(length(x),1);
xe=zeros(length(x)+1,1);
xr=zeros(length(x),1);
eq=zeros(length(x),1);
for i=1:length(x)
     e(i)=x(i)-xe(i);
    [A_PCMNb,eq(i)]=Cuantificador_uniforme_TCT(e(i),Nb,Emax);
     xr(i)=xe(i)+eq(i);
     xe(i+1)=h1.*xr(i); 
end
%potencia de la señal
err=e-eq;
peq=(err')*(err)/length(err);
pe=(e'*e)/length(e);
%calculo SNRu
SNRu=10*log(pe/peq);


%calculo de GP
px=(x*x')/length(x);
Gp=10*log10(px/pe);

%%
%apartado b
disp("La ganancia de prediccion"+num2str(Gp)+"dB");
%%
t2=clock;
ttof=etime(t2,t1);
disp("tiempo de codificacion"+ttof+"s");
end