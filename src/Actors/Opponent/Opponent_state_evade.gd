extends Opponent_state
class_name Opponent_state_evade

var evade_radius = 1000

func _ready():
	#opponent_sprite.play("idle")
	print('opponent state: evade')


func _physics_process(delta):
	evade()


func evade() -> void:
	var velocity = Vector2.ZERO
	if player:
		if opponent.position.distance_to(player.position) < evade_radius:
			velocity = -opponent.position.direction_to(player.position) * run_speed
			randomize()
			velocity = velocity * rand_range(0.50, 1.5)
	velocity = opponent.move_and_slide(velocity)
	flip_sprite(velocity)
