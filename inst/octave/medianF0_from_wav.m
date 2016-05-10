% given a .wav file on the command line, compute median F0
args = argv();
wav_file = args{1};
audio = wavread(wav_file);
f0m = medianF0(audio, srate=44100);
printf('%f\n', f0m)
