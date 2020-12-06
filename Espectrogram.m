function []=Espectrogram(x,Windows,ColorGris,L,R,N,fs)
figure()
if (ColorGris ~= 1)
    colormap("gray")
end
switch  Windows
    case 1
        W=boxcar(L);
    case 2
        W=triang(L);
    case 3
        W=hamming(L);
    case 4
        W=hanning(L);
    case 5
        W=blackman(L);
end
%[y,fs]=audioread(x);
%spectrogram(X,WINDOW(ventana),NOVERLAP(L-R) "L" longitud de ventana , "R" cantidad de muestras para saltar ,NFFT (Cantidad de muestras fft),Fs)
spectrogram(x,W,L-R,N,fs);

end