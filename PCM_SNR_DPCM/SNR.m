function [SNR]=SNR(x,xq)
%potencia de la señal
px=sum(x.^2)/length(x);
%potencia de error/ruido
eq=x-xq';
peq=sum(eq.^2)/length(eq);
%calculo SNR
SNR=10*log10(px/peq);

end