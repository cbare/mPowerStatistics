The MATLAB / Octave source files here are the least bad means of computing the median F0 statistic for mPower voice files. This code is based on MATLAB code from Max Little, originals of which are here: https://github.com/Sage-Bionetworks/PDScores/tree/master/bridge_ufb%20(original)

Note that in test_swipep.m and medianF0_from_wav.m, we explicitly do "pkg load signal". Under some circumstances, this isn't necessary; Octave implicitly loads installed packages. But in the Docker containers for the mPowerProcessing and mPowerStatistics, it seems to be needed. I don't know why.

A Dockerfile is included that creates a containerized version of Octave along with the scripts in this directory. Example usage:

```bash
cd inst/octave/
docker build -t octave .

## to test the swipep function:
docker run --rm octave test_swipep.m

## to compute medianF0 for a wav file on the host file system:
docker run --rm -v /local/path:/data octave medianF0_from_wav.m /data/file.wav
```
