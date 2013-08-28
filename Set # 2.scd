//Great Distortion for Vocals and Contact Mics

// Band Pass Filter

(
{
	var in, amount, amCoef;
	in = BPF.ar(SoundIn.ar(0), 400)* 50;//The last value is the amount of distortion
	amount = 0.99;
	amCoef= 2*amount/(1-amount);
	MidEQ.ar(LPF.ar((1+amCoef)*in/(1+(amCoef*in.abs)), [3800, 3900])*0.5, 9120, 0.9999, 8);
}.play;
)

// Low Pass Filter

(
{
	var in, amount, amCoef;
	in = LPF.ar(SoundIn.ar(0), 400)* 50;//The last value is the amount of distortion
	amount = 0.99;
	amCoef= 2*amount/(1-amount);
	MidEQ.ar(LPF.ar((1+amCoef)*in/(1+(amCoef*in.abs)), [3800, 3900])*0.5, 9120, 0.9999, 8);
}.play;
)


// High Pass Filter

(
{
	var in, amount, amCoef;
	in = HPF.ar(SoundIn.ar(0), 400)* 50;//The last value is the amount of distortion
	amount = 0.99;
	amCoef= 2*amount/(1-amount);
	MidEQ.ar(LPF.ar((1+amCoef)*in/(1+(amCoef*in.abs)), [3800, 3900])*0.5, 9120, 0.9999, 8);
}.play;
)

// Glitch Noise

(
SynthDef( \newnoise, // cool glitchy sounding noise
	{| freq = 440, gate =1, sustain =1, amp = 0.25, width = 0.15, preamp = 5|
		var sig,
		env = Env.adsr(0.01, 0.1, 0.1, 0.01);
		sig = Saw.ar(Latch.ar(LatoocarfianC.ar, SyncSaw.ar(20)) * 1790 + freq, 4, 0.2) * EnvGen.kr(env, gate, doneAction:2) * amp;
		Out.ar(0, sig ! 2)
	}).play

)

//

(
SynthDef( \newnoise2, // cool glitchy sounding noise
	{| freq = 440, gate =1, sustain =1, amp = 0.25, width = 0.15, preamp = 5|
		var sig,
		env = Env.adsr(0.01, 0.1, 0.1, 0.01);
		sig = Saw.ar(Latch.ar(LatoocarfianL.ar, SyncSaw.ar(13)) * 1390 + freq, 4, 0.2) * EnvGen.kr(env, gate, doneAction:2) * amp;
		Out.ar(0, sig ! 2)
	}).play

)

//


(
SynthDef( \newnoise3, // cool glitchy sounding noise
	{| freq = 440, gate =1, sustain =1, amp = 0.25, width = 0.15, preamp = 5|
		var sig,
		env = Env.adsr(0.01, 0.1, 0.1, 0.01);
		sig = Saw.ar(Latch.ar(LatoocarfianN.ar, SyncSaw.ar(20)) * 1090 + freq, 4, 0.2) * EnvGen.kr(env, gate, doneAction:2) * amp;
		Out.ar(0, sig ! 2)
	}).play

)


//

(
SynthDef( \newnoise4, // cool glitchy sounding noise
	{| freq = 440, gate =1, sustain =1, amp = 0.25, width = 0.15, preamp = 5|
		var sig,
		env = Env.adsr(0.01, 0.1, 0.1, 0.01);
		sig = Saw.ar(Latch.ar(LFClipNoise.ar, SyncSaw.ar(9)) * 60 + freq, 800, 0.2) * EnvGen.kr(env, gate, doneAction:2) * amp;
		Out.ar(0, sig ! 2)
	}).play

)

//

\\ some basic templates for envelopes, amplitude and frequency modulations
\\ lp, 4/99




\\ simple enveloping

(
	{
		var freq = 220, e, e1;
		e = Env.linen(0.02, 1, 2.1);
		e1 = Env.perc(0.52, 1.5, 370);
		Formant.ar(freq, EnvGen.kr(e1) + 500, 50 , EnvGen.kr(e))
	}.scope

)



\\ very basic, two operator frequency modulation
(


	{

		var freqc = 200, freqm = 5, ampc = 0.5, ampm = 0.15;
		l = LFSaw.ar(freqm, ampm );
		s = SinOsc.ar( (l * freqc) + freqc, 0, ampc);
		s
	}.scope;

)




\\ very basic, two operator frequency modulation
(


	{

		var freqc = 200, freqm = 5, ampc = 0.5, ampm = 0.15;
		l = LFSaw.ar(freqm, ampm );
		s = SinOsc.ar( (l * freqc) + freqc, 0, ampc);
		s
	}.scope;

)


// Crazy Pitch follower

(
	a = {
		var input = SoundIn.ar([0, 1]);				// Take computer sound in
		var mouse_x = MouseX.kr(0.0, 0.2, 0).postln;	// Mouse gate threshold control
		var in_gate = Compander.ar(input, input, mouse_x, 10, 1, 0.01, 0.01);
		var fund_freq = ZeroCrossing.ar(in_gate);		// Lo qual pitch tracking

		// Assign tracked pitch to oscillator
		SinOsc.ar(fund_freq, 0, 0.5);
	}.play;
)

a.free;


//FM Synth press Mouse button.

(
	SynthDef("fm-synth", {
		arg freq = 440, amp = 0, gate = 0;

		Out.ar(0, Pan2.ar(SinOsc.ar(MouseY.kr(4000, 0) * SinOsc.ar(MouseX.kr(20, 4000), 0,
			MouseButton.kr(0, 1, 0.2), 0, 0.2)), 0, 0.2));

		FreeSelf.kr(1 - gate);	// FreeSelf automatically releases on neg-pos transition
	}).store;
)

// Test FM synth using test variable
a = Synth('fm-synth');


