#Trabalho de TC
#FM Faixa Estreita

clc
clear all
close all

pkg rebuild
pkg load control
pkg load signal
pkg load communications

#Função
function [S, frequency] = my_fft (s, fs)
 normal = length(s);
 aux = 0:normal-1;
 T = normal/fs;
 frequency = aux;
 S = fftn(s)/normal;
 fc = ceil(normal/2);
 S = S(1:fc);
 
 figure();
 subplot(2,1,1)
 plot(s)
 title("Sinal no tempo");
 xlabel("Tempo");
 ylabel("Amplitude");
 subplot(2,1,2)
 plot(frequency(1:fc), abs(S))
 title("Análise de Espectro");
 xlabel("Frequência (Hz)");
 ylabel("Amplitude");
 
endfunction

fs = 10000;
t = [0:1/fs:1];
f = 100;
fc = 1000;
Eo = 2;
beta = 0.2;
 m = sin(2*pi*f*t);
xc = Eo*cos(2*pi*fc*t + beta*m);
[a,b] = my_fft(xc, fc);

