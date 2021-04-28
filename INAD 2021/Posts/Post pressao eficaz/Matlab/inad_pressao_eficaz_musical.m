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

%% Carregando um sinal musical

[music, fs] = audioread('348275__bigmanjoe__fantasy-orchestra.wav');
music = (music(:, 1) + music(:, 2))./(max(music(:,2))*2); % Soma dos canais -> transforma pra mono
music = music(126942:end); % Cortar um pedaço da música 
music_duration = length(music)/fs; % Cálculo da duração da música em segundo
music_timeVector = 0:1/fs:music_duration -1/fs; % Vetor de tempo

%% Criação da figura

% Pra ficar legal no OBS studio, eu crio primeiro uma figura em branco que,
% aos poucos, vou preenchendo a cada célula (ctrl + enter)

close all;
f = figure('name', 'plot', 'DefaultAxesFontSize', 22);
f.WindowState = 'maximized';

%% Plot do sinal musical

% Primeiro ploto a forma de onda do sinal

f.NextPlot = 'replacechildren'; % Deixo claro que o próximo plot deve substituir o atual
plot(music_timeVector, music);
xlabel('Tempo [s]');
ylabel('Amplitude [-]');
title('Forma de onda de um sinal musical no tempo');
grid on;

%% Toca o sinal

sound(music, fs);

%% Cálculo do sinal musical ao quadrado

% Optei por não sobrepor o sinal ao quadrado ao sinal original, pois
% ficaria difícil de visualizar. Esse plot substitui o anterior, mas na
% mesma figura

music_sq = music.^2;
plot(music_timeVector, music_sq);
xlabel('Tempo [s]');
ylabel('Amplitude [-]');
title('Forma de onda de um sinal musical elevado ao quadrado');
grid on;
f.NextPlot = 'add'; % Aqui configuro que o próximo plot deverá se sobrepor ao atual

%% Cálculo da média

music_sq_mean = mean(music_sq);
strMedia = sprintf('Valor da média = %2.4f', music_sq_mean);

y1 = yline(music_sq_mean, '--' ,'linewidth', 3);
y1.Label = 'Média';
y1.FontSize = 24;
xlabel('Tempo [s]');
ylabel('Amplitude [-]');
title({'Forma de onda de um sinal musical elevado ao quadrado', 'e sua média'});
grid on;

% Gera um handle para as legendas
[~, objH] = legend('Sinal musical ao quadrado',...
   strMedia, 'location', 'northwest');

%% Adiciona o rms

music_rms = sqrt(music_sq_mean);
strRMS = sprintf('Valor eficaz = %2.4f', music_rms);

y2 = yline(music_rms, 'color', '#FF0000', 'linewidth', 6);
y2.Label = 'Valor eficaz';
y2.FontSize = 24;
xlabel('Tempo [s]');
ylabel('Amplitude [-]');
title({'Forma de onda de um sinal musical elevado ao quadrado,', 'sua média e seu valor eficaz'});
grid on;

% Gera um handle para as legendas
[~, objH] = legend('Sinal musical ao quadrado',...
   strMedia, strRMS,  'location', 'northwest');

