extends AnimatedSprite

func _ready():
	#$SpriteTrail.active = true
	pass


func _process(_delta):
	sprite_animate()


func sprite_animate() -> void:
	if Input.is_action_pressed("move_left"):
		play("run")
		set_flip_h(true)
	elif Input.is_action_pressed("move_right"):
		play("run")
		set_flip_h(false)
	else:
		stop()
