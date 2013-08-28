(
var notes, on, off;

MIDIClient.init;
MIDIIn.connectAll;


notes = Saw.ar(500);   // array has one slot per possible MIDI note

on = MIDIFunc.noteOn({ |veloc, num, chan, src|
    notes[num] = Synth(\default, [\freq, num.midicps,
        \amp, veloc * 0.00315]);
});

off = MIDIFunc.noteOff({ |veloc, num, chan, src|
    notes[num].release;
});

q = { on.free; off.free; };
)
// when done:q.value;
q.value;



///////////////////////////////////////////////////////////////////////
///////// This is the example to control a synth def (below)
///////////////////////////////////////////////////////////////////


(


MIDIIn.connectAll;
s = Server.local;
s.boot;
s.latency = 0;

SynthDef("sik-goo", { arg freq=440,formfreq=100,gate=0.0,bwfreq=800;
	var x;
	x = Formant.ar(
	SinOsc.kr(0.02, 0, 10, freq),
			formfreq,
			bwfreq
			);
	x = EnvGen.kr(Env.adsr, gate,Latch.kr(gate,gate)) * x;
	Out.ar(0, x);
}).send(s);

x = Synth("sik-goo");

//set the action:
MIDIIn.noteOn = {arg src, chan, num, vel;
				x.set(\freq, num.midicps / 4.0);
				x.set(\gate, vel / 200 );
				x.set(\formfreq, vel / 127 * 1000);
			};

MIDIIn.noteOff = { arg src,chan,num,vel;
				x.set(\gate, 0.0);
			};
MIDIIn.bend = { arg src,chan,val;
				//(val * 0.048828125).postln;
				x.set(\bwfreq, val * 0.048828125 );
			};
)


/////////////////////////////////////////////////////////////
/////2 Ugens



s = Server.local;

s.boot;


MIDIClient.init;
MIDIIn.connectAll;


(

s.latency = 0;

SynthDef("moto-rev", { arg ffreq=100;

	var x;

	x = RLPF.ar(Gendy1.ar(Saw.kr(0.2, 0, 10, 21), [0,0.1], 0.1),

			 ffreq, 0.1)

			 .clip2(0.4);

	Out.ar(0, x);

}).send(s);

)

b = Bus.control(s);



x = Synth("moto-rev");



// map the synth's first input (ffreq) to read

// from the bus' output index

x.map(0,b.index);





MIDIIn.connect;

//set the action:

MIDIIn.noteOn = {arg src, chan, num, vel;

				b.value = num.midicps.postln;

			};



MIDIIn.control = {arg src, chan, num, val;

				[chan,num,val].postln;

			};

MIDIIn.bend = {arg src, chan, val;

				val.postln;

			};

)



// cleanup

x.free;

b.free;



/////////////////////////////////////////////////////////


s = Server.local;

s.boot;



(

s.latency = 0;

SynthDef("moto-rev", { arg ffreq=100;

	var x;

	x = LFClipNoise.ar(LFPulse.ar(Saw.kr(0.2, 0, 10, 21), [0,0.1], 0.1),

			 ffreq, 0.1)

			 .clip2(0.4);

	Out.ar(0, x);

}).send(s);
)


b = Bus.control(s);



x = Synth("moto-rev");



// map the synth's first input (ffreq) to read

// from the bus' output index

x.map(0,b.index);





MIDIIn.connect;

//set the action:

MIDIIn.noteOn = {arg src, chan, num, vel;

				b.value = num.midicps.postln;

			};



MIDIIn.control = {arg src, chan, num, val;

				[chan,num,val].postln;

			};

MIDIIn.bend = {arg src, chan, val;

				val.postln;

			};

)


// cleanup

x.free;

b.free;

//////////////////////////////////

