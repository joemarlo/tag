extends Actor

#https://kidscancode.org/godot_recipes/ai/chase/

var run_speed = 800.0
var velocity = Vector2.ZERO
onready var player = get_node("../Player")


func _init():
	speed = Vector2(600.0, 1400.0)


func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	#get_node("VisibilityEnabler2D").set_enabler(3, true)


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	
	# don't do anything if below the object
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	
	# otherwise shake camera and delete the node (i.e. kill enemy)
	get_node("../Player/Camera2D").add_trauma(0.45)
	queue_free()


func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	velocity = move_and_slide(velocity)

#func _physics_process(delta: float) -> void:
#	_velocity.y += gravity * delta
#	if is_on_wall():
#		_velocity *= -1.0
#	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

