clear all
clc
close all
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

Finic=500;                                  %Frecuencia inicial de chirp
FrecSalto=50;                               %delta-Frecuencia
tiemp=10;                                   % tiempo total (periodo) en segundos
deltiemp=1;                                 % delta-tiempo donde se producen los cambios en frecuencia en segundos, cambios de (FrecSalto)
FrecMax=Finic + FrecSalto*(tiemp/deltiemp); %frecuencia maxima alcanzada en tiempo total (periodo)
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Modulacion AM doble banda lateral
AmplitudSignal=1;
indicMod=0.5;                               %Indice de modulacion
AmplitudPort=AmplitudSignal/indicMod;       %Amplitud de portadora
Fp=FrecMax*4;                               %Frecuencia portadora para Modulacion AM
Tp=1/Fp;                                    %Periodo de la señal portadora

%Modulacion digital BPSK
Rb=FrecMax;                                 %Tasa de bits (bits/seg)
Tb=1/Rb;                                    %Tiempo de bit   
Ts=Tb;                                      %Tiempo de simbolo Ts=k*Tb
Rs=1/Ts;                                    %Tasa de simbolo (simb/seg) Rs=k*Rb
%Se deja fijo la energia de bit
Eb=2;                                       %Energia de bit
Es=Eb;                                      %Energia de simbolo Es=k*Eb

%Modulacion digital BFSK -- utiliza los mismos parametros pero tiene
%diferentes portadoras por simbolo
Fp1=2*Rs;
Fp2=3*Rs;

%Paso fijo para simulacion
Tsampling=Tp/100;
Fsampling=1/Tsampling;

sim('EsquemasModulacion_VersionR2016b.slx')
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Graficas temporales Modulacion AM
figure
subplot(2,1,1)
plot(tout,signal_BB)
xlim([0 40*Tp])
title('Señal chirp banda base')
subplot(2,1,2)
plot(tout,Envolvente_1)
hold on
plot(tout,Envolvente_2)
hold on
plot(tout,Signal_Mod_AM)
xlim([0 40*Tp])
title('Señal Modulada AM doble banda lateral con portadora de alta potencia')
%Graficas temporales Modulacion BPSK
figure
subplot(3,1,1)
plot(tout,Signal_Inf)
xlim([0 10*Tb])
title('Informacion binaria a transmitir')
subplot(3,1,2)
plot(tout,Signal_Mod_BPSK)
xlim([0 10*Tb])
title('Señal Modulada BPSK')
subplot(3,1,3)
plot(tout,Signal_Mod_BFSK)
xlim([0 10*Tb])
title('Señal Modulada BFSK')
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Estimacion Espectrales

L=40000;  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=0; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(signal_BB',Vent,Color,L,R,N,Fsampling);
title("Estimacion Espectral Chirp de informacion");
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
L=40000;  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=0; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_Mod_AM',Vent,Color,L,R,N,Fsampling);
title("Estimacion Espectral Señal Modulada AM");
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
L=400;  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=0; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_Mod_BPSK',Vent,Color,L,R,N,Fsampling);
title("Estimacion Espectral Señal Modulada BPSK");
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
L=400;  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=0; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_Mod_BFSK',Vent,Color,L,R,N,Fsampling);
title("Estimacion Espectral Señal Modulada BFSK");

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------


