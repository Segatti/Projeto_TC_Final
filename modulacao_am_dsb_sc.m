% Modulação AM-DSBC-SC

%autor: Felipe Monteiro & Victor Feitosa

%sinal de mensagem m(t)=Am.cos(2.pi.fm.t)

%sinal da portatora c(t)=Ac.cos(2.pi.fc.t)

%Sinal modulado s(t) ac.[1+ka.m(t)].cos(2.pi.fc.t)


fs = 10000; %frenquancia de amostragem
t = [0:1/fs:1]; %tempo
fm = 100; %frenquancia da mensagem
fc = 1000; %frenquancia da portatora
am = 1; %amplitude da mensagem
ac = 1; %amplitude da portadora


mt = am*sin(2*pi*fm*t); %sinal modulante
mt_fft = fft(mt);
ct = ac*cos(2*pi*fc*t); %lsinal da portadora
ct_fft = fft(ct);
st = mt.*ct; %sianl modulado
st_fft = fft(st);
%[fft_mt, freq_mt] = my_fft(mt, fm);

figure()
subplot(3,2,1);
plot(t, mt);
title("Sinal de Mensagem");
xlabel("Tempo");
ylabel("Amplitude");
subplot(3,2,2);
plot(abs(mt_fft./2));
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

%plot(t, m);