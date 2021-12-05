extends Opponent_state
class_name Opponent_state_evade

func _ready():
	#animated_sprite.play("idle")
	print('opponent state: evade')
	pass


func _physics_process(delta):
	var velocity = Vector2.ZERO
	if player:
		velocity = opponent.position.direction_to(player.position) * run_speed
	velocity = opponent.move_and_slide(velocity)
	flip_sprite(velocity)

