#Trabalho de TC
#FM Faixa FLarga

% fmt = ac*cos[2*pi*fc*t+beta*sin(2*pi*fm*t)]

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

fs = 5000;
t = [0:1/fs:1];
fm = 50;
fc = 500;
am = 1;
ac = 1;
wm = 2*pi*fm;
wc = 2*pi*fc;
kf = 5000;
beta = (kf*am)/(2*pi*fm);
b = 10; 
mt = am*cos(wm*t);
ct = ac*cos(wc*t);
st = ac*cos(wc*t + beta*sin(wm*t));
mt_fft = fft(mt);
ct_fft = fft(ct);
st_fft = fft(st);

##xc = ac*cos(2*pi*fc*t + beta*mt);
##xc = e0.*cos(w0*t).*cos(beta*mt) - e0.*sin(w0*t).*sin(beta*mt);
##[a,b] = my_fft(xc, fc);'

figure(1)
subplot(3,2,1);
plot(t, mt);
title("Sinal de Mensagem");
xlabel("Tempo");
ylabel("Amplitude");
subplot(3,2,2);
plot(abs(mt_fft));
title("Análise de Espectro");
xlabel("Frequência (Hz)");
ylabel("Amplitude");
subplot(3,2,3);
plot(t, ct);
title("Sinal da Portadora");
xlabel("Tempo");
ylabel("Amplitude");
subplot(3,2,4);
plot(abs(ct_fft));
title("Análise de Espectro");
xlabel("Frequência (Hz)");
ylabel("Amplitude");
subplot(3,2,5);
plot(t, st);
title("Sinal de Modulado");
xlabel("Tempo");
ylabel("Amplitude");
subplot(3,2,6);
plot(abs(st_fft));
title("Análise de Espectro");
xlabel("Frequência (Hz)");
ylabel("Amplitude");


##figure();
##plot(mt);
##figure();
##plot(ct);
##figure();
####plot(t, xc);
##plot(st);
##subplot(1,2,1);
##plot(t, mt);
##subplot(2,1,2);
##plot(t, xc);