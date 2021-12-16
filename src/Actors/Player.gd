extends Actor
class_name Player

export var stomp_impulse = 1000.0
var n_jumps = 0
var can_jump = false
var friction = Vector2(0.1, 0.0) #friction.y not implemented
var wall_friction = 0.3 # multiplier
var enemy_time_penalty = -3
var enemy_time_bonus = 3
var label_position_offset = Vector2(0, -125)
var label_tween_duration = 1.5
onready var _sprite = $AnimatedSprite
onready var camera = $Camera2D

onready var time_added_tween = $TimeAddedTween
onready var time_added_label = time_added_tween.get_node('TimeAdded')
onready var time_removed_tween = $TimeRemovedTween
onready var time_removed_label = time_removed_tween.get_node('TimeRemoved')


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL, true) 
	can_jump = can_jump()
	

func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)


func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.get_class() == 'Enemy':
		time_penalty()
		camera.add_trauma(0.6)


func get_direction() -> Vector2:
	var direction_x: = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var direction_y: = -1.0 if Input.is_action_just_pressed("jump") and can_jump else 0.0
	
	return Vector2(direction_x, direction_y)


func can_jump() -> bool:
	n_jumps += int( Input.is_action_just_pressed("jump") )
	n_jumps = 0 if is_on_floor() else n_jumps
	n_jumps = 1 if wall_hold() else n_jumps
	can_jump = is_on_floor() \
		or wall_hold() \
		or (n_jumps < 2)
	return can_jump


func wall_hold() -> bool:
	return is_on_wall() and \
		(Input.is_action_pressed("move_left") or \
		Input.is_action_pressed("move_right")) #or \
#		Input.is_action_pressed("wall_hold"))


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
	if wall_hold():
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
	
	# show label
	time_removed_label.set_global_position(self.get_global_position() + label_position_offset)
	time_removed_label.modulate.a = 0.95
	time_removed_tween.interpolate_property(time_removed_label, "modulate:a", 0.95, 0, label_tween_duration)
	time_removed_tween.start()


func time_added() -> void:
	# remove time from stopwatch
	Global.stopwatch += enemy_time_bonus
	
	# show label
	time_added_label.set_global_position(self.get_global_position() + label_position_offset)
	time_added_label.modulate.a = 0.95
	time_added_tween.interpolate_property(time_added_label, "modulate:a", 0.95, 0, label_tween_duration)
	time_added_tween.start()


func freeze() -> void:
	Global._freeze(self, _sprite)
func unfreeze() -> void:
	Global._unfreeze(self, _sprite)
func flash_sprite() -> void:
	Global._flash_sprite(_sprite)
