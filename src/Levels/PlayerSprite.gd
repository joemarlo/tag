extends AnimatedSprite

onready var player = get_parent()


func _process(_delta):
	sprite_animate()


func sprite_animate() -> void:
	if Input.is_action_pressed("jump"):
		play("cat_jump")
	elif player.is_on_wall():
		play("cat_wall_hold")
	elif Input.is_action_pressed("move_left"):
		play("cat_walk") if player.is_on_floor() else play("cat_idle")
		set_flip_h(true)
	elif Input.is_action_pressed("move_right"):
		play("cat_walk") if player.is_on_floor() else play("cat_idle")
		set_flip_h(false)
	else:
		play("cat_idle")
	
