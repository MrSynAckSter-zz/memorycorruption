
(
SynthDef(\distort, { arg out=0, pregain=40, amp=0.2, gate=1;

var env;

env = Linen.kr(gate, 0.05, 1, 0.1, 2);

XOut.ar(out, env, (SoundIn.ar(out, 2) * pregain).distort * amp);

}, [\ir, 0.1, 0.1, 0]).store;


)


{FreeVerb.ar(SoundIn.ar(0).distort)}.play