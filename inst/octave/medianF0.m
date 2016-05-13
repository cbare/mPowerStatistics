% Computes basic phonation test features.
% Inputs:
%  audio - mono audio signal
%  srate - sample rate in Hz
function f0m = medianF0(audio, srate)
% adapted from features_bvav2.m by Max Little
% https://github.com/Sage-Bionetworks/PDScores/blob/master/bridge_ufb%20(original)/features_bvav2.m

% Ignore zero-length inputs
N = length(audio);
if (N == 0)
    return;
end

% Trim away start/end of phonation
Tstart = 1.0;
Tend   = 10.0;
istart = floor(Tstart*srate);
iend   = ceil(Tend*srate);
if (istart > N)
    istart = 1;
end
if (iend > N)
    iend = N;
end
audiotrim = audio(istart:iend);

% Get F0 estimates
[p,t,s] = swipep(audiotrim, srate, plim=[50 500], dt=0.02);

% Strip away all low-probability poor F0 estimates
i = (s >= 0.2);

% Median F0
f0m = median(p(i));
