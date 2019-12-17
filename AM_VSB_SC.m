#Trabalho TC
#AM - VSB-SC

clc
clear all
close all

#Pacotes
pkg rebuild
pkg load control
pkg load signal
pkg load communications
pkg load tisean

#Fun��o
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
 title("An�lise de Espectro");
 xlabel("Frequ�ncia (Hz)");
 ylabel("Amplitude");
 
endfunction


#variavel tempo
fs = 10000;
t = [0:1/fs:1];
fc = 1000; %frequ�ncia portadora
fm = 50; %frequencia mensagem
ac = 2; %amplitude portadora
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

%Filtrando sinal(Passa-baixa)
fn = (fs-1)/2;%normaliza o grafico, (10001-1)/2), mostra s� o lado positivo
faixaP = (fc-fm)/fn;#freq. onde o filtro come�a a atenuar
faixaS = (fc+fm)/fn;#freq. onde o filtro atenua por completo
#A zona entre faixaP e faixaS � a zona de transi��o
Rpass = 1;#permite varia��o de 1 decibel
Rstop = 18;#permite varia��o de 18 decibeis
[n, Wn] = buttord (faixaP, faixaS, Rpass, Rstop);#retorna a freq. de corte e a ordem para um filtro com estes parametros
[num, den] = butter(n, Wn);#gera o filtro
[H, W] = freqz(num,den,3000,fs);#plota o filtro
figure
plot(W, abs(H))
p = filter(num,den,res);#filtrando...
[d,f] = my_fft(p, fc);



