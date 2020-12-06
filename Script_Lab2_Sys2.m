clc
close all
Fs=44100;

L=44100;  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=1; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=44100;  %Cantidad de Muestras para la DFT

Espectrogram(Sonido',Vent,Color,L,R,N,Fs);
title("Señal Original Capturada desde simulink ");

