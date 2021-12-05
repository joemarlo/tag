extends Opponent_state
class_name Opponent_state_chase

func _ready():
	#animated_sprite.play("idle")
	print('opponent state: chase')
	pass


func _flip_direction():
	animated_sprite.flip_h = not animated_sprite.flip_h


func _physics_process(delta):
	var velocity = Vector2.ZERO
	if player:
		velocity = opponent.position.direction_to(player.position) * run_speed
	velocity = opponent.move_and_slide(velocity)

