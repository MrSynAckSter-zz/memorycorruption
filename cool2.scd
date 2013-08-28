 TempoClock.default.tempo_(180/60);
 clock = ExternalClock(TempoClock.default);
 clock.play;

 sf= BBCutBuffer("sounds/break",8);

 Routine.run({
  s.sync; // this tells the task to wait
  // below here, we know all out Buffers are loaded
   . . .
 })

cut = BBCut2(CutBuf3(sf)).play(clock);

 cut = BBCut2(CutBuf3(sf, 0.4), BBCutProc11.new).play(clock);



(
 var clock, sf, cut;

 TempoClock.default.tempo_(200/60);
 clock = ExternalClock(TempoClock.default);
 clock.play;

 sf= BBCutBuffer("sounds/break",8);

 Routine.run({
  s.sync; // this tells the task to wait

  cut = BBCut2(CutBuf3(sf, 0.4), BBCutProc11(16, 7, 3, 1, 3, 2, 0.5)).play(clock);

  30.wait; //  // let things run for 30 seconds

  cut.stop;
  cut.free;
 })
)

//  The default clock.  90 is the BPM / 60 for the number of seconds in a minute
 	TempoClock.default.tempo_(130/60);

 	// BBCut uses it's own clock class. We're using the default clock as a base
 	clock= ExternalClock(TempoClock.default);
 	clock.play;

	dub = (instrument:\MCLDdub, out:0, bpm:90, amp: 0.09, pan:0, dur:inf).play(clock.tempoclock);