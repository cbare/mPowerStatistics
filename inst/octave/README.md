The MATLAB / Octave source files here are the least bad means of computing the median F0 statistic for mPower voice files. This code is based on MATLAB code from Max Little, originals of which are here: https://github.com/Sage-Bionetworks/PDScores/tree/master/bridge_ufb%20(original)

Note that in test_swipep.m and medianF0_from_wav.m, we explicitly do "pkg load signal". Under some circumstances, this isn't necessary; Octave implicitly loads installed packages. But in the Docker containers for the mPowerProcessing and mPowerStatistics, it seems to be needed. I don't know why.
