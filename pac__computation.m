% Phase amplitude coupling code based on Busch et al., 2009 and 2012
% Abdelrahman Rayan
% Neurophysiology Department, Ruhr University Bochum, Germany
% abdelrahman.rayan@rub.de
% Parameters
srate = 1000; % sample rate
forder = 2; % Filter order
Theta = [4 8]; % Theta band frequency
Gamma = [30 80]; % Gamma band frequency
[b a] = butter(forder, Theta ./(srate/2))
[e f] = butter(forder, Gamma ./(srate/2));
% Reading the data
Data = textread('FileName.atf');
% Subtracting the mean 
eegData = Data - mean(Data);
% Filter the theta and gamma
eegTheta = filtfilt(b,a,eegData);
eegGamma = filtfilt(b,a,eegData);
% Calculate the phase of theta from Hilbert transform of the signal
eegThetaPhase = angle(hilbert(eegTheta));
% Calculate the amplitude of the gamma and filter it in the theta frequency range
eegGammaAmp = abs(hilbert(eegGamma));
eegGammaAmpF = filtfilt(b,a,eegGammaAmp);
% Calculate the phase of Gamma amplitude filtered in theta range frequency
eegGammaAmpFPhase = angle(hilbert(eegGammaAmpF));
% Calculate the phase difference and compute the length of the resultant vector PLV
PhaseDiff = eegGammaAmpFPhase - eegThetaPhase;
PhaseDiff = exp(1i*PhaseDiff);
PhaseDiff = angle(PhaseDiff);
PLV = circ_r(PhaseDiff);
 