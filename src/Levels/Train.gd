extends ParallaxLayer

export(float) var TRAIN_SPEED: = 950

func _process(delta) -> void:
	self.motion_offset.x += TRAIN_SPEED * delta
