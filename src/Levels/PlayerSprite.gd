extends AnimatedSprite

onready var player = get_parent()


func _process(_delta):
	sprite_animate()


# this is a mess
func sprite_animate() -> void:
	var sprite_red = Global.opponent_state == 'evade'
	
	if Input.is_action_pressed("jump"):
		play("cat_jump") if sprite_red else play("cat_jump_green") 
	elif player.is_on_wall():
		play("cat_wall_hold") if sprite_red else play("cat_wall_hold_green") 
	elif Input.is_action_pressed("move_left"):
		if player.is_on_floor():
			play("cat_walk") if sprite_red else play("cat_walk_green") 
		else: 
			play("cat_idle") if sprite_red else play("cat_idle_green") 
		set_flip_h(true)
	elif Input.is_action_pressed("move_right"):
		if player.is_on_floor():
			play("cat_walk") if sprite_red else play("cat_walk_green") 
		else:
			play("cat_idle") if sprite_red else play("cat_idle_green") 
		set_flip_h(false)
	else:
		play("cat_idle") if sprite_red else play("cat_idle_green")
