//Great Distortion for Vocals and Contact Mics

(
{
	var in, amount, amCoef;
	in = BPF.ar(SoundIn.ar(0), 400)* 50;//The last value is the amount of distortion
	amount = 0.99;
	amCoef= 2*amount/(1-amount);
	MidEQ.ar(LPF.ar((1+amCoef)*in/(1+(amCoef*in.abs)), [3800, 3900])*0.5, 9120, 0.9999, 8);
}.play;
)

//Feedback

//

(
{
	var in, amount, amCoef;
	in = LPF.ar(SoundIn.ar(0), 400)* 50;//The last value is the amount of distortion
	amount = 0.99;
	amCoef= 2*amount/(1-amount);
	MidEQ.ar(LPF.ar((1+amCoef)*in/(1+(amCoef*in.abs)), [3800, 3900])*0.5, 9120, 0.9999, 8);
}.play;
)


//

(
{
	var in, amount, amCoef;
	in = HPF.ar(SoundIn.ar(0), 400)* 50;//The last value is the amount of distortion
	amount = 0.99;
	amCoef= 2*amount/(1-amount);
	MidEQ.ar(LPF.ar((1+amCoef)*in/(1+(amCoef*in.abs)), [3800, 3900])*0.5, 9120, 0.9999, 8);
}.play;
)
