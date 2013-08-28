s = Server.local.boot;

// ~ OSC ~ SINE WAVES

/ parabolic approximation of sine

{ LFPar.ar(LFPar.kr(LFPar.kr(0.2,0,8,10),0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ LFPar.ar(LFPar.kr(0.2, 0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ LFPar.ar(800,0,0.1) }.scope(1, zoom: 4);

// since it is not band limited, there are aliasing artifacts

{ LFPar.ar(XLine.kr(100,15000,6),0,0.1) }.scope(1, zoom: 4);

////////////////////////////////////////////////////////////////////////
/// Triangle waves

{ LFTri.ar(LFTri.kr(LFTri.kr(0.2,0,8,10),0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ LFTri.ar(LFTri.kr(0.2, 0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ LFTri.ar(800,0,0.1) }.scope(1, zoom: 4);

{ LFTri.ar(XLine.kr(100,15000,6),0,0.1) }.scope(1, zoom: 4);


////////////////////////////////////////////////////////////////////////
///SAW TOOTHE WAVES

{ LFSaw.ar(LFSaw.kr(LFSaw.kr(0.2,0,8,10),0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ LFSaw.ar(LFSaw.kr(0.2, 0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ LFSaw.ar(100,0,0.1) }.scope(1, zoom: 4);

{ LFSaw.ar(XLine.kr(100,15000,6),0,0.1) }.scope(1, zoom: 4);


//////////////////////////////////////////////////////////////////////
///Impulse waves

{ Impulse.ar(LFTri.kr(LFTri.kr(0.2,0,8,10),0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ Impulse.ar(LFTri.kr(0.2, 0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ Impulse.ar(100,0,0.1) }.scope(1, zoom: 4);

{ Impulse.ar(XLine.kr(100,15000,6),0,0.1) }.scope(1, zoom: 4);

//////////////////////////////////////////////////////////////////////
///LOW FREQUENCY PULSE
arguments:  frequency, phase, width, mul, add

{ LFPulse.ar(LFPulse.kr(LFPulse.kr(0.2,0,0.5,8,10),0,0.5, 400,800),0,0.5,0.1) }.scope(1, zoom: 4);

///fun \/
{ LFPulse.ar(LFPulse.kr(3, 0, 0.3, 200, 200), 0, 0.2, 0.1) }.scope(1, zoom: 4);

{ LFPulse.ar(XLine.kr(100,15000,6),0,0.5,0.1) }.scope(1, zoom: 4);


//////////////////////////////////////////////////////////////////////////////
/// pulse width modulation

{ LFPulse.ar(100,0,MouseY.kr(0,1),0.1) }.scope(1, zoom: 4);

{ LFPulse.ar(100,0,LFTri.kr(0.2,0,0.5,0.5),0.1) }.scope(1, zoom: 4);


{ VarSaw.ar(VarSaw.kr(VarSaw.kr(0.2,0,0.2,8,10),0,0.2, 400,800),0,0.2,0.1) }.scope(1, zoom: 4);

{ VarSaw.ar(VarSaw.kr(0.2, 0, 0.2, 400,800),0,0.2,0.1) }.scope(1, zoom: 4);

{ VarSaw.ar(XLine.kr(100,15000,6),0,0.2,0.1) }.scope(1, zoom: 4);

/////////////////////////////////////////////////////////////////////////////
/// pulse width modulation

{ VarSaw.ar(100,0,MouseY.kr(0,1),0.1) }.scope(1, zoom: 4);

{ VarSaw.ar(100,0,LFTri.kr(0.2,0,0.5,0.5),0.1) }.scope(1, zoom: 4);

///////////////////////////////////////////////////////////////
yncSaw
arguments:  syncFreq, sawFreq, mul, add

{ SyncSaw.ar(100, MouseX.kr(100, 1000), 0.1) }.scope(1, zoom: 4);

{ SyncSaw.ar(100, Line.kr(100, 800, 12), 0.1) }.scope(1, zoom: 4);


//////////////////////////////////////////////////////////////////////
///SinOsc, FSinOsc
arguments:  frequency, phase, mul, add

{ SinOsc.ar(SinOsc.kr(SinOsc.kr(0.2,0,8,10),0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ SinOsc.ar(SinOsc.kr(0.2, 0, 400,800),0,0.1) }.scope(1, zoom: 4);

{ SinOsc.ar(800,0,0.1) }.scope(1, zoom: 4);

{ SinOsc.ar(XLine.kr(100,15000,6),0,0.1) }.scope(1, zoom: 4);


///////////////////////////////////////////////////////////////////////
///
// FSinOsc should not be frequency modulated.
// Since it is based on a filter at the edge of stability, it will blow up:

{ FSinOsc.ar(FSinOsc.kr(FSinOsc.kr(0.2,0,8,10),0, 400,800),0,0.1) }.scope(1, zoom: 4);


////////////////////////////////////////////////////////////////////////
///Blip
arguments:  frequency, numHarmonics, mul, add

{ Blip.ar(XLine.kr(20000,200,6),100,0.2) }.scope(1);

{ Blip.ar(XLine.kr(100,15000,6),100,0.2) }.scope(1); // no aliasing

// modulate number of harmonics

{ Blip.ar(200,Line.kr(1,100,20),0.2) }.scope(1);


/////////////////////////////////////////////////////////////////////////
///Saw
arguments:  frequency, mul, add


{ Saw.ar(XLine.kr(20000,200,6),0.2) }.scope(1);

{ Saw.ar(XLine.kr(100,15000,6),0.2) }.scope(1); // no aliasing


////////////////////////////////////////////////////////////////////
///Pulse

arguments:  frequency, width, mul, add

{ Pulse.ar(XLine.kr(20000,200,6),0.3,0.2) }.scope(1);

{ Pulse.ar(XLine.kr(100,15000,6),0.3,0.2) }.scope(1); // no aliasing


///////////////////////////////////////////////////////////////////
///modulate pulse width

{ Pulse.ar(200, Line.kr(0.01,0.99,8), 0.2) }.scope(1);


///////////////////////////////////////////////////////////////////
/// two band limited square waves thru a resonant low pass filter

{ RLPF.ar(Pulse.ar([100,250],0.5,0.1), XLine.kr(8000,400,5), 0.05) }.scope(1);


///////////////////////////////////////////////////////////////////
///Klang - sine oscillator bank
arguments:  `[ frequencies, amplitudes, phases ], mul, add

{ Klang.ar(`[ [800, 1000, 1200],[0.3, 0.3, 0.3],[pi,pi,pi]], 1, 0) * 0.4}.scope(1);

{ Klang.ar(`[ {exprand(400, 2000)}.dup(16), nil, nil ], 1, 0) * 0.04 }.scope(1);


///////////////////////////////////////////////////////////////////
///COsc - two oscillators, detuned

arguments: buffer number, frequency, beat frequency, mul, add.

b.sine1(1.0/(1..6), true, true, true);

{ COsc.ar(80, 100, 1, 0.1) }.scope(1, zoom:4);
// change buffer as above.


///////////////////////////////////////////////////////////////////////////
///Aperiodic Sources: Noise.

LF "Low Frequency" Noise Generators.

LFNoise0, LFNoise1, LFNoise2, LFClipNoise

arguments: frequency, mul, add


{ LFClipNoise.ar(MouseX.kr(200, 10000, 1), 0.125) }.scope(1);

{ LFNoise0.ar(MouseX.kr(200, 10000, 1), 0.25) }.scope(1);

{ LFNoise1.ar(MouseX.kr(200, 10000, 1), 0.25) }.scope(1);

{ LFNoise2.ar(MouseX.kr(200, 10000, 1), 0.25) }.scope(1);

// used as controls

{ LFPar.ar(LFClipNoise.kr(MouseX.kr(0.5, 64, 1), 200, 400), 0, 0.2) }.scope(1, zoom:8);

{ LFPar.ar(LFNoise0.kr(MouseX.kr(0.5, 64, 1), 200, 400), 0, 0.2) }.scope(1, zoom:8);

{ LFPar.ar(LFNoise1.kr(MouseX.kr(0.5, 64, 1), 200, 400), 0, 0.2) }.scope(1, zoom:8);

{ LFPar.ar(LFNoise2.kr(MouseX.kr(0.5, 64, 1), 200, 400), 0, 0.2) }.scope(1, zoom:8);


///////////////////////////////////////////////////////////////////////////////
///Broad Spectrum Noise Generators

ClipNoise, WhiteNoise, PinkNoise, BrownNoise, GrayNoise
arguments: mul, add


{ ClipNoise.ar(0.2) }.scope(1);

{ WhiteNoise.ar(0.2) }.scope(1);

{ PinkNoise.ar(0.4) }.scope(1);

{ BrownNoise.ar(0.2) }.scope(1);

{ GrayNoise.ar(0.2) }.scope(1);


//////////////////////////////////////////////////////////////////////////////////
///Impulse Noise Generators
Dust, Dust2
arguments: density, mul, add

{ Dust.ar(MouseX.kr(1,10000,1), 0.4) }.scope(1, zoom:4);

{ Dust2.ar(MouseX.kr(1,10000,1), 0.4) }.scope(1, zoom:4);

//////////////////////////////////////////////////////////////////////////////
///Chaotic Noise Generators

Crackle
arguments: chaosParam, mul, add

{ Crackle.ar(MouseX.kr(1,2), 0.5) }.scope(1);


///////////////////////////////////////////////////////////////////////////////
///Filters
Low Pass, High Pass

LPF, HPF - 12 dB / octave
arguments: in, freq, mul, add

{ LPF.ar(WhiteNoise.ar, MouseX.kr(1e2,2e4,1), 0.2) }.scope(1);

{ HPF.ar(WhiteNoise.ar, MouseX.kr(1e2,2e4,1), 0.2) }.scope(1);

{ LPF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.2) }.scope(1);

{ HPF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.2) }.scope(1);


///////////////////////////////////////////////////////////////////////////////
///Band Pass, Band Cut

BPF, BRF - 12 dB / octave

arguments: in, freq, rq, mul, add

rq is the reciprocal of the Q of the filter,

or in other words: the bandwidth in Hertz = rq * freq.

//Mouse Controls
{ BPF.ar(WhiteNoise.ar, MouseX.kr(1e2,2e4,1), 0.4, 0.4) }.scope(1);.

{ BRF.ar(WhiteNoise.ar, MouseX.kr(1e2,2e4,1), 0.4, 0.2) }.scope(1);

{ BPF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.4, 0.4) }.scope(1);

{ BRF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.4, 0.2) }.scope(1);


///////////////////////////////////////////////////////////////////////////
///// modulating the bandwidth

{ BPF.ar(WhiteNoise.ar, 3000, MouseX.kr(0.01,0.7,1), 0.4) }.scope(1);

////////////////////////////////////////////////////////////////////////////
///Resonant Low Pass, High Pass, Band Pass
RLPF, RHPF - 12 dB / octave
arguments: in, freq, rq, mul, add


{ RLPF.ar(WhiteNoise.ar, MouseX.kr(1e2,2e4,1), 0.2, 0.2) }.scope(1);

{ RHPF.ar(WhiteNoise.ar, MouseX.kr(1e2,2e4,1), 0.2, 0.2) }.scope(1);

{ RLPF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.2, 0.2) }.scope(1);

{ RHPF.ar(Saw.ar(100), MouseX.kr(1e2,2e4,1), 0.2, 0.2) }.scope(1);


////////////////////////////////////////////////////////////////////////////
///Resonz - resonant band pass filter with uniform amplitude
// modulate frequency

arguments: in, freq, rq, mul, add


{ Resonz.ar(WhiteNoise.ar(0.5), XLine.kr(1000,8000,10), 0.05) }.scope(1);

////////////////////////////////////////////////////////////////////////
///// modulate bandwidth

{ Resonz.ar(WhiteNoise.ar(0.5), 2000, XLine.kr(1, 0.001, 8)) }.scope(1);


//////////////////////////////////////////////////////////////////////////
///// modulate bandwidth opposite direction

{ Resonz.ar(WhiteNoise.ar(0.5), 2000, XLine.kr(0.001, 1, 8)) }.scope(1);


////////////////////////////////////////////////////////////////////////
///Ringz - ringing filter.
Internally it is the same as Resonz but the bandwidth is expressed as a ring time.
arguments: in, frequency, ring time, mul, add

{ Ringz.ar(Dust.ar(3, 0.3), 2000, 2) }.scope(1, zoom:4);

{ Ringz.ar(WhiteNoise.ar(0.005), 2000, 0.5) }.scope(1);


//////////////////////////////////////////////////////////////////////////
/// modulate frequency

{ Ringz.ar(WhiteNoise.ar(0.005), XLine.kr(100,3000,10), 0.5) }.scope(1, zoom:4);

{ Ringz.ar(Impulse.ar(6, 0, 0.3),  XLine.kr(100,3000,10), 0.5) }.scope(1, zoom:4);


//////////////////////////////////////////////////////////////////////////////
/// modulate ring time

{ Ringz.ar(Impulse.ar(6, 0, 0.3), 2000, XLine.kr(0.04, 4, 8)) }.scope(1, zoom:4);


/////////////////////////////////////////////////////////////////////////////
//Simpler Filters
6 dB / octave

{ OnePole.ar(WhiteNoise.ar(0.5), MouseX.kr(-0.99, 0.99)) }.scope(1);

{ OneZero.ar(WhiteNoise.ar(0.5), MouseX.kr(-0.49, 0.49)) }.scope(1);


////////////////////////////////////////////////////////////////////////////
///NonLinear Filters
//Median, Slew

// a signal with impulse noise.
{ Saw.ar(500, 0.1) + Dust2.ar(100, 0.9) }.scope(1);

// after applying median filter
{ Median.ar(3, Saw.ar(500, 0.1) + Dust2.ar(100, 0.9)) }.scope(1);


// a signal with impulse noise.
{ Saw.ar(500, 0.1) + Dust2.ar(100, 0.9) }.scope(1);

// after applying slew rate limiter
{ Slew.ar(Saw.ar(500, 0.1) + Dust2.ar(100, 0.9),1000,1000) }.scope(1);


////////////////////////////////////////////////////////////////////////////
///Formant Filter
Formlet - A filter whose impulse response is similar to a FOF grain.

{ Formlet.ar(Impulse.ar(MouseX.kr(2,300,1), 0, 0.4), 800, 0.01, 0.1) }.scope(1, zoom:4);


//////////////////////////////////////////////////////////////////////////////
///Klank - resonant filter bank
arguments:  `[ frequencies, amplitudes, ring times ], mul, add

{ Klank.ar(`[[200, 671, 1153, 1723], nil, [1, 1, 1, 1]], Impulse.ar(2, 0, 0.1)) }.play;

{ Klank.ar(`[[200, 671, 1153, 1723], nil, [1, 1, 1, 1]], Dust.ar(8, 0.1)) }.play;

{ Klank.ar(`[[200, 671, 1153, 1723], nil, [1, 1, 1, 1]], PinkNoise.ar(0.007)) }.play;

{ Klank.ar(`[ {exprand(200, 4000)}.dup(12), nil, nil ], PinkNoise.ar(0.007)) }.scope(1);

{ Klank.ar(`[ (1..13)*200, 1/(1..13), nil ], PinkNoise.ar(0.01)) }.scope(1);

{ Klank.ar(`[ (1,3..13)*200, 1/(1,3..13), nil ], PinkNoise.ar(0.01)) }.scope(1);


/////////////////////////////////////////////////////////////////////////////
///Distortion
abs, max, squared, cubed

{ SinOsc.ar(300, 0, 0.2) }.scope(1);

{ SinOsc.ar(300, 0, 0.2).abs }.scope(1);

{ SinOsc.ar(300, 0, 0.2).max(0) }.scope(1);

{ SinOsc.ar(300, 0).squared * 0.2 }.scope(1);

{ SinOsc.ar(300, 0).cubed * 0.2 }.scope(1);


///////////////////////////////////////////////////////////////////////////
///distort, softclip, clip2, fold2, wrap2,

{ SinOsc.ar(300, 0, MouseX.kr(0.1,80,1)).distort * 0.2 }.scope(1);

{ SinOsc.ar(300, 0, MouseX.kr(0.1,80,1)).softclip * 0.2 }.scope(1);

{ SinOsc.ar(300, 0, MouseX.kr(0.1,80,1)).clip2(1) * 0.2 }.scope(1);

{ SinOsc.ar(300, 0, MouseX.kr(0.1,80,1)).fold2(1) * 0.2 }.scope(1);

{ SinOsc.ar(300, 0, MouseX.kr(0.1,80,1)).wrap2(1) * 0.2 }.scope(1);

{ SinOsc.ar(300, 0, MouseX.kr(0.1,80,1)).wrap2(1) * 0.2 }.scope(1);


////////////////////////////////////////////////////////////////////////
///Scaleneg

{ SinOsc.ar(200, 0, 0.2).scaleneg(MouseX.kr(-1,1)) }.scope(1);


waveshaping by phase modulating a 0 Hz sine oscillator
(currently there is a limit of 8pi)


////////////////////////////////////////////////////////////////////////
///Pan2 - equal power stereo pan a mono source

arguments: in, pan position, level
pan controls typically range from -1 to +1

{ Pan2.ar(BrownNoise.ar, MouseX.kr(-1,1), 0.3) }.scope(2);

{ Pan2.ar(BrownNoise.ar, SinOsc.kr(0.2), 0.3) }.scope(2);


///////////////////////////////////////////////////////////////////////
///LinPan2 - linear pan a mono source (not equal power)
arguments: in, pan position, level


{ LinPan2.ar(BrownNoise.ar, MouseX.kr(-1,1), 0.3) }.scope(2);

{ LinPan2.ar(BrownNoise.ar, SinOsc.kr(0.2), 0.3) }.scope(2);


///////////////////////////////////////////////////////////////////////
///Balance2 - balance a stereo source
arguments: left in, right in, pan position, level

{ Balance2.ar(BrownNoise.ar, BrownNoise.ar, MouseX.kr(-1,1), 0.3) }.scope(2);


//////////////////////////////////////////////////////////////////////////
///Pan4 - equal power quad panner

{ Pan4.ar(BrownNoise.ar, MouseX.kr(-1,1), MouseY.kr(1,-1), 0.3) }.scope(4);


//////////////////////////////////////////////////////////////////////////////
///PanAz - azimuth panner to any number of channels
arguments: num channels, in, pan position, level, width

{ PanAz.ar(5, BrownNoise.ar, MouseX.kr(-1,1), 0.3, 2) }.scope(5);

// change width to 3
{ PanAz.ar(5, BrownNoise.ar, MouseX.kr(-1,1), 0.3, 3) }.scope(5);

//////////////////////////////////////////////////////////////////////////////
///XFade2 - equal power cross fade between two inputs
arguments: in1, in2, crossfade, level

{ XFade2.ar(BrownNoise.ar, SinOsc.ar(500), MouseX.kr(-1,1), 0.3) }.scope(1);


//////////////////////////////////////////////////////////////////////////
///// Dust randomly triggers Decay to create an exponential

// decay envelope for the WhiteNoise input source

{

z = Decay.ar(Dust.ar(1,0.5), 0.3, WhiteNoise.ar);

DelayN.ar(z, 0.1, 0.1, 1, z); // input is mixed with delay via the add input


/////////////////////////////////////////////////////////////////////////
	CombN, CombL, CombC
feedback delays
arguments: in, maximum delay time, current delay time, echo decay time, mul, add

// used as an echo.

{ CombN.ar(Decay.ar(Dust.ar(1,0.5), 0.2, WhiteNoise.ar), 0.2, 0.2, 3) }.scope(1, zoom:4);

// Comb used as a resonator. The resonant fundamental is equal to
// reciprocal of the delay time.

{ CombN.ar(WhiteNoise.ar(0.02), 0.01, XLine.kr(0.0001, 0.01, 20), 0.2) }.scope(1);

{ CombL.ar(WhiteNoise.ar(0.02), 0.01, XLine.kr(0.0001, 0.01, 20), 0.2) }.scope(1);

{ CombC.ar(WhiteNoise.ar(0.02), 0.01, XLine.kr(0.0001, 0.01, 20), 0.2) }.scope(1);


////////////////////////////////////////////////////////////////////////////////
/// with negative feedback:

{ CombN.ar(WhiteNoise.ar(0.02), 0.01, XLine.kr(0.0001, 0.01, 20), -0.2) }.scope(1);

{ CombL.ar(WhiteNoise.ar(0.02), 0.01, XLine.kr(0.0001, 0.01, 20), -0.2) }.scope(1);

{ CombC.ar(WhiteNoise.ar(0.02), 0.01, XLine.kr(0.0001, 0.01, 20), -0.2) }.scope(1);


{ CombC.ar(Decay.ar(Dust.ar(1,0.1), 0.2, WhiteNoise.ar), 1/100, 1/100, 3) }.play;

{ CombC.ar(Decay.ar(Dust.ar(1,0.1), 0.2, WhiteNoise.ar), 1/200, 1/200, 3) }.play;

{ CombC.ar(Decay.ar(Dust.ar(1,0.1), 0.2, WhiteNoise.ar), 1/300, 1/300, 3) }.play;

{ CombC.ar(Decay.ar(Dust.ar(1,0.1), 0.2, WhiteNoise.ar), 1/400, 1/400, 3) }.scope(1, zoom:4);


////////////////////////////////////////////////////////////////////////////////
///AllpassN, AllpassL, AllpassC
allpass delay
arguments: in, maximum delay time, current delay time, echo decay time, mul, add
///////////////-------below

(

{

	var z;

	z = Decay.ar(Dust.ar(1,0.5), 0.1, WhiteNoise.ar);

	8.do { z = AllpassL.ar(z, 0.04, 0.04.rand, 2) };

	z

}.scope(1);

)


//////////////////////////----above----//////////////////////////////////////////
//////////////////////////Control - Filters for Controls
Decay
triggered exponential decay
arguments: in, decay time, mul, add


{ WhiteNoise.ar * Decay.ar(Impulse.ar(1), 0.9, 0.2) }.scope(1, zoom:4);

{ WhiteNoise.ar * Decay.ar(Dust.ar(3), 0.9, 0.2) }.scope(1, zoom:4);

{ SinOsc.ar(Decay.ar(Dust.ar(4), 0.5, 1000, 400), 0, 0.2) }.scope(1, zoom:4);//


//////////////////////////////////////////////////////////////////////////////////
///Decay2
triggered exponential attack and exponential decay
arguments: trigger, attack time, decay time, mul, add

{ WhiteNoise.ar * Decay2.ar(Impulse.ar(1), 0.2, 0.9, 0.2) }.scope(1, zoom:4);

{ WhiteNoise.ar * Decay2.ar(Dust.ar(3), 0.2, 0.9, 0.2) }.scope(1, zoom:4);


/////////////////////////////////////////////////////////////////////////////////
///Lag
arguments: trigger, duration

{ SinOsc.ar(Lag.ar(LFPulse.ar(2,0,0.5,800,400), MouseX.kr(0,0.5)), 0, 0.2) }.scope(1, zoom:4);


////////////////////////////////////////////////////////////////////////////////
///Integrator
leaky integrator

{ SinOsc.ar(Integrator.ar(Dust2.ar(8), 0.99999, 200, 800), 0, 0.2) }.scope(1)


////////////////////////////////////////////////////////////////////////////////
///Triggers
Trig, Trig1
timed duration gate
arguments: trigger, duration

// amplitude determined by amplitude of trigger

{ Trig.ar(Dust.ar(2), 0.2) * FSinOsc.ar(800, 0, 0.4) }.scope(1, zoom:4);


// amplitude always the same.

{ Trig1.ar(Dust.ar(2), 0.2) * FSinOsc.ar(800, 0, 0.4) }.scope(1, zoom:4)


/////////////////////////////////////////////////////////////////////////////////
///Latch
sample and hold
arguments: in, trigger

{ Blip.ar(Latch.ar(WhiteNoise.ar, Impulse.ar(9)) * 400 + 500, 4, 0.2) }.play;

{ Blip.ar(Latch.ar(SinOsc.ar(0.3), Impulse.ar(9)) * 400 + 500, 4, 0.2) }.play;


////////////////////////////////////////////////////////////////////////////////
///Gate
pass or hold
arguments: in, trigger

{ Blip.ar(Gate.ar(LFNoise2.ar(40), LFPulse.ar(1)) * 400 + 500, 4, 0.2) }.scope(1, zoom:4);


///////////////////////////////////////////////////////////////////////////////
///PulseCount
count triggers
arguments: trigger, reset


(

{

SinOsc.ar(

			PulseCount.ar(Impulse.ar(10), Impulse.ar(0.4)) * 200,

			0, 0.05

		)

}.scope(2, zoom:4);

)


/////////////////////////////////////////////////////////////////////////////////
///PulseDivider
arguments: trigger, div, start


(

{

	var p, a, b;

	p = Impulse.ar(8);

	a = SinOsc.ar(1200, 0, Decay2.ar(p, 0.005, 0.1));

	b = SinOsc.ar(600,  0, Decay2.ar(PulseDivider.ar(p, MouseX.kr(1,8).round(1)), 0.005, 0.5));



	[a, b] * 0.4

}.scope(2, zoom:4);

)


//////////////////////////////////////////////////////////////////////////////////
///EnvGen
envelope generator
envelope is specified using an instance of the Env class.


{ EnvGen.kr(Env.perc, doneAction:2) * SinOsc.ar(880,0,0.2) }.play;

{ EnvGen.kr(Env.perc(1,0.005,1,4), doneAction:2) * SinOsc.ar(880,0,0.2) }.play;



{ EnvGen.kr(Env.perc, Impulse.kr(2)) * SinOsc.ar(880,0,0.2) }.play;

{ EnvGen.kr(Env.perc, Dust.kr(3)) * SinOsc.ar(880,0,0.2) }.play;


