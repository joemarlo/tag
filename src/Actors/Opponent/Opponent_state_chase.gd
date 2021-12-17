extends Opponent_state
class_name Opponent_state_chase

var chase_radius_switch = 200


func _ready():
	print('opponent state: chase')
	Global.opponent_state = 'chase'
	stall(self)
	opponent.set_collision_mask_bit(4, false)
	Global.stopwatch = 0.0


func _process(delta):
	stopwatch.add_to_stopwatch(delta)


func _physics_process(delta):
	chase()


func chase() -> void:
	var velocity = Vector2.ZERO
	var chase_close = opponent.position.distance_to(player.position) < chase_radius_switch
	var destination = player.position if chase_close else get_nav_path(opponent.position, player.position)
	
	if player:
		velocity = opponent.position.direction_to(destination) * run_speed
		randomize()
		velocity = velocity * rand_range(0.1, 1.9)
	velocity = opponent.move_and_slide(velocity)
	flip_sprite(velocity)


func get_nav_path(current_position, destination) -> Vector2:
	var closest_point_in_mesh_current = nav_mesh.get_closest_point(current_position)
	var closest_point_in_mesh_destination = nav_mesh.get_closest_point(destination)
	if closest_point_in_mesh_current != current_position:
		return closest_point_in_mesh_current
	
	var path = nav_mesh.get_simple_path(current_position, closest_point_in_mesh_destination)[1]
	if path == null: path = closest_point_in_mesh_current
	return path
