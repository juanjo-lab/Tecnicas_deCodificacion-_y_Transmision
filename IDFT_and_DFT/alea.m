%senal aleatoria 2
function [x]=alea(fs,tt)
t=0:1/fs:tt;
x=rand(1,length(t));
x=x-mean(x);
plot(t,x);title('ruido normalizado');legend('ruido');
end