extends Opponent_state
class_name Opponent_state_chase


func _ready():
	print('opponent state: chase')
	freeze_character(self, opponent_sprite)
	# ensure sprite is correct color (sometimes is sticky when fast tagging)
	player_sprite.modulate = Color(1, 1, 1)


func _process(delta):
	stopwatch(delta)


func _physics_process(delta):
	chase()


func chase() -> void:
	var velocity = Vector2.ZERO
	if player:
		velocity = opponent.position.direction_to(player.position) * run_speed
	velocity = opponent.move_and_slide(velocity)
	flip_sprite(velocity)
