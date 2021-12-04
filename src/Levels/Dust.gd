extends AnimatedSprite

onready var player = get_parent()


func _process(_delta):
	dust_animate()


func dust_animate() -> void:
	if Input.is_action_pressed("move_left"):
		play("dust") if player.is_on_floor() else play("dust_none")
		set_flip_h(true)
	elif Input.is_action_pressed("move_right"):
		play("dust") if player.is_on_floor() else play("dust_none")
		set_flip_h(false)
	else:
		play("dust_none")
	
