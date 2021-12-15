extends Opponent_state
class_name Opponent_state_evade

var evade_radius = 700
var velocity = Vector2.ZERO


func _ready():
	print('opponent state: evade')
	Global.opponent_state = 'evade'
	stall(player)
	opponent.set_collision_mask_bit(4, true)
	Global.stopwatch = 0.0


func _process(delta):
	stopwatch.add_to_stopwatch(-delta)


func _physics_process(delta):
	evade(delta)


func evade(delta) -> void:
	if player:
		if opponent.position.distance_to(player.position) < evade_radius:
			velocity = -opponent.position.direction_to(player.position) * run_speed
			randomize()
			velocity = velocity * rand_range(0.25, 1.75)
	velocity = opponent.move_and_slide(velocity)
	velocity.y += gravity * delta # add gravity only during evade so opponent doesn't float away
	flip_sprite(velocity)
