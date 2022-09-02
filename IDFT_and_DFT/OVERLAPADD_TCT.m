function [y1]=OVERLAPADD_TCT(x,h,L)

a=mod(length(x),L);%calculamos el resto(comprobamos que sea el resto 0)
x=[x zeros(1,L-a)];%normalizamos los vectores rellenando ceros(ajustamos rellenando ceros x para que sea =L)
n=length(x)/L;%calculamos n que sera un un entero (nº de bloques)

max_x=reshape(x,[L n]);%lo convertimos en vectores columna(partimos bloques)
max_x=max_x';%lo trasponemos (para hacer un uso de los mismos mas comprensible)
P=length(h);%calculamos la longitud de nuestro filtro (long filtro)
lconv=L+P-1;%la cantidad de ceros a sumar en cada vector(tamaño de bloque)
aux=zeros(n,lconv);%generamos un vector aux para las conv, en el que iremos volcando nuestros resultados(reserva de memoria)
y=zeros(1,lconv*n);%generamos un vector de ceros (auxiliar)

for i=1:n
    aux(i,:)=CONVLIN_TCT(max_x(i,:),h);%calculamos y volcamos la convolucion lineal por vector(pasamos bloque por bloque con el filtro para convolucionar )
end

for i=1:n
    ini=1+L*(i-1);% reajustamos
    fin=ini+lconv-1;% fin= (punto de inicio)+L+P-1
    y(ini:fin)=y(ini:fin)+aux(i,:);%vamos volcando en nuestra salida
end
y1=y(i:length(x));%volcamos en nuestra salida, convertimos la matriz de bloques en un vector
y1=real(y1);
end