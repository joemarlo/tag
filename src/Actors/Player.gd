extends Actor
class_name Player

export var stomp_impulse = 1000.0
var n_jumps: = 0
var can_jump: = false
var friction = Vector2(0.15, 0.0) #friction.y not implemented
var wall_friction = 0.6 # multiplier
var enemy_time_penalty = -3
onready var _sprite = $AnimatedSprite


func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	time_penalty() #TODO: sometimes this doesn't work b/c collision shapes?


#	# freeze player sprite
#	set_physics_process(false)
#	_sprite.set_process(false)
#	_sprite.stop()
#	_sprite.play("cat_die")
#
#	# shake camera
#	$Camera2D.add_trauma(0.8)
#
#	# flash sprite color red
#	flash_sprite()
#
#	# pause before showing menu
#	yield(get_tree().create_timer(2), "timeout")
#
#	# delete player
#	set_physics_process(true)
#	_sprite.set_process(true)
#	queue_free()
#
#	# restart game
#	get_tree().change_scene("res://src/Levels/LevelTemplate.tscn")


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL, true) 
	can_jump = can_jump()


func flash_sprite() -> void:
	_sprite.modulate = Color("#f25c5c")
	yield(get_tree().create_timer(0.08), "timeout")
	_sprite.modulate = Color(1, 1, 1)
	yield(get_tree().create_timer(0.08), "timeout")
	_sprite.modulate = Color("#f25c5c")
	yield(get_tree().create_timer(0.08), "timeout")
	_sprite.modulate = Color(1, 1, 1)


func get_direction() -> Vector2:
	var direction_x: = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var direction_y: = -1.0 if Input.is_action_just_pressed("jump") and can_jump else 0.0
	
	return Vector2(direction_x, direction_y)


func can_jump() -> bool:
	n_jumps += int( Input.is_action_just_pressed("jump") )
	n_jumps = 0 if is_on_floor() else n_jumps
	n_jumps = 1 if is_on_wall_and_input() else n_jumps
	var can_jump: = is_on_floor() \
		or is_on_wall_and_input() \
		or (n_jumps < 2)
	return can_jump


func is_on_wall_and_input() -> bool:
	return is_on_wall() and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"))


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = lerp(out.x, speed.x * direction.x, friction.x)
	out.y += gravity * get_physics_process_delta_time()
	if direction.y != 0.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	if is_on_wall_and_input():
		var _wall_friction = 1 if Input.is_action_pressed("jump") else wall_friction
		out.y = out.y * _wall_friction
	return out


func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out


func time_penalty() -> void:
	# add time to stopwatch
	Global.stopwatch += enemy_time_penalty
