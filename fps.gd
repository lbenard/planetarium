extends Label

export var average_range = 10;
export var last_frames = [];

func _process(delta):
	if delta != 0:
		while last_frames.size() >= average_range:
			last_frames.pop_back();
		var frame_time = 1.0 / delta;
		if frame_time < 5000.0 && frame_time > 0.0:
			last_frames.push_front(frame_time);

		var total = 0.0;
		for frame in last_frames:
			total += frame;
		var average = total / last_frames.size();

		text = "FPS: " + str(average);
