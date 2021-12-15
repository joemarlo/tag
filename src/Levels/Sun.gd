extends ParallaxLayer

export(float) var speed: = -15
var base_offset = -600

func _process(delta) -> void:
	self.motion_offset.y = (Global.stopwatch * speed) + base_offset
