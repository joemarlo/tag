extends AnimatedSprite

onready var player = get_parent()

func _ready():
	#$SpriteTrail.active = true
	pass


func _process(_delta):
	sprite_animate()


func sprite_animate() -> void:
	if Input.is_action_pressed("move_left"):
		play("cat_walk")
		set_flip_h(true)
	elif Input.is_action_pressed("move_right"):
		play("cat_walk")
		set_flip_h(false)
	elif Input.is_action_just_pressed("jump"):
		play("cat_jump")
	else:
		play("cat_idle")
	
	if player.is_on_wall():
		stop()
