extends Label

export var average_range = 10;
var last_frames = [];

func _process(delta):
	if delta != 0:
		while last_frames.size() >= average_range:
			last_frames.pop_back();
		last_frames.push_front(1.0 / delta);
		
		var total = 0.0;
		for frame in last_frames:
			total += frame;
		var average = total / last_frames.size();
		
		text = "FPS: " + str(average);
