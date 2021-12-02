extends ParallaxLayer

export(float) var TRAIN_SPEED: = -450


func _process(delta) -> void:
	get_node('Cityscape2').set_flip_h(true)
	self.motion_offset.x += TRAIN_SPEED * delta
