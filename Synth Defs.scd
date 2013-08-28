SynthDef.new("cool4",{ Out.ar(0,SinOsc.ar(500))}).send(s);

x = Synth.new("cool4")(\Additionalreading ;

y = Synth("cool", [\SinOsc, 260]);

x.free


//////////////////////


(
	(
			SynthDef(\smooth, { |freq = 440, sustain = 1, amp = 0.5|
				    var sig;
				    sig = SinOsc.ar(freq, 0, amp) * EnvGen.kr(Env.linen(0.05, sustain, 0.1), doneAction: 2);
				    Out.ar(0, sig ! 2)
			}).add;
	);

	(
			p = Pbind(
				        // the name of the SynthDef to use for each note
				    \instrument, \smooth,
				        // MIDI note numbers -- converted automatically to Hz
				    \midinote, Pseq([60, 72, 71, 67, 69, 71, 72, 60, 69, 67], 1),
				        // rhythmic values
				    \dur, Pseq([2, 2, 1, 0.5, 0.5, 1, 1, 2, 2, 3], 1)
			).play;
		)

)


///////////////


(
		z = {arg noiseHz=8;
		var freq, amp, sig;
		freq = LFNoise0.kr(noiseHz).exprange(200,1000);
		amp = LFNoise1.kr(12).exprange(0.02,1);
		sig = SinOsc.ar(freq) * amp;
		}.play;
)

(
SynthDef.new(\sineTest, {
		arg noiseHz=8;
		var freq, amp, sig;
		freq = LFNoise0.kr(noiseHz).exprange(200,1000);
		amp = LFNoise1.kr(12).exprange(0.02,1);
		sig = SinOsc.ar(freq) * amp;
		Out.ar(0, sig);
	}).add;
)

	x = Synth.new(\sineTest, [\noiseHz, 32]);

	x.set(\noiseHz, 6);

	x.free




(
SynthDef.new(\pulseTest, {
			arg ampHz=4, fund=40, maxPartial=4; width=0.5;
			var amp1, amp2, freq1, freq2, sig1, sig2;
			amp1 = LFPulse.kr(ampHz, 0, 0.12) * 0.75;
			amp2 = LFPulse.kr(ampHz, 0.5, 0.12) * 0.75;
			freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
			freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
			freq1 = freq1 * LFPulse.kr(8, add:1);
			freq2 = freq2 * LFPulse.kr(6, add:1);
			sig1 = Pulse.ar(freq1, width, amp1);
			sig2 = Pulse.ar(freq2, width, amp2);
			sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25;
			sig2 - FreeVerb.ar(sig2, 0.7, 0.8, 0.25);
			Out.ar(0, sig1);
			Out.ar(1, sig2);
}).add;
)

x = Synth.new(\pulseTest);