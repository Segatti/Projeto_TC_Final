#Trabalho TC
#AM - SSB-SC

clc
clear all
close all

#Pacotes
pkg rebuild
pkg load control
pkg load signal
pkg load communications
pkg load tisean

#variavel tempo
fs = 10000;
t = [0:1/fs:1];
fc = 1000; %frequência portadora
fm = 50; %frequencia mensagem
ac = 2; %amplitude portadora
am = 1; %amplitude sinal mensagem

#Função
function [S, frequency] = my_fft(s, fs)
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

#AM
wm = 2*pi*fm; %omega mensagem
wc = 2*pi*fc; %omega portadora
mt = am*cos(wm*t);%+2*sinc(wm*t); %sinal mensagem
[fft_mt, fq_mt] = my_fft(mt, fm);
m_ac = ac*cos(wc*t); %sinal portadora
[fft_mc, fq_mc] = my_fft(m_ac, fc);

#Sinal Modulado
res = mt.*m_ac;%Sinal DSB-SC
[fft_res, fq_res] = my_fft(res, fc);

%Filtrando sinal(Passa-baixa)
fn = (fs-1)/2;%normaliza o grafico, assim posso colocar a faixa em Hz, considera só metade do gráfico((10001-1)/2)
faixaP = (fc-fm)/fn;
faixaS = (fc+fm)/fn;
Rpass = 1;
Rstop = 18;
[n, Wn] = buttord (faixaP, faixaS, Rpass, Rstop);
[num, den] = butter(n, Wn);
[H, W] = freqz(num,den,3000,fs);
figure
plot(W, abs(H))
p = filter(num,den,res);
[d,f] = my_fft(p, fc);



