clear all
clc
close all
%--------------------------------------------------------------------------
%Mostrando parametros generales y reproduciendo señal descargada de pagina
%web https://morsedecoder.com/es/
%--------------------------------------------------------------------------
filename='SOS.wav';
[Signal_audio,Fs] = audioread(filename);
disp("-------------------------------------Caracteristicas Generales-------------------------------------")
fprintf("La unidad temporal minima definida como punto tiene una duracion temporal de : %f seg \n",1/25 )
fprintf("La duracion de la linea equivale a tres puntos: %f seg \n", 3*1/25)
fprintf("Entre letras existe un silencion de %f seg y entre palabras %f seg \n",3*1/25,5*1/25 )
disp("----------------------------------------------------------------------------------------------------")
fprintf("\n \n \n")
disp("***************************************************************************************")
disp("... Señal descargada  ...")
disp("***************************************************************************************")
disp("....... Caracteristicas para realizar estimacion espectral Señal descargada ........")
fprintf("La frecuencia de muestreo del audio es: %f Hz \n",Fs)
fprintf("La cantidad de muestras que posee la señal es: %i \n", length(Signal_audio))
fprintf("La cantidad de segundos de audio son: %f seg \n", length(Signal_audio)/Fs)
fprintf("Con la frecuencia de Muestreo %i Hz, su equivalente en muestras para la unidad minima es: %i \n", Fs,round(Fs*1/25) )
disp("***************************************************************************************")
disp("Reproduciendo Audio")
disp("Cuando termine de escuchar el audio presione una tecla para continuar")
disp("***************************************************************************************")
sound(Signal_audio,Fs)
pause

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Etapa de modulacion:
fp=5000;                                            %Parametro modificable
tiemp=[0:1/Fs:(length(Signal_audio')*(1/Fs))-(1/Fs)];
indicMod=0.5;                                       %Parametro modificable, valores que van entre 0 y 1
AmplitudPort=max(abs(Signal_audio'))/indicMod;
Env_1=Signal_audio' + AmplitudPort;
Env_2=-1*(Signal_audio')- AmplitudPort;
port=1*cos(2*pi*fp.*tiemp);
Signal_Mod=Signal_audio'.*port + AmplitudPort*port;

%Nos quedamos con las señal descargada y modulada sin ruido en una variable
Signal_Mod_Des=Signal_Mod;
%Generamos Señal con ruido AWGN
SNR=2;                                             %Parametro modificable, Especificamos la relacion señal a ruido en dB
Signal_Mod_noise=awgn(Signal_Mod_Des,SNR,'measured');
%--------------------------------------------------------------------------
%Guardamos señal modulada para exportar
%--------------------------------------------------------------------------
filename="Señal descargada_Modulada.wav";
audiowrite(filename,Signal_Mod,Fs);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Realizamos analisis de las señales en el dominio temporal 
% Figura 1
figure
subplot(1,3,1)
plot(tiemp,Signal_audio')
title('Señal descargada')
xlabel('Muestras de la señal')
ylabel('Amplitud')
subplot(1,3,2)
plot(tiemp,Signal_Mod)
hold on
plot(tiemp,Env_1)
hold on
plot(tiemp,Env_2)
title('Señal Modulada')
xlabel('tiempo')
ylabel('Amplitud')
legend('Señal modulada','Envolvente 1', 'Envolvente 2')
subplot(1,3,3)
plot(tiemp,Signal_Mod_Des)
hold on
plot(tiemp,Signal_Mod_noise)
legend('Señal Original','Señal con AWGN')
title('Comparacion señal modulada con y sin rudio')
xlabel('tiempo')
ylabel('Amplitud')
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Estimaciones espectrales
% Figura 2
L=round((Fs*1/25)/4);  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=1; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_audio',Vent,Color,L,R,N,Fs);
title('Estimacion Espectral Señal descargada ');

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Estimaciones espectrales
% Figura 3
L=round((Fs*1/25)/4);  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=1; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_Mod,Vent,Color,L,R,N,Fs);
title('Estimacion Espectral Señal descargada y modulada ');

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Estimaciones espectrales
% Figura 4
L=round((Fs*1/25)/4);  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=1; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_Mod_noise,Vent,Color,L,R,N,Fs);
title('Estimacion Espectral Señal descargada y modulada con ruido AWGN ');

%--------------------------------------------------------------------
%---------------------- iniciando procesamiento ---------------------
%--------------------------------------------------------------------
fprintf("\n \n \n")
filename='Mensaje_Morse.wav';
[Signal_audio,Fs] = audioread(filename);
disp("***************************************************************************************")
disp("... Señal capturada por microfono ...")
disp("***************************************************************************************")
disp("....... Caracteristicas para realizar estimacion espectral Señal capturada por microfono ........")
fprintf("La frecuencia de muestreo del audio es: %f Hz \n",Fs)
fprintf("La cantidad de muestras que posee la señal es: %i \n", length(Signal_audio))
fprintf("La cantidad de segundos de audio son: %f seg \n", length(Signal_audio)/Fs)
disp("***************************************************************************************")
disp(" Reproduciendo Audio ")
disp("Cuando termine de escuchar el audio presione una tecla para continuar")
disp("***************************************************************************************")
sound(Signal_audio,Fs)
pause
fprintf("\n \n \n")
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Etapa de modulacion:
fp=5000;                                                 %Parametro modificable
indicMod=0.5;                                            %Parametro modificable, valores que van entre 0 y 1
AmplitudPort=max(abs(Signal_audio'))/indicMod;
tiemp=[0:1/Fs:(length(Signal_audio')*(1/Fs))-(1/Fs)];
Env_1=Signal_audio' + AmplitudPort;
Env_2=-1*(Signal_audio')- AmplitudPort;
port=1*cos(2*pi*fp.*tiemp);
Signal_Mod=Signal_audio'.*port + AmplitudPort*port;

%Nos quedamos con las señal capturada y modulada sin ruido en una variable
Signal_Mod_Cap=Signal_Mod;
%Generamos Señal con ruido AWGN
SNR=2;                                             %Parametro modificable, Especificamos la relacion señal a ruido en dB
Signal_Mod_noise=awgn(Signal_Mod_Cap,SNR,'measured');

%--------------------------------------------------------------------------
%Guardamos señal modulada para exportar
%--------------------------------------------------------------------------
filename="Señal_Capturada_por_microfono_y_modulada.wav";
audiowrite(filename,Signal_Mod,Fs);
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Realizamos analisis de las señales en el dominio temporal 
%figura 5
figure
subplot(1,3,1)
plot(tiemp,Signal_audio')
title('Señal capturada por microfono')
xlabel('tiempo')
ylabel('Amplitud')
subplot(1,3,2)
plot(tiemp,Signal_Mod)
hold on
plot(tiemp,Env_1)
hold on
plot(tiemp,Env_2)
title('Señal capturada por el microfono y Modulada')
xlabel('tiempo')
ylabel('Amplitud')
legend('Señal modulada','Envolvente 1','Envolvente 2')
subplot(1,3,3)
plot(tiemp,Signal_Mod_Cap)
hold on
plot(tiemp,Signal_Mod_noise)
legend('Señal Original','Señal con AWGN')
title('Comparacion señal modulada con y sin rudio')
xlabel('tiempo')
ylabel('Amplitud')
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%estimacion espectral
%figura 6
L=round((Fs*1/25)/4);  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=1; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_audio(2*Fs:4*Fs)',Vent,Color,L,R,N,Fs);
title('Estimacion Espectral Señal capturada por microfono');

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Estimacion espectral 
%Figura 7
L=round((Fs*1/25)/4);  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=1; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_Mod,Vent,Color,L,R,N,Fs);
title('Estimacion Espectral Señal capturada por microfono');

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%Estimaciones espectrales
% Figura 8
L=round((Fs*1/25)/4);  %Longitud de la ventana

R=L;      %Salto entre ventana y ventana

Vent=1;  %1 -> Rectangular
         %2 -> Triangular
         %3 -> Hamming
         %4 -> Hanning
         %5 -> Blackman
         
Color=1; %1 -> Color RGB
         %0 o cualquier numero -> Color en Grises
         
N=L;  %Cantidad de Muestras para la DFT

Espectrogram(Signal_Mod_noise,Vent,Color,L,R,N,Fs);
title('Estimacion Espectral Señal capturada por microfono y modulada con ruido AWGN ');

fprintf("\n \n \n \n")
%--------------------------------------------------------------------------
%Mostrando referencias por consola
%--------------------------------------------------------------------------

fprintf("/////////////////////REFERENCIAS FIGURAS///////////////////// \n")

fprintf("Figura 1 --> Analisis en tiempo de señal descargada en banda base,modulacion AM-DBL-CP y modulacion con ruido \n")
fprintf("Figura 2 --> Estimacion espectral de señal descargada en banda base \n")
fprintf("Figura 3 --> Estimacion espectral de señal descargada y modulada \n")
fprintf("Figura 4 --> Estimacion espectral de señal descargada y modulada con ruido AWGN \n")
fprintf("Figura 5 --> Analisis en tiempo de señal capturada por microfono en banda base,modulacion AM-DBL-CP y modulacion con ruido \n")
fprintf("Figura 6 --> Estimacion espectral de señal capturada por microfono en banda base \n")
fprintf("Figura 7 --> Estimacion espectral de señal capturada por microfono y modulada \n")
fprintf("Figura 8 --> Estimacion espectral de señal capturada por microfono y modulada con ruido AWGN \n")
fprintf("\n \n \n \n")

fprintf("finalizo el Script \n")

