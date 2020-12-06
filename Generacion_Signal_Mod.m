clc
clear all
close all

filename_in='Audio_a_modular.wav'; %----------->Nombre del archivo que contiene informacion, necesita estar en la misma carpeta que este script
filename_out='Audio_procesado.wav';%----------->Nombre del archivo sobre el que van a grabar la informacion procesada 
fp=5000;%-------------------------------------->Frecuencia portadora para generar la modulacion
m=0.5;%---------------------------------------->Indice de modulacion, valores de m: m>0 y m<=1
SNR=10;%---------------------------------------->Relacion señal a ruido, variable que permite controlar la cantidad de ruido presente en la señal
                                                %Valores: SNR>0 y SNR<50                                         
Mod_and_Noise(filename_in,filename_out,fp,m,SNR)