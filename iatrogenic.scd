// Iatrogenic Factors sharp and glitchy

// 2nd more doomy/contact mics

// Large control structure to switch between the "modes"

// Exotic Synth Defs

// Control over sequencers

// set up samples

// square wave glith effect

// delay bus

// metalizer

// switching between a cycle of distortion type / intensities
o = Server.local.options;
Server

// Post the number of output channels

o.numOutputBusChannels.postln;

// Set them to a new number

o.numOutputBusChannels = 3; // The next time it boots, this will take effect

s.boot;
// specify a device

o.device ="Focusrite USB ASIO Driver"; // use a specific soundcard
o.device = nil; // use the system default soundcard



Server.default.options.memSize = 512*1024;
s.boot;
(
SynthDef( \stutter, // this one seems to work well with the gate effect, maybe it needs delay
        {| freq = 440, gate =1, sustain = 1, amp = 0.25, width = 0.15, preamp = 5, third = 3|
         var sig, finalsig,
         env = Env.adsr(0.01, 0.1, 0.1, 0.01);
		sig = Mix([VarSaw.ar(freq + SinOsc.kr(4 , 1, 10), 1 ,1), VarSaw.ar(freq * third.midiratio + SinOsc.kr(0.4.rand , 1, 10), 1, 1), VarSaw.ar(freq *
5.midiratio, 1, 1)])
         * EnvGen.kr(env, gate, doneAction:2) * amp;

		finalsig = Mix([sig,DelayC.ar(sig,2,4.rand / 2,1)]);
         Out.ar(0, finalsig ! 2)
}).add;

)


TempoClock.default.tempo = 200/60;
(
p = Pbind(
                \instrument, \stutter,
                \midinote, Pstutter(Pseq([1, 2, 3, 4, 5], inf), Pxrand([61, 65, 70, 55, 44, 73], inf)),
                \third, Prand([3, 4, 2], inf),
                \dur, Prand([ 0.033], inf),
                \amp, 0.5);
)
y = p.play;
y.stop;
(
var notes, on, off;

MIDIClient.init;
MIDIIn.connectAll;

notes = Array.newClear(128);    // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    notes[num] = Synth(\stutter, [\freq, num.midicps,
        \amp, veloc * 0.00315]);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    notes[num].release;
});

q = { on.free; off.free; };
)

p.play;

// when done:
q.value;


MIDIFunc.noteOn({arg ...args; args.postln; {SinOsc.ar(Rand.new(500,100),0,1)}.play;}, 37); // match 37
(
MIDIFunc.noteOn({arg ...args; args.postln; y = p.play;}, 37); // match 37
MIDIFunc.noteOff({arg ...args; args.postln; y.stop}, 37); // match 37
)

p.play;
// Gendy

(

{Pan2.ar(

Mix.new(Gendy3.ar(3,5,1.0,1.0,(Array.fill(5,{LFNoise0.kr(1.3.rand,1,2)})*MouseX.kr(100,378,'exponential')),MouseX.kr(0.01,0.05),MouseY.kr(0.001,0.016),5,mul:0.1)))}.play

)

{Pan2.ar(Gendy3.ar(MouseX.kr(0,7),MouseY.kr(0,7),mul:0.2), 0.0)}.play


MIDIFunc.cc({arg ...args; args.postln; {x = SinOsc.ar(Rand.new(500,100),0,1)}.play;}); // match 37

// Pitch controlled by pad

SynthDef("pitchFollow1",{
var in, amp, freq, hasFreq, out;
in = Mix.new(SoundIn.ar([0,0]));
amp = Amplitude.kr(in, 0.05, 0.05) * 0.45 ;
# freq, hasFreq = Pitch.kr(in, ampThreshold: 0.02, median: 7);
//freq = Lag.kr(freq.cpsmidi.round(1).midicps, 0.05);
out = Mix.new(VarSaw.ar(freq * [0.5,1,2], 0, LFNoise1.kr(0.3,0.1,0.1), amp));
6.do({
out = AllpassN.ar(out, 0.040, [0.040.rand,0.040.rand], 2)
});
Out.ar(0,out)
}).play(s);


// bank of samples

// gradual fade ins

// ring mod

// mic in with verb

s.boot;
(
play({

PitchShift.ar(

AudioIn.ar([1,2]),	// stereo audio input

0.1, // grain size

MouseX.kr(0,2),	// mouse x controls pitch shift ratio

0, // pitch dispersion

0.004	// time dispersion

)

}))

(
var grainSize;

grainSize = 0.5;

play({

PitchShift.ar(

AudioIn.ar([1,2]),

grainSize,

1,	// nominal pitch rate = 1

MouseX.kr(0,1), // pitch dispersion

MouseY.kr(0, grainSize)	// time dispersion

)


(
SynthDef(\sinGrains  , {  arg out = 0, freq0= 440,  freq1= 500, amp =
0.5, grainDur = 0.1,
        cloudDur = 1, trigRate = 20, prob = 1;
        var signal, env, imp;
        env= EnvGen.ar(Env.sine(cloudDur), levelScale: amp, doneAction:2);
        imp = Impulse.kr(trigRate);
        signal = GrainSin.ar(2,
                // trigger is multiplied with 0 or 1 according to prob
                imp * Demand.kr(imp, 0, Dwrand([0, 1], [1 - prob, prob], inf)),
                grainDur,
                Dseq([freq0, freq1], inf)
        ) * env ;
    signal = Out.ar(out, signal * amp ) ;
}).add;
)


Synth(\sinGrains);

(
r = (
        a: Pbind(
                \instrument, \sinGrains,
                \freq0, 944,
                \freq1, 955,
                \dur, Pser([0.2,0.3], 3),
                \cloudDur, Pkey(\dur),
                \amp, 0.4,
        ),
        b: Pbind(
                \instrument, \sinGrains,
                \freq0, 244,
                \freq1, 205,
                \dur, Pser([0.2,0.3], 5),
                \cloudDur, Pkey(\dur),
                \amp, 0.4,
        ),
);

Psym(Pseq("abaa"),r).play;
)

(
r = (
        a: Pbind(
                \instrument, \sinGrains,
                \freq0, 944,
                \freq1, 955,
                \dur, Pser([0.2,0.3], 3),
                \cloudDur, Pkey(\dur),
                \grainDur, Pwhite(0.01, 0.1),
                \amp, 0.4,
        ),
        b: Pbind(
                \instrument, \sinGrains,
                \freq0, 244,
                \freq1, 205,
                \dur, Pser([0.2,0.3], 5),
                \cloudDur, Pkey(\dur),
                \grainDur, Pwhite(0.01, 0.1),
                \amp, 0.4,
        ),
);

Psym(Pseq("abaa"),r).play;
)

(
r = (
        a: Pbind(
                \instrument, \sinGrains,
                \freq0, 944,
                \freq1, 955,
                \dur, Pser([0.2,0.3], 3),
                \cloudDur, Pkey(\dur),
                \grainDur, Pwhite(0.01, 0.03),
                \trigRate, Pwhite(30, 80),
                \amp, 0.4,
        ),
        b: Pbind(
                \instrument, \sinGrains,
                \freq0, 244,
                \freq1, 205,
                \dur, Pser([0.2,0.3], 5),
                \cloudDur, Pkey(\dur),
                \grainDur, Pwhite(0.01, 0.03),
                \trigRate, Pwhite(30, 80),
                \amp, 0.4,
        ),
);

Psym(Pseq("abaa"),r).play;
)

(
// max size of harmonic field n = 10
// see NamedControl help for syntax \freqs.kr

n = 10;
n.do { |i|
SynthDef(\sinGrains2_ ++ (i+1).asSymbol  , {  arg out = 0, amp = 0.5,
grainDur = 0.1,
        cloudDur = 1, trigRate = 20, prob = 1;
        var signal, env, imp;
        env= EnvGen.ar(Env.sine(cloudDur), levelScale: amp, doneAction:
2);
        imp = Impulse.kr(trigRate);
        signal = GrainSin.ar(2,
                // trigger is multiplied with 0 or 1 according to prob
                imp * Demand.kr(imp, 0, Dwrand([0, 1], [1 - prob,
prob], inf)),
                grainDur,
                Dseq(\freqs.kr(400!(i+1)), inf)
        ) * env ;
   signal = Out.ar(out, signal * amp ) ;
}).add;
}
)


Synth(\sinGrains2_8, [\freqs, (1..8) * 100])

Synth(\sinGrains2_5, [\freqs, (1..5) * 100])


// compare "wrong" SynthDefs taken for freq size

Synth(\sinGrains2_8, [\freqs, (1..5) * 100])

Synth(\sinGrains2_2, [\freqs, (1..5) * 100])


// so in the Pbind the instrument must be taken according to array size,
// you can take a Function for that, as said, arrays must be wrapped
in Pbind,
// Function takes that into account (.first before .size)

~getInst = { |e| (\sinGrains2_ ++ (e.freqs.first.size).asString) }


(
p = Pbind(
        \freqs, Pseq([ [[400, 450, 490]], [[500, 570, 595, 620, 675]] ], inf),
        \instrument, Pfunc (~getInst),
).play
)

p.stop;

// or if you have your freq array defined

~freqs = [[400, 450, 490], [500, 570, 595, 620, 675], [250, 280, 310,
340, 550, 720, 870, 930, 1000, 1050]];

// then you can wrap items like that for the Pbind

~freqs.collect(`_);
~freqs.collect([_]);

p = Pbind(
        \freqs, Pseq(~freqs.collect(`_), inf),
        \instrument, Pfunc(~getInst)
).play

p.stop;


}))
if(SinOsc.ar(440,0,1)> 0.25,{ "hello".postln; }); 