function [A_PCMNb,xq]=Cuantificador_uniforme_TCT(x,Nb,Emax)

increment=(2*Emax)/Nb;

xq=zeros(1,length(x));

A_PCMNb=zeros(1,length(x));
for i=1:length(x)
    if x(i)>=Emax
        xq(i)=Emax-increment/2;
        A_PCMNb(i)=Nb-1;
    else
        if x(i) <= -Emax
            xq(i)= -Emax+increment/2;
            A_PCMNb(i)=0;
        else
            xq(i)=(fix(abs(x(i))/increment)+0.5)*increment*sign(x(i)+eps);
            A_PCMNb(i)=fix((x(i)+Emax)/increment);
        end
    end
end