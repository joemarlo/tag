extends Opponent_state
class_name Opponent_state_chase

signal opponent_chase


func _ready():
	print('opponent state: chase')
	Global.opponent_state = 'chase'
	stall(self)
	opponent.set_collision_mask_bit(4, false)


func _process(delta):
	stopwatch.add_to_stopwatch(delta)


func _physics_process(delta):
	chase()


func chase() -> void:
	var velocity = Vector2.ZERO
	if player:
		velocity = opponent.position.direction_to(player.position) * run_speed
		randomize()
		velocity = velocity * rand_range(0.1, 1.9)
	velocity = opponent.move_and_slide(velocity)
	flip_sprite(velocity)
#	self.set_collision_layer()
