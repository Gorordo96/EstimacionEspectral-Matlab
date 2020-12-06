function []=Mod_and_Noise(filename_in,filename_out,fp,m,SNR)
[Signal_audio,Fs] = audioread(filename_in);
fprintf("____________________Procesando Audio_________________________________\n")
fprintf("La frecuencia de muestreo del audio es: %f Hz \n",Fs)
fprintf("La cantidad de muestras que posee la señal es: %i \n", length(Signal_audio))
fprintf("La cantidad de segundos de audio son: %f seg \n", length(Signal_audio)/Fs)
fprintf("______________________________________________________________________\n")
tiemp=[0:1/Fs:(length(Signal_audio')*(1/Fs))-(1/Fs)];
AmplitudPort=max(abs(Signal_audio'))/m;
port=1*cos(2*pi*fp.*tiemp);
Signal_Mod=Signal_audio'.*port + AmplitudPort*port;
Signal_Mod_noise=awgn(Signal_Mod,SNR,'measured');
audiowrite(filename_out,Signal_Mod_noise,Fs);
fprintf("...................Proceso Terminado.............................. \n")