extends ParallaxLayer

export(float) var speed: = -15
var base_offset = -900

func _process(delta) -> void:
	self.motion_offset.y = (Global.stopwatch * speed) + base_offset
