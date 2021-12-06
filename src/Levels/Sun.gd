extends ParallaxLayer

export(float) var speed: = -15

func _process(delta) -> void:
	self.motion_offset.y = Global.stopwatch * speed
