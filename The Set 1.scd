/////////////////Backgrounds (Set 1)////////////////
////////////////////////////////////////////////////

/////Exhibit A//////



(

SynthDef.new(\noise1, {
		arg noiseHz=12;
		var freq, amp, sig, mod;
	    freq = LFTri.kr(noiseHz).exprange(200,1000);
		amp = Klank.ar(`[ {exprand(200, 5000)}.dup(22), nil, nil ], GrayNoise.ar(0.05));
		sig = Gendy2.ar(freq) * amp;
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
    notes[num] = Synth(\noise1, [\freq, num.midicps,
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

SynthDef.new(\noise3, {
	    var sig;
	    Limiter.ar(GVerb.ar(sin(Ringz.ar(SinOsc.ar(2**LFNoise2.ar(2!10.2).range(2,8.9).round/3.9),
		[1370,10,234,389,1320,250],25,1,7.364).sum),1.5,8,0.649)/2.4);
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
    notes[num] = Synth(\noise3, [\freq, num.midicps,
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

(
{
// below we declare our variables with 'var'
var
input, fBLoopIn, fBLoopOut, processing, speed;
speed = LFNoise0.kr(0.5,2,2.1);
// input is our sound source, a little noise -- note the lowered amplitude
// of 0.15cc
input = SoundIn.ar(0);// fBLoopIn is our feedback loop insertion point.
fBLoopIn = LocalIn.ar(1);
	// in processing, we mix the input with the feedback loop
// the delay time of the DelayN UGen is controlled by the
// 'speed' variable. The gain is now fixed at 1.1.
processing = input +LeakDC.ar((DelayN.ar(fBLoopIn,3.5, speed,1.1)));
9jtplewdd// use a resonant low-pass filter that moves at various rates
// determined by the 'speed' variable with frequencies between 400 - 1200
processing = RLPF.ar(processing,LFNoise0.kr(speed,400,800),0.15);
// fBLoopOut is our feedback loop output point
fBLoopOut = LocalOut.ar(processing);
// signal threshold a "low-rent gate"
processing = processing.thresh(0.45);
// our limiter
processing = Limiter.ar(processing);
// add some equal-power panning
processing = Pan2.ar(processing, (speed -2) *0.5);
// notice removed brackets because Pan2 is a multi-channel UGen
// and SC has multichannel expansion for free ;)
Out.ar(0, processing);}.play

)