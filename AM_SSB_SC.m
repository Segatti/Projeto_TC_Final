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

#Função
function [S, frequency] = my_fft (s, fs)#Função para gerar gráficos no tempo e na frequencia
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


#variavel tempo
fs = 10000;
t = [0:1/fs:1];
fc = 1000; %frequência portadora
fm = 100; %frequencia mensagem
ac = 1; %amplitude portadora
am = 1; %amplitude sinal mensagem

#AM
wm = 2*pi*fm; %omega mensagem
wc = 2*pi*fc; %omega portadora
mt = am*cos(wm*t);%sinal mensagem
[fft_mt, fq_mt] = my_fft(mt, fm);
m_ac = ac*cos(wc*t); %sinal portadora
[fft_mc, fq_mc] = my_fft(m_ac, fc);

#Sinal Modulado
res = mt.*m_ac;%Sinal DSB-SC
[fft_res, fq_res] = my_fft(res, fc);

%Filtrando sinal(Passa-Faixa -> Banda Lateral Superior)
fn = (fs-1)/2;%normaliza o grafico, (10001-1)/2), mostra só o lado positivo
faixa = [fc fc+2*fm]/fn;#faixa[1000 1200]
[num, den] = butter(7, faixa);#Gera o filtro de ordem 7, OBS: quanto menor a freq. da mensagem, mais perto do filtro ideal se faz necessário!
%[H, W] = freqz(num,den,3000,fs);
%plot(W, abs(H))
p = filter(num,den,res);#Filtrando...
[d,f] = my_fft(p, fc);
