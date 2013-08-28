
play{Ringz.ar(CoinGate.ar([5,3,9]/10*Line.kr(0,1,30),T2A.ar(Impulse.kr([4,12,6]))),[45,9e3,50,8e3],[6,1,10,3]/10,[9,2,3,1]).sin.sum.tanh!2}


play{Limiter.ar(GVerb.ar(sin(Ringz.ar(Impulse.ar(2**LFNoise0.ar(1!2).range(1,4).round),[40,200,234,889],0.7).sum*2),5,2,0.7))}

play{Limiter.ar(GVerb.ar(sin(Ringz.ar(Impulse.ar(2**LFNoise0.ar(1!3).range(1,5).round/2),[40,200,234,889,1320,150],0.7).sum),5,2,0.7)/2)}



///////////////Awesome Back Drop////////////
play{Limiter.ar(GVerb.ar(sin(Ringz.ar(SinOsc.ar(2**LFNoise0.ar(1!3).range(1,15).round/1.2),[40,200,234,889,1320,150],0.7).sum),5,2,0.7)/2)}

+

play{Limiter.ar(GVerb.ar(sin(Ringz.ar(SinOsc.ar(2**LFNoise2.ar(2!10.2).range(2,8.9).round/3.9),[1370,10,234,389,1320,250],25,1,7.364).sum),1.5,8,0.649)/2.4)}



////

play{Limiter.ar(GVerb.ar(sin(Ringz.ar(SinOsc.ar(2**Gendy3.ar(3!3).range(1,5).round/1.2),[40,200,134,589,1320,190],0.7).sum),5,2,0.7)/1.5)}



///////////////


(
SynthDef.new("backdrop2", { Out.ar(Limiter.ar(GVerb.ar(sin(Ringz.ar(SinOsc.ar(2**Gendy3.ar(9!3).range(1,5).round/1.2),[40,200,234,889,1320,150],0.7).sum),5,2,0.7)/2)}).send(s);
)
	x = (backdrop2)


SQPushFX2