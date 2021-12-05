extends Actor
class_name Opponent

#https://kidscancode.org/godot_recipes/ai/chase/

var run_speed = 800.0
onready var player = get_node("../Player")


func _init():
	speed = Vector2(600.0, 1400.0)


func _physics_process(delta):
	var velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	velocity = move_and_slide(velocity)

