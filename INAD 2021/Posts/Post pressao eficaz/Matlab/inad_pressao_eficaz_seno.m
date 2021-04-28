% Rotina para demonstração do passo a passo de como calcular o valor eficaz
% de um sinal. Essa rotina foi utilizada para geração de um vídeo para a
% campanha do INAD 2021
%
% Escrita por Felipe Ramos de Mello - Abril de 2021
% Revisão William D'Andrea Fonseca

%% Caminho para os arquivos de áudio

% Altere para o caminho no qual salvou seu arquivo de aúdio
% Pode comentar se o áudio estiver na mesma pasta que a rotina
% addpath('C:\Users\felip\Documents\UFSM\INAD\Construção dos posts\Pressão eficaz\audios');

%% Construindo o seno

fs = 44100; % Taxa de amostragem
f = 432; % Frequência linear 
w = 2*pi*f; % Frequência angular
P = 1/432; % Período
seno_duration = P*1000; % Duração de mil períodos
seno_timeVector = 0:1/fs:seno_duration - 1/fs; % Vetor de tempo

% Essa amplitude foi escolhida para que o sinal não clipasse ao ser
% reproduzido e, ao mesmo tempo, retornasse um valor próximo a 1/sqrt(2),
% que é o valor rms de um seno de amplitude 1
seno = (0.9999999999*sin(w*seno_timeVector))'; 

%% Criação da figura

% Pra ficar legal no OBS studio, eu crio primeiro uma figura em branco que,
% aos poucos, vou preenchendo a cada célula (ctrl + enter)

close all;
f = figure('name', 'plot', 'DefaultAxesFontSize', 22);
f.WindowState = 'maximized';

%% Plot do sinal musical

f.NextPlot = 'add'; % Os plots seguintes serão sobrepostos ao atual
plot(seno_timeVector, seno, 'linewidth', 3); hold on;
xlim([0, P*4]);
ylim([-1, 1.7]);
xlabel('Tempo [s]');
ylabel('Amplitude [-]');
title('Forma de onda de um tom puro no tempo');
grid on;

%% Toca o sinal

sound(seno, fs);

%% Cálculo do sinal musical ao quadrado

music_sq = seno.^2;
plot(seno_timeVector, music_sq, 'linewidth', 3);
xlabel('Tempo [s]');
ylabel('Amplitude [-]');
title('Tom puro e tom puro ao quadrado');
grid on;

% Gera um handle para as legendas
[~, objH] = legend('Tom puro', 'Tom puro ao quadrado', 'location', 'northwest');

%% Cálculo da média

sen_sq_mean = mean(music_sq);
strMedia = sprintf('Valor da média = %2.4f', sen_sq_mean);

y1 = yline(sen_sq_mean, '--' ,'linewidth', 3);
y1.Label = 'Média';
y1.FontSize = 24;
xlabel('Tempo [s]');
ylabel('Amplitude [-]');
title({'Tom puro, tom puro ao quadrado e média'});
grid on;

% Gera um handle para as legendas
[~, objH] = legend('Tom puro', 'Tom puro ao quadrado',...
   strMedia, 'location', 'northwest');

% Retira a dummy line das legendas (pra ficar bonito)
set(findobj(objH, 'Tag', strMedia), 'Vis', 'off');

%% Adiciona o rms

seno_rms = sqrt(sen_sq_mean);
strRMS = sprintf('Valor eficaz = %4.4f', seno_rms);

y2 = yline(seno_rms, 'color', '#77AC30', 'linewidth', 6);
y2.Label = 'Valor eficaz';
y2.FontSize = 24;
xlabel('Tempo [s]');
ylabel('Amplitude [-]');
title({'Tom puro, tom puro ao quadrado, média e valor eficaz'});
grid on;

% Gera um handle para as legendas
[~, objH] = legend('Tom puro', 'Tom puro ao quadrado',...
   strMedia, strRMS, 'location', 'northwest');


