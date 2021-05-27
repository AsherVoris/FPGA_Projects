These two screenshots demonstrate the end of frame condition for the controller.

Seen in the modelsim screenshot is when the horizontal counter hits 799 and generates 
its terminal count pulse, this enables the vertical counter which then ticks over to
524. At 524 it resets generating a new frame and activating the in active area (IAA) pulse.

Seen in the Signal Tap Screenshot are the counter bit values and the terminal count value. 
As with the modelsim, when the tc pulse is generated, the vertical counter ticks over to 524.
At this time the horizontal ticks over to 1 and then the vertical counter resets.
