/* Backgrounds (Set 1)

This is the set for The Silent Barn

*/

// Deprecated noise synth def FIX ME PLEASE



(

SynthDef.new(\noise1, {
		| freq = 440, noiseHz=12, gate =1, sustain =1, amp = 0.25, width = 0.15, preamp = 5|
		var freq, amp, sig, mod;
	    freq = LFTri.kr(noiseHz).exprange(200,1000);
		amp = Klank.ar(`[ {exprand(200, 5000)}.dup(22), nil, nil ], GrayNoise.ar(0.05));
		sig = Saw.ar(Latch.ar(GrayNoise.ar, SyncSaw.ar(9)) * 400 + 800 + freq, 4, 0.2) * EnvGen.kr(env, gate, doneAction:2) * amp;
	   	Out.ar(0, sig ! 2)
	    }).add;

)


(
SynthDef( \tirescreaching, // rename to tiresynth
	{| freq = 440, gate =1, sustain =1, amp = 0.25, width = 0.15, preamp = 5|
		var sig,
		env = Env.adsr(0.01, 0.1, 0.1, 0.01);
		sig = Saw.ar(Latch.ar(GrayNoise.ar, SyncSaw.ar(9)) * 400 + 800 + freq, 4, 0.2) * EnvGen.kr(env, gate, doneAction:2) * amp;
		Out.ar(0, sig ! 2)
	}).add

)



//

(
var notes, on, off;

MIDIClient.init;
MIDIIn.connectAll;

notes = Array.newClear(128);   // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    notes[num] = Synth(\noise1, [\freq, num.midicps,
        \amp, veloc * 0.00315]);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    notes[num].release;
});

q = { on.free; off.free; };
)


///////////////////////Exhibit Aalt/////////////////// Gray noise based noise synth def for midi





(
SynthDef( \tirescreaching, // rename to tiresynth
	{| freq = 440, gate =1, sustain =1, amp = 0.25, width = 0.15, preamp = 5|
		var sig,
		env = Env.adsr(0.01, 0.1, 0.1, 0.01);
		sig = Saw.ar(Latch.ar(GrayNoise.ar, SyncSaw.ar(9)) * 400 + 800 + freq, 4, 0.2) * EnvGen.kr(env, gate, doneAction:2) * amp;
		Out.ar(0, sig ! 2)
	}).add

)



///

(
var notes, on, off;

MIDIClient.init;
MIDIIn.connectAll;

notes = Array.newClear(128);   // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    notes[num] = Synth(\tirescreaching, [\freq, num.midicps,
        \amp, veloc * 0.00315]);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    notes[num].release;
});

q = { on.free; off.free; };
)


//////////////Exhibit B//////////////
////////////////////////////////////


(
SynthDef.new(\interesting, {
		arg noiseHz=8;
		var freq, amp, sig;
		freq = PinkNoise.kr(noiseHz).exprange(200,1000);
		amp = LFNoise0.kr(12).exprange(0.02,1);
		sig = SyncSaw.ar(freq) * amp;
		Out.ar(0, sig);
	}).add;
)


///

(
var notes, on, off;

MIDIClient.init;
MIDIIn.connectAll;

notes = Array.newClear(128);   // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    notes[num] = Synth(\interesting, [\freq, num.midicps,
        \amp, veloc * 0.00315]);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    notes[num].release;
});

q = { on.free; off.free; };
)




//////////////////////Exhibit C///////////////////
//////////////////////////////////////////////////



play{Limiter.ar(GVerb.ar(sin(Ringz.ar(SinOsc.ar(2**Gendy3.ar(3!3).range(1,5).round/1.2),[40,200,134,589,1320,190],0.7).sum),5,2,0.7)/1.5)}



///////////////Exhibit D//////////////////////////
////////////////////////////////////////////////


{
// below we declare our variables with 'var'
var input, fBLoopIn, fBLoopOut, processing;
// input is our sound source, a little noise

	input =   Limiter.ar(GVerb.ar(sin(Ringz.ar(SinOsc.ar(2**LFNoise2.ar(2!10.2).range(2,8.9).round/3.9),
		[1370,10,234,389,1320,250],25,1,7.364).sum),1.5,8,0.649)/2.4);
// fBLoopIn is our feedback loop insertion point.

	fBLoopIn =LocalIn.ar(2);
// in processing, we mix the input with the feedback loop
// here MouseX is being used to control the gain of the feedback signal

	processing = input +LeakDC.ar((DelayN.ar(fBLoopIn,0.5,0.5, *MouseX.kr(0,3))));
// fBLoopOut is our feedback loop output point

	fBLoopOut =LocalOut.ar(processing);processing =Limiter.ar(processing,0.8);
// Out routes the audio to the speakers. the square brackets send the output to both left
// and right channels.
Out.ar([0,1], processing);
}.play


//////////////////////////////////////////////////////
////Feedback loop (tap the built in microphone several times)
/////Yes it really works just hit the computer a bit, remember?



(

{
// below we declare our variables with 'var'
var input, fBLoopIn, fBLoopOut, processing, speed;
speed = LFNoise0.kr(0.5,2,2.1);
// input is our sound source, a little noise -- note the lowered amplitude
// of 0.15
input = SoundIn.ar(0);
// fBLoopIn is our feedback loop insertion point.
fBLoopIn = LocalIn.ar(1);
// in processing, we mix the input with the feedback loop
// the delay time of the DelayN UGen is controlled by the
// 'speed' variable. The gain is now fixed at 1.1.
processing = input + LeakDC.ar((DelayN.ar(fBLoopIn,3.5, speed,1.1)));
// use a resonant low-pass filter that moves at various rates
// determined by the 'speed' variable with frequencies between 400 - 1200
processing =RLPF.ar(processing,LFNoise0.kr(speed,400,800),0.15);
// fBLoopOut is our feedback loop output point
fBLoopOut = LocalOut.ar(processing);
// signal threshold a "low-rent gate"
processing = processing.thresh(0.45);
// our limiter
processing = Limiter.ar(processing);
// add some equal-power panning
processing = Pan2.ar(processing, (speed - 2) * 0.5);
// notice removed brackets because Pan2 is a multi-channel UGen
// and SC has multichannel expansion for free ;)
Out.ar(0, processing);
}.play
)

//////////////////////////Exhibit E////////////////////////////////
////////////////////////////////////////////////////////////////////



{ Saw.ar(Latch.ar(GrayNoise.ar, SyncSaw.ar(9)) * 400 + 800, 4, 0.2) }.play;




///////////////////////Exhibit F/////////////////////////////////////
//////////////////////////////////////////////////////////////////////



{ Klank.ar(`[[200, 671, 1153, 1723], nil, [1, 1, 1, 1]], GrayNoise.ar(8, 0.1)) }.play;



{ Klank.ar(`[[200, 671, 1153, 1723], nil, [1, 1, 1, 1]], ClipNoise.ar(0.007)) }.play;



{ Klank.ar(`[ {exprand(200, 5000)}.dup(22), nil, nil ], BrownNoise.ar(0.05)) }.scope(1);



{ Klank.ar(`[ (1..300)*200, 1/(1..6.34), nil ], GrayNoise.ar(0.05)) }.scope(1);



{ Klank.ar(`[ (1,1..363)*200, -3/(2,3..368), nil ], ClipNoise.ar(0.08)) }.scope(1);



///////////////////////////Exhibit G////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
/////////////////////Another feedback loop////////////
/////////////////////Slow Build up//////////////////////////////
(

{
// below we declare our variables with 'var'
var input, fBLoopIn, fBLoopOut, processing, speed;
speed =LFNoise0.kr(0.5,2,2.05);
// input is our sound source, a little noise -- note the lowered amplitude
// of 0.15
input =Crackle.ar(1.5,0.15);
// fBLoopIn is our feedback loop insertion point.
fBLoopIn =LocalIn.ar(1);
// in processing, we mix the input with the feedback loop
// the delay time of the DelayN UGen is not controlled by the
// 'speed' variable. The gain is now fixed at 1.1.
processing = input +LeakDC.ar((DelayN.ar(fBLoopIn,3.5, speed,1.1)));
// use a resonant low-pass filter that moves at various rates
// determined by the 'speed' variable with frequencies between 400 - 1200
processing =RLPF.ar(processing,LFNoise0.kr(speed,400,800),0.5);
// square off the wave form (distortion)
processing = processing.clip;
// fBLoopOut is our feedback loop output point
fBLoopOut =LocalOut.ar(processing);
// Out routes the audio to the speakers. the square brackets send the output to both left
// and right channels.
Out.ar([0,1], processing);
}.play

)

////////////////////////////Ehibit H//////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////



x = { LFNoise0.ar(245, Line.ar(0, 1, 100)).fold2(SinOsc.ar(677).range(0, 0.9)) ! 2 }.play;
x.free;

// line.ar example

{ BrownNoise.ar(20).lag(0.1).fold2(SinOsc.ar(400).range(0, 0.9)) ! 2}.scope;



////////////////////////Exhibit I//////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////Awesome Rhythm/////////////////////



play{Limiter.ar(GVerb.ar(sin(Ringz.ar(SinOsc.ar(2**LFNoise0.ar(1!3).range(1,15).round/1.2),[40,200,234,889,1320,150],0.7).sum),5,2,0.7)/2)}



//////////////////////Exhibit J//////////////////////////////////////
///////////////////////////////////////////////////////////////////



play{Limiter.ar(GVerb.ar(sin(R.ingz.ar(Impulse.ar(2**LFNoise0.ar(1!2).range(1,4).round),[40,200,234,889],0.7).sum*2),5,2,0.7))}


/////////////////////Exhibit K///////////////////////////////////
///////Rhythmic synth/////////////////////////////////////////////



play{Limiter.ar(GVerb.ar(sin(Ringz.ar(Impulse.ar(2**LFNoise0.ar(1!3).range(1,5).round/2),[40,200,234,889,1320,150],0.7).sum),5,2,0.7)/2)}



///////////////////////Exhibit L/////////////////////////////////
/////////////////////////////////////////////////////////////////
//////Mouse Control Phase offset

// Resonator, must subtract blockSize for correct tuning
(
SynthDef("testRes", {

var freq = 300, localIn, input, limitLevel = 0.2, output;
var feedbackAmt = 0.999;

freq = MouseY.kr(20, 678, \exponential).poll;
feedbackAmt = MouseX.kr(0.2, 0.99999).poll;
localIn = LocalIn.ar(1);
input = LFNoise1.ar(freq * 16, 0.2);
input = input + Dust2.ar(freq);


LocalOut.ar(
	HPF.ar(LPF.ar(DelayC.ar(input + (localIn * feedbackAmt), 2, freq.reciprocal - ControlRate.ir.reciprocal), freq * 8), freq * 0.125)
);

output = Limiter.ar(localIn, limitLevel, 0.01) * limitLevel.reciprocal;
OffsetOut.ar(0, output ! 2);

}).play(s);

)


///////////////////Exhibit M////////////////////////////////////
//////////////////////////////////////////////////////////////////
//mouse controls lfo volume in the x axis and band pass filter cut off in y, bit of randomness on the cutoffs and mucho glitchiness results



(
{BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(MouseX.kr(0,8),phase:Rand (0,pi), mul:Rand( 0.1,1) )),MouseY.kr(0,20000) * Rand(0,400)  ) +

BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(MouseX.kr(0,8),phase:Rand (0,pi), mul:Rand( 0.1,1) )),MouseY.kr(0,20000) * Rand(0,400) )  +

BPF.ar(WhiteNoise.ar(mul: SinOsc.ar(MouseX.kr(0,8),phase:Rand (0,pi), mul:Rand( 0.1,1) )),MouseY.kr(0,20000) * Rand(0,400)  )     }.scope;
)


///////////////////////////////Exhibit N/////////////////////////
//////////////////////////////////////////////////////////////////

