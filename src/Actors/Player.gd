extends Actor
class_name Player

export var stomp_impulse = 1000.0
var n_jumps: = 0
var can_jump: = false

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL) 
	flip_sprite()
	can_jump = can_jump()

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and can_jump else 0.0
	)

func can_jump() -> bool:
	n_jumps += int( Input.is_action_just_pressed("jump") )
	n_jumps = 0 if is_on_floor() else n_jumps
	var can_jump: = is_on_floor() or (n_jumps < 2)
	return can_jump

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y != 0.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out

func flip_sprite() -> void:
	var direction: = get_direction().x
	if direction < 0:
		get_node("player").set_flip_h(true)
	elif direction > 0:
		get_node("player").set_flip_h(false)
	
