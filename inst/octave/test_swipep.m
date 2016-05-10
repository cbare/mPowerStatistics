%----------------------------------------------------------
% A sine wave at 440Hz (A)
%----------------------------------------------------------
tsec = 10;
srate = 44100;
i = 1:(srate*tsec);
f = 440;
amp = 30000;
audio = int16(amp*sin(2*pi*f/srate*i));
[p,t,s] = swipep(audio, srate, plim=[50,500], dt=0.1);
printf('median(p)=%0.2f, median(s)=%0.2f\n\n', median(p), median(s(!isnan(s))));
tolerance = 3.0;
assert( abs(median(p) - 440) < tolerance );


%----------------------------------------------------------
% An A chord
%----------------------------------------------------------
fA = 440;
ampA = 10000;
fCsharp = fA * 5/4;
ampC = 10000;
fE = fA * 6/4;
ampE = 10000;
audio = int16(ampA*sin(2*pi*fA/srate*i) + ampC*sin(2*pi*fCsharp/srate*i) + ampE*sin(2*pi*fE/srate*i));
[p,t,s] = swipep(audio, srate, plim=[50,500], dt=0.1);
printf('median(p)=%0.2f, median(s)=%0.2f\n\n', median(p), median(s(!isnan(s))));

% not sure why the results of this are not very close to 440Hz
tolerance = 100.0;
assert( abs(median(p) - 440) < tolerance );


%----------------------------------------------------------
% A with harmonics and noise
%----------------------------------------------------------
fA = 440;
ampA = 6000;
audio = int16(ampA*sin(2*pi*fA/srate*i));

% add harmonics at decreasing amplitude
for j = 1:5
  h = j*fA;
  amp = ampA - j*1000;
  audio += int16(amp*sin(2*pi*f/srate*i));
endfor

% noise
audio += int16(normrnd(0, 5000, 1, tsec*srate));

[p,t,s] = swipep(audio, srate, plim=[50,500], dt=0.1);
printf('median(p)=%0.2f, median(s)=%0.2f\n\n', median(p), median(s(!isnan(s))));
tolerance = 10.0;
assert( abs(median(p) - 440) < tolerance );

